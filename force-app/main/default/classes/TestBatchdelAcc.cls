@isTest
public class TestBatchdelAcc {
    @testSetup static void createData(){
        List<Account> acclist = new List<Account>();
        for(Integer i = 0; i<2000;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acclist.add(acc);
        }
        insert acclist;
    }
    @isTest static void case1(){
        List<Account> acclist = new List<Account>();
        acclist = [select Id,Name from Account];
        //test
        BatchDelAcc bd = new BatchDelAcc();
        BatchUpdateAcc bu = new BatchUpdateAcc();
        Test.startTest();
       	//Database.executeBatch(bd,2000);
        Database.executeBatch(bu,2000);
        Test.stopTest();
        
        //result
        
        system.debug(acclist);
        System.debug(acclist.size());
        System.assertEquals(2000, acclist.size());
    }
}