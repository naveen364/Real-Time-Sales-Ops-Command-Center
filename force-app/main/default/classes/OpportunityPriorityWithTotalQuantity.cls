public class OpportunityPriorityWithTotalQuantity {
    public static void opp(){
        list<OpportunityLineItem> olilist = new list<OpportunityLineItem>();
        list<Opportunity> opplist = new list<Opportunity>();
        opplist = [select Id,Total_Quantity__c,Priority__c,Name from Opportunity];
        olilist = [select Id,Quantity,OpportunityId from OpportunityLineItem where OpportunityId != null];
        Map<Id,Decimal> maps = new Map<Id,Decimal>();
        for(OpportunityLineItem oli : olilist){
            if(!maps.containsKey(oli.OpportunityId)){
                maps.put(oli.OpportunityId,oli.Quantity);
            }else{
                maps.put(oli.OpportunityId,maps.get(oli.OpportunityId)+oli.Quantity);
            }
        }
        System.debug('maps'+maps);
        for(Opportunity opp : opplist){
            if(maps.containskey(opp.Id)){
                opp.Total_Quantity__c = maps.get(opp.Id);
                if(opp.Total_Quantity__c > 50000){
                    opp.Priority__c = 'High';
                }else if(opp.Total_Quantity__c > 10000){
                    opp.Priority__c = 'Mediam';
                }else{
                    opp.Priority__c = 'Low';
                }
                System.debug('opp.Name '+opp.Name+' : opp.Total :'+opp.Total_Quantity__c+' : opp.priority'+opp.Priority__c);
            }
        }
        if(!opplist.isEmpty()){
            update opplist;
        }
        System.debug('opplist'+opplist);
    }
}