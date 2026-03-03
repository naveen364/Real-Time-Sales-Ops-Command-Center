@isTest
public class TestRollupAccount {
    @testSetup static void createData(){
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        for(Integer i = 0; i<=10;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            if(Math.mod(i, 2)==0){
            	acc.Type__c = 'Positive';
            }else{
                acc.Type__c = 'Negative';
            }
            acclist.add(acc);
        }
        insert acclist;
        for(Account acc : acclist){
            for(Integer k = 0; k<=10;k++){
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.Amount_X__c = Math.random()*23;
                con.Amount_Y__c = Math.random()*56;
                con.LastName = 'Test'+k;
                conlist.add(con);
            }
        }
        insert conlist;
    }
    @isTest public static void case1(){
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        conlist = [select Id,AccountId,Amount_Y__c,Amount_X__c from Contact];
        acclist = [select Id,Rollup_Amount_X__c,Type__c,Rollup_Amount_Y__c from Account];
        System.debug('conlist'+conlist);
        System.debug('acclist'+acclist);
        if(CheckRecursion.runOnce()){
            Test.startTest();
            upsert conlist;
            Test.stopTest();
        }
    }
}