public class ContactRoleCount {
    public static void count(List<OpportunityContactRole> triggerlist){
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        set<Id> setid = new set<Id>();
        
        olilist = [select Id,OpportunityId,Opportunity.countContactRole__c from OpportunityLineItem where OpportunityId In : opplist And Opportunity.stageName = 'Closed Won'];
        
       	Map<Id,List<OpportunityContactRole>> countmap = new Map<Id,List<OpportunityContactRole>>();
        Map<Id,List<OpportunityLineItem>> olimap = new Map<Id,List<OpportunityLineItem>>();
        
        for(OpportunityContactRole ocr : triggerlist){
            if(!countmap.containskey(ocr.OpportunityId)){
                countmap.put(ocr.OpportunityId,new List<OpportunityContactRole>{ocr});
            }else{
                countmap.get(ocr.OpportunityId).add(ocr);
            }
            setid.add(ocr.OpportunityId);
        }
        System.debug('map'+countmap);
        
        for(OpportunityLineItem oli : olilist){
            if(!olimap.containskey(oli.OpportunityId)){
                olimap.put(oli.OpportunityId,new List<OpportunityLineItem>{oli});
            }else{
                olimap.get(oli.OpportunityId).add(oli);
            }
        }
        opplist = [select Id,countContactRole__c from Opportunity where stageName = 'Closed Won' And Id In :setid];
        for(Opportunity opp : opplist){
            if(countmap.containskey(opp.Id) && olimap.get(opp.Id).size() > 3){
                opp.countContactRole__c = opp.countContactRole__c == null? countmap.get(opp.Id).size() : opp.countContactRole__c + countmap.get(opp.Id).size();
            }
        }
        if(!opplist.isEmpty()){
            update opplist;
        }
        
    }
}

/*
List<OpportunityContactRole> olilist = new List<OpportunityContactRole>();
for(Integer i = 0; i<4;i++){
	OpportunityContactRole oli = new OpportunityContactRole();
	oli.OpportunityId = '0065j00000XQgF6AAL';
    if(i==0){
		oli.ContactId = '0035j00000N16sVAAR';
    }else if(i == 1){
        oli.ContactId = '0035j00000N16sTAAR';
    }else if(i==2){
        oli.ContactId = '0035j00000N16sSAAR';
    }else if(i == 3){
        oli.ContactId = '0035j00000N16sPAAR';
    }
	olilist.add(oli);
}
insert olilist;
*/