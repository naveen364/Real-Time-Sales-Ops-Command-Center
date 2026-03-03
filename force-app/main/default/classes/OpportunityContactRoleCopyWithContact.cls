public class OpportunityContactRoleCopyWithContact {
    public static void ocrRcontact(List<Account> triggerlist){
        List<Contact> conlist = new List<Contact>();
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityContactRole> ocrlist = new List<OpportunityContactRole>();
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        
        conlist = [select Id,AccountId from Contact where AccountId In :triggerlist];
        opplist = [select Id,AccountId from Opportunity where AccountId In :triggerlist];
       	
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        system.debug('mapcon'+mapcon);
        system.debug('opplist'+opplist);
        for(Opportunity opp : opplist){
            if(mapcon.containsKey(opp.AccountId)){
                for(Contact con : mapcon.get(opp.AccountId)){
                    OpportunityContactRole ocr = new OpportunityContactRole();
                    ocr.ContactId = con.Id;
                    ocr.OpportunityId = opp.Id;
                    ocrlist.add(ocr);
                }
            }
        }
        System.debug('ocrlist'+ocrlist);
        if(!ocrlist.isEmpty()){
            insert ocrlist;
        }
    }
}