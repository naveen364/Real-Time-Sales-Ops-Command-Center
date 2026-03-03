//Handler
public class NoOfProductByOpp {
    public static void addNoOfProductInField(List<Opportunity> Triggerlist){
        System.debug('Triggerlist-->'+ Triggerlist);
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id from Opportunity where Id In :Triggerlist And StageName = 'Closed Won'];
        
        system.debug('opplist---->>>'+opplist);
        List<OpportunityLineItem> lineitemlist = new List<OpportunityLineItem>();
        lineitemlist = [select Id,OpportunityId,Product2Id from OpportunityLineItem where OpportunityId In :opplist];
        
        List<Product2> productlist = new List<Product2>();
        productlist = [select Id,No_Of_Products_sold__c,Name from Product2];
        System.debug('lineitem==>'+lineitemlist);
        System.debug('product==>'+productlist);
        Map<Id,List<OpportunityLineItem>> maplinelist = new Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem lineitem : lineitemlist){
            if(!maplinelist.containsKey(lineitem.Product2Id)){
                maplinelist.put(lineitem.Product2Id,new List<OpportunityLineItem>{lineitem});
            }else{
                maplinelist.get(lineitem.Product2Id).add(lineitem);
            }
        }
        System.debug('map==>'+maplinelist);
        
        for(OpportunityLineItem lineitem : lineitemlist){
            for(Product2 pro : productlist){
                if(lineitem.Product2Id == pro.Id){
                    System.debug('productRelated'+pro);
                    pro.No_Of_Products_sold__c = maplinelist.get(pro.Id).size();
                    System.debug(' pro.No_Of_Products_sold__c==>'+pro.No_Of_Products_sold__c);
                }
            }
        }
        if(!productlist.isEmpty()){
            update productlist;
        }
    }
}