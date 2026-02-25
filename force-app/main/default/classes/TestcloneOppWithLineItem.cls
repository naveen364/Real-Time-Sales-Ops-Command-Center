@isTest
public class TestcloneOppWithLineItem {
    @testSetup public static void createData(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        List<Product2> prolist = new List<Product2>();
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        for(Integer i = 0; i<=4;i++){
            Opportunity opp = new Opportunity();
            opp.CloseDate =Date.today()+49;
            opp.Name = 'Test'+i;
            opp.StageName = 'Closed Won';
            opplist.add(opp);
        }
        insert opplist;
        
        for(Integer i = 0; i<=4;i++){
            Product2 pro = new Product2();
            pro.Name = 'Test'+i;
            prolist.add(pro);
        }
        insert prolist;
        for(Product2 pro : prolist){
            PricebookEntry pbe = new PricebookEntry();
            pbe.Pricebook2Id = Test.getStandardPricebookId();
            pbe.Product2Id = pro.Id;
            pbe.UnitPrice = 12;
            pbe.IsActive = True;
            pbelist.add(pbe);
        }
        insert pbelist;
        for(Opportunity opp : opplist){
            for(PricebookEntry pbe : pbelist){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = opp.Id;
                oli.PricebookEntryId = pbe.Id;
                oli.Product2Id = pbe.Product2Id;
                oli.UnitPrice = 12;
                oli.Quantity =12;
                olilist.add(oli);
            }
        }
        insert olilist;
    }
    testMethod static void case1(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        List<Product2> prolist = new List<Product2>();
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        
        prolist = [select Id,Name from Product2 where Name Like 'Test%'];
        opplist = [select Id,Name,AccountId from opportunity where Name Like 'Test%'];
        olilist = [select Id,Name,OpportunityId,Quantity,Product2Id,PricebookEntryId from OpportunityLineItem where OpportunityId In :opplist];
        System.debug('::54'+olilist);
        if(CheckRecursion.runOnce()){
            Test.startTest();
            update opplist;
            Test.stopTest();
        }
    }
}