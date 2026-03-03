public class Matchingrecordopp {
    public static void match(List<OpportunityLineItem> triggerlist){
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,Name from Opportunity where Id In (select OpportunityId from OpportunityLineItem where Id In :triggerlist)];
        system.debug('new list '+triggerlist);
        Map<Id,List<OpportunityLineItem>> mapoli = new Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem oli : triggerlist){
            System.debug('name'+oli.Opportunity.Name);
            if(!mapoli.containskey(oli.OpportunityId)){
                mapoli.put(oli.OpportunityId,new List<OpportunityLineItem>{oli});
            }else{
                mapoli.get(oli.OpportunityId).add(oli);
            }
        }
        System.debug('mapoli'+mapoli);
        for(Opportunity opp : opplist){
            for(OpportunityLineItem oli : mapoli.get(opp.Id)){
                if(oli.Record__c != null){
                    if(opp.Name == oli.Record__c){
                        opp.Matching_Record__c = true;
                    }
                }
            }
        }
        if(!opplist.isEmpty()){
            update opplist;
        }
    }
}