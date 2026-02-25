@isTest
public class TestOpportunitycloneContactRoleRelative {
    @testSetup public static void createData(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        for(Integer i = 0; i<=4;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Match_Billing_Address__c = true;
            acclist.add(acc);
        }
        insert acclist;
        for(Account acc : acclist){
            for(Integer j=0;j<=2;j++){
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = acc.Name; 
                conlist.add(con);
            }
        }
        insert conlist;
        for(Account acc : acclist){ 
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.CloseDate =Date.today()+49;
            opp.Name = acc.Name;
            opp.StageName = 'Close Won';
            opplist.add(opp);
        }
        insert opplist; 
    }
    testMethod public static void case1(){
        List<Account> acclist = new List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        List<Contact> conlist = new List<Contact>();
        acclist = [select Id,Name from Account where Name Like 'Test%'];
        conlist = [select Id,AccountId,Name from Contact where LastName Like 'Test%'];
        opplist = [select Id,Name,AccountId from opportunity where Name Like 'Test%'];
        
        Test.startTest();
        upsert acclist;
        Test.stopTest();
    }
}