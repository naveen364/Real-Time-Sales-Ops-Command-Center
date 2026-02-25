@isTest
public class TestStopUpdatingOpp {
    @testSetup static void createData(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<Account> acclist = new List<Account>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        for(Integer i = 0; i<=10;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Working_In__c = 'Asia';
            acclist.add(acc);
        }
        insert acclist;
        for(Account acc : acclist){
            for(Integer i = 0; i<=20;i++){
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.CloseDate = Date.today()+34;
                opp.StageName = 'Closed Won';
                opp.Name = acc.Name+i;
                
                opplist.add(opp);
            }
        }
        insert opplist;
        Product2 pro = new Product2();
        pro.Name = 'Test';
        insert pro;
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = Test.getStandardPricebookId();
        pbe.Product2Id = pro.Id;
        pbe.UnitPrice = 12;
        pbe.IsActive = True;
        insert pbe;
        Integer k = 1;
        for(Opportunity opp : opplist){
            if(Math.mod(k, 2)==0){
                for(Integer i = 0; i<=5;i++){
                    OpportunityLineItem oli = new OpportunityLineItem();
                    oli.Quantity = 12;
                    oli.PricebookEntryId = pbe.Id;
                    oli.TotalPrice = 123;
                    oli.OpportunityId = opp.Id;
                    olilist.add(oli);
                }
                k++;
            }
        }
        insert olilist;
    }
    
    testMethod static void case1(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<Account> acclist = new List<Account>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        opplist = [select Id from Opportunity where Name Like 'Test%'];
        acclist = [select Id from Account where Name Like 'Test%'];
        olilist = [select Id from OpportunityLineItem where OpportunityId In :opplist];
        Test.startTest();
        upsert opplist;
        Test.stopTest();
    }
}