/*Write a trigger to stop inserting more than two contacts in opportunity if it has 2 line items and the stage name is Prospecting or Qualification.*/

public class StopInsertMorethen2Cont {
    public static void stop(List<OpportunityContactRole> triggerlist){
        
        Map<Id,List<OpportunityLineItem>> mapoli = new Map<Id,List<OpportunityLineItem>>();
        Map<Id,List<OpportunityContactRole>> mapocr = new Map<Id,List<OpportunityContactRole>>();
        
       	List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<OpportunityContactRole> ocrlist = new List<OpportunityContactRole>();
        
        ocrlist = [select Id,OpportunityId,ContactId from OpportunityContactRole where OpportunityId != null And Id In :triggerlist And Opportunity.StageName In ('Prospecting','Qualification')];
        
        
        for(OpportunityContactRole ocr : ocrlist){
            if(mapocr.containsKey(ocr.OpportunityId)){
                mapocr.put(ocr.Id,new List<OpportunityContactRole>{ocr});
            }else{
                mapocr.get(ocr.Id).add(ocr);
            }
        }
        
        oliList = [select Id from OpportunityLineItem where Opportunity.StageName In ('Prospecting','Qualification') and OpportunityId in :mapocr.keySet() limit 50000];
        
        for(OpportunityLineItem oli : oliList){
            if(mapoli.containsKey(oli.OpportunityId)){
                mapoli.put(oli.Id,new List<OpportunityLineItem>{oli});
            }else{
                mapoli.get(oli.Id).add(oli);
            }
        }
        
        for(Id oppId : mapocr.keySet()){
            if(mapocr.get(oppId).size()>2 && mapoli.get(oppId).size() == 2){
                //add error if it has more than 2 contact and 2 lineItem
               new OpportunityContactRole(OpportunityId = oppId).addError('It has more than 2 contact');
            }            
        }
    }
}