/*
Create picklist field label = 'Working In' and values = 'Asia, Australia, Europe'.
    Write a Trigger to stop updating Opportunities with Account having ""Working in = ASIA"" and
    Already 3 opportunitylineitems and stage name of opportunity closed won under same Account.
*/
public class StopUpdatingOpp {
    public static void stop(List<Opportunity> triggerlist){
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,Name,StageName,Account.Working_In__c from Opportunity where AccountId != null And Id In :triggerlist];
        Map<Id,List<OpportunityLineItem>> mapoli = new  Map<Id,List<OpportunityLineItem>>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        olilist = [select Id,OpportunityId from OpportunityLineItem where OpportunityId In :triggerlist];
        for(OpportunityLineItem oli : olilist){
            if(!mapoli.containskey(oli.OpportunityId)){
                mapoli.put(oli.OpportunityId,new List<OpportunityLineItem>{oli});
            }else{
                mapoli.get(oli.OpportunityId).add(oli);
            }
        }
        for(Opportunity opp : opplist){
            if(mapoli.get(opp.id).size()>3 && opp.StageName == 'Closed Won' && opp.Account.Working_In__c == 'Asia'){
                System.debug('opp'+opp.Name);
                opp.addError ('Already Closed Won');
            }
        }
    }
}