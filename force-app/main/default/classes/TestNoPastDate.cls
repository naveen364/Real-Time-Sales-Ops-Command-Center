@isTest
public class TestNoPastDate {
    @testSetup public static void createData(){
        List<Opportunity> opplist = new List<Opportunity>();
        for(Integer i = 0; i<=4;i++){
            Opportunity opp = new Opportunity();
            opp.CloseDate =Date.today()-99;
            opp.Name = 'Test'+i;
            opp.StageName = 'Closed Won';
            opplist.add(opp);
        }
        try{
            insert opplist;
        }catch(Exception e){
            System.assert(e.getMessage().contains('Please enter a future Closed Date'));
        }
    }
    testMethod static void case1(){
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,Name,AccountId from opportunity where Name Like 'Test%'];
        try{
            Test.startTest();
            upsert opplist;
            Test.stopTest();
        }catch(Exception e){
            System.assert(e.getMessage().contains('Please enter a future Closed Date'));
        }
    }
}