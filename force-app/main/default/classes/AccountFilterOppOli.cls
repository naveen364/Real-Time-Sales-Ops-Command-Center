public class AccountFilterOppOli {
    public static void filter(){
        list<OpportunityLineItem> olilist = new list<OpportunityLineItem>();
        olilist = [select Id,Quantity,Opportunity.AccountId from OpportunityLineItem where Opportunity.AccountId !=null And Opportunity.stageName = 'Closed Lost'];
        Map<Id,Decimal> maps = new Map<Id,Decimal>();
        for(OpportunityLineItem oli : olilist){
            if(!maps.containsKey(oli.Opportunity.AccountId)){
                maps.put(oli.Opportunity.AccountId,oli.Quantity);
            }else{
                maps.put(oli.Opportunity.AccountId,maps.get(oli.Opportunity.AccountId)+oli.Quantity);
            }
        }
        System.debug('maps'+maps);
        set<Id> Accset = new set<Id>();
        for(Id ids : maps.keyset()){
            if(maps.get(ids)<200){
                System.debug('Id ==>'+ids+' : TotalQuantity==>'+maps.get(ids));
                Accset.add(ids);
            }
        }
        for(Account acc : [select Id from Account where Id In :Accset]){
            System.debug('Account==>'+acc);
        }
    }
}