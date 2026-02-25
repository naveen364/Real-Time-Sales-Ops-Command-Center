public class QuickLinkToHelp {
    public static void filter(){
        Map<Id,List<Help__c>> helpmap = new Map<Id,List<Help__c>>();
        Map<Id,List<QuickLinks__c>> quickmap = new Map<Id,List<QuickLinks__c>>();
        List<QuickLinks__c> quicklist = new List<QuickLinks__c>();
        List<Help__c> helplist = new List<Help__c>();
        List<Account> acclist = new List<Account>();
        helplist =[select Id,Account__c,URL__c from Help__c where Account__c != null];
        quicklist =[select Id,Account__c,URL__c from QuickLinks__c where Account__c != null];
        
        for(Help__c h : helplist){
            if(!helpmap.containskey(h.Account__c)){
                helpmap.put(h.Account__c,new List<Help__c>{h});
            }else{
                helpmap.get(h.Account__c).add(h);
            }
        }
        for(QuickLinks__c q : quicklist){
            if(!quickmap.containskey(q.Account__c)){
                quickmap.put(q.Account__c,new List<QuickLinks__c>{q});
            }else{
                quickmap.get(q.Account__c).add(q);
            }
        }
        System.debug('Mapquick'+quickmap);
        System.debug('helpmap'+helpmap);
        
        for(QuickLinks__c ids : quicklist){
            for(Help__c h : helplist){
                if(ids.Account__c == h.Account__c){
                    System.debug('Account'+h.Account__c);
                    if(quickmap.get(ids.Account__c).size() == 1 && helpmap.get(ids.Account__c).size() == 1){
                        h.URL__c = ids.URL__c;
                        System.debug('h.url'+h.URL__c);
                    }
                }
            }
        }
        System.debug('helplist'+helplist);
        if(!helplist.isEmpty()){
            update helplist;
        }
    }
}