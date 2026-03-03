public class CloneOppWithLineItem {
    public static Boolean staticvar = true;
    public static void clone(List<Opportunity> triggerlist, Map<Id,Opportunity> Triggeroldmap){
        
        List<OpportunityLineItem> lineitemlist = new List<OpportunityLineItem>();
        List<OpportunityLineItem> lineitemlistinsert = new List<OpportunityLineItem>();
        lineitemlist = [select Id,OpportunityId,Quantity,Product2Id,PricebookEntryId,TotalPrice from OpportunityLineItem Where OpportunityId In :triggerlist Limit 50000];
        System.debug('lineitemlist ==>'+lineitemlist);
        List<Opportunity> opplist = new List<Opportunity>();
        Map<Id,List<OpportunityLineItem>> maplineitem = new Map<Id,List<OpportunityLineItem>>();
        
        for(OpportunityLineItem opplineup : lineitemlist){
            if(!maplineitem.containsKey(opplineup.OpportunityId)){
                maplineitem.put(opplineup.OpportunityId,new List<OpportunityLineItem>{opplineup});
            }else{
                maplineitem.get(opplineup.OpportunityId).add(opplineup);
            }
        }
        System.debug('maplineitem==>'+maplineitem);
        
        for(Opportunity opp : triggerlist){
            Opportunity oppclone = new Opportunity();
            oppclone = opp.clone(false,true,false,false);
            oppclone.Name +='clone';
            oppclone.CloseDate = Triggeroldmap.get(opp.Id).CloseDate + 30;
            opplist.add(oppclone);
        }
        
        if(!opplist.isEmpty()){
            insert opplist;
        }
        
        System.debug('opplist==>'+opplist);
        
        for(Opportunity opp : opplist){
            System.debug('\nopp'+opp);
            if(maplineitem.get(opp.getCloneSourceId()) != null){
                System.debug('maplineitem.get(opp.getCloneSourceId)==>'+maplineitem.get(opp.getCloneSourceId()));
                for(OpportunityLineItem lineitem : maplineitem.get(opp.getCloneSourceId())){
                    if(opp.getCloneSourceId() == lineitem.OpportunityId){
                        OpportunityLineItem lineitemclone = new OpportunityLineItem();
                        lineitemclone.Quantity = lineitem.Quantity;
                        lineitemclone.PricebookEntryId = lineitem.PricebookEntryId;
                        lineitemclone.TotalPrice = 123;
                        lineitemclone.OpportunityId = opp.Id;
                        lineitemlistinsert.add(lineitemclone);
                    }
                }
            }
        }
        if(!lineitemlistinsert.isEmpty()){
            insert lineitemlistinsert;
        }
        
        System.debug('lineitemlistinsert==>'+lineitemlistinsert);
    }
}

//update opportunity