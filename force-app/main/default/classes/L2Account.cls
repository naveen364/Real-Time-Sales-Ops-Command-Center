public class L2Account {
    public static void xyz(){
        List<L2Account__c> l2acclist = new List<L2Account__c>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,L2Account__c from Account where L2Account__c != null];
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        //order by closeDate in olilist
        olilist = [select Id,Opportunity.Account.L2Account__r.Id,Opportunity.AccountId,opportunity.StageName,Type__c,Opportunity.Amount,Opportunity.CloseDate from OpportunityLineItem where OpportunityId In (select Id from opportunity where AccountId In :acclist) And Type__c != null Order By Opportunity.CloseDate Asc];
        system.debug('olilist==>'+olilist);
        
        Map<String,List<OpportunityLineItem>> firstCaseMap = new Map<String,List<OpportunityLineItem>>();
        
        set<Id> L2accountId_case1 = new set<Id>(); //store case1 id
        set<Id> L2accountId_case2 = new set<Id>(); //store case2 id
        set<Id> L2accountId_case4 = new set<Id>(); //store case4 id
        set<Id> oppId = new set<Id>();
       	set<Id> uniqlistofl2acc = new set<Id>();
        
        for(OpportunityLineItem oli : olilist){
            if(oli.opportunity.StageName == 'Closed Won'){
                System.debug('::18');
                String key = 'Closed Won'+' '+oli.OpportunityId+' '+oli.Type__c;
                System.debug('key==>'+key);
                if(!firstCaseMap.containsKey(key)){
                    System.debug('::22');
                    firstCaseMap.put(key,new List<OpportunityLineItem>{oli});
                }else{
                    firstCaseMap.get(key).add(oli);
                }
            }else{
                /////
                if(oli.Opportunity.Account.L2Account__r.Id != null){
                	L2accountId_case4.add(oli.Opportunity.Account.L2Account__r.Id);
                }
            }
            oppId.add(oli.OpportunityId);
        }
      	System.debug('map==>'+firstCaseMap);
        for(Opportunity opp : [select Id,Amount,Account.L2Account__r.Id from Opportunity where Id In :oppId]){
            ///
            if(opp.Amount<10000){
                System.debug('inside case 3');
                continue;				//case 3 here
            }
            String key1 = 'Closed Won'+' '+opp.Id+' '+'Renewal';
            String key = 'Closed Won'+' '+opp.Id+' '+'New';
            Integer renewal = 0;
            Integer news = 0;
            if(firstCaseMap.containskey(key) || firstCaseMap.containskey(key1)){
                if(firstCaseMap.containskey(key)){
                    news++;
                }
                if(firstCaseMap.containskey(key1)){
                    renewal++;
                }
            }
            if((news > 0 && renewal > 0) || (news == 0 && renewal>0)){
                L2accountId_case1.add(opp.Account.L2Account__r.Id);
            }
            if(news>0 && renewal== 0){
                L2accountId_case2.add(opp.Account.L2Account__r.Id);
            }
        }
        ///*******************
        for(L2Account__c acc : [select Id,First_Booking_Date__c from L2Account__c where Id In :L2accountId_case1]){
            System.debug('inside case 1 list');
            acc.First_Booking_Date__c = 'Old Logo';
            uniqlistofl2acc.add(acc.Id);
            l2acclist.add(acc);
        }
        for(L2Account__c acc : [select Id,First_Booking_Date__c from L2Account__c where Id In :L2accountId_case2]){
            for(Opportunity opp : [select Id,Account.L2Account__r.Id,Amount,CloseDate from Opportunity where Id In :oppId]){
                if(opp.Account.L2Account__r.Id == acc.Id && opp.Amount>=10000 && !uniqlistofl2acc.contains(acc.Id)){
                    System.debug('inside case 2 list');
                    acc.First_Booking_Date__c = String.valueof(opp.CloseDate);
                    uniqlistofl2acc.add(acc.Id);
                    l2acclist.add(acc);
                }
        	}
        }
        for(L2Account__c acc : [select Id,First_Booking_Date__c from L2Account__c where Id In :L2accountId_case4]){
            if(!uniqlistofl2acc.contains(acc.Id)){
                System.debug('inside case 4 list');
                acc.First_Booking_Date__c = 'Not yet signed';
                uniqlistofl2acc.add(acc.Id);
                l2acclist.add(acc);
            }
        }
        System.debug('set==>'+uniqlistofl2acc);
        List<L2Account__c> lst = new List<L2Account__c>();
        System.debug('lst==>'+l2acclist);
        
        System.debug('list==>'+l2acclist);
        if(!l2acclist.isEmpty()){
            System.debug('inside l2acclist');
            update l2acclist;
        }
        System.debug('L2accountId_case1==>'+L2accountId_case1);
        System.debug('L2accountId_case2==>'+L2accountId_case2);
        System.debug('L2accountId_case4==>'+L2accountId_case4);
    }
}