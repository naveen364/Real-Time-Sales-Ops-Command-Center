public class CloseOpportunity {
    public static void close(List<Campaign> Triggerlist){
        
        List<Campaign> camplist = new List<Campaign>();
        camplist = [select Id,Status from Campaign where Id In :Triggerlist And Status = 'Completed'];
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,CampaignId,StageName from Opportunity];
        Map<Id,List<OpportunityLineItem>> opplinemap = new Map<Id,List<OpportunityLineItem>>();
        List<OpportunityLineItem> opplinelist = new List<OpportunityLineItem>();
        opplinelist = [select Id,OpportunityId from OpportunityLineItem where OpportunityId != null];
        
        System.debug('opplinelist==>'+opplinelist);
        System.debug('opplist==>'+opplist);
        System.debug('camplist==>'+camplist);
        
        for(OpportunityLineItem oppline : opplinelist){
            if(!opplinemap.containskey(oppline.OpportunityId)){
                opplinemap.put(oppline.OpportunityId,new List<OpportunityLineItem>{oppline});
            }else{
                opplinemap.get(oppline.OpportunityId).add(oppline);
            }
        }
        
        System.debug('map==>'+opplinemap);
        for(Campaign camp : camplist){
            for(Opportunity opp : opplist){
                if(camp.Id == opp.CampaignId){
                    if(opplinemap.get(opp.Id) != null){
                        opp.StageName = 'Close Lost';
                    }else{
                        opp.StageName = 'Close Won';
                    }
                }
            }
        }
        if(!opplist.isEmpty()){
            update opplist;
        }
    }
}