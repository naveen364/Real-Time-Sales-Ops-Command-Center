/*
Create a custom object with name "Policy" have field "Renew policy"[checkbox] and a 
self lookup field name "Parent policy" it has an another field named "Policy number"[number,unique] 
and a lookup with opportunity object with field name "opportunity name".create a field on opportunity with 
name "Policy number[unique]". write a trigger on policy[before update] to find the opportunity with policy 
number opportunity[policy number] == Policy[policy number] then update opportunity to closed won and if Parent 
policy is not null then update the parent policy filed "Rnew policy" = true and update the policy "Opportunity 
name[lookup]" with opportunity Id."
*/
public class PolicyRwithOpp {
    public static Boolean staticvar = false;
    public static void policy(List<Policy__c> triggerlist){
        System.debug('Size==>'+triggerlist.size());
        List<Opportunity> opplist = new List<Opportunity>();
        List<Opportunity> updatelist = new List<Opportunity>();
        List<Policy__c> policyupdatelist = new List<Policy__c>();
        List<Policy__c> policylist = new List<Policy__c>();
        
        policylist = [select Id,Parent_policy__c,Renew_policy__c,Policy_number__c from Policy__c where Id In :triggerlist];
        opplist = [select Id,Policy_number__c from Opportunity where Policy_number__c != null];
        
        for(Opportunity opp : opplist){
            for(Policy__c p : policylist){
                if(opp.Policy_number__c == p.Policy_number__c){
                    opp.StageName = 'Closed Won';
                    if(p.Parent_policy__c != null){
                        p.Renew_policy__c = true;
                        p.opportunity_name__c = opp.Id;
                    }
                    policyupdatelist.add(p);
                }
            }
        }
        if(!opplist.isEmpty()){
            update opplist;
        }
        System.debug('opplist'+opplist);
        if(!policyupdatelist.isEmpty()){
            update policyupdatelist;
        }
    }
}