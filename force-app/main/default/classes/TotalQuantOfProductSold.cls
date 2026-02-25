public class TotalQuantOfProductSold {
    public static void totalQuantity(){
        Map<Id,Decimal> mapquant = new Map<Id,Decimal>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        olilist = [select Id,Opportunity.AccountId,Quantity from OpportunityLineItem where Opportunity.Account.Working_In__c = 'Asia'];
        for(OpportunityLineItem oli : olilist){
            if(!mapquant.containskey(oli.Opportunity.AccountId)){
                mapquant.put(oli.Opportunity.AccountId,oli.Quantity);
            }else{
                mapquant.put(oli.Opportunity.AccountId,mapquant.get(oli.Opportunity.AccountId)+oli.Quantity);
            }
        }
        System.debug('map==>'+mapquant);
    }
}