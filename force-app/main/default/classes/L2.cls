public class L2 {
    public static void xyz(){
        List<L2Account__c> l2acclist = new List<L2Account__c>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,L2Account__c from Account where L2Account__c != null];
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        //order by closeDate in olilist
        olilist = [select Id,Opportunity.Account.L2Account__r.Id,Opportunity.AccountId,opportunity.StageName,Type__c,Opportunity.Amount,Opportunity.CloseDate from OpportunityLineItem where OpportunityId In (select Id from opportunity where AccountId In :acclist) And Type__c != null Order By Opportunity.CloseDate Asc];
        system.debug('olilist==>'+olilist);
        
        Map<String,List<OpportunityLineItem>> firstCaseMap = new Map<String,List<OpportunityLineItem>>();
        
        set<Id> L2OppId_case1 = new set<Id>(); //store case1 opp.id
        set<Id> L2OppId_case2 = new set<Id>(); //store case2 opp.id
        set<Id> L2Acc_Case1 = new set<Id>();	//store case1 l2acc.id
        set<Id> L2Acc_Case2 = new set<Id>();	//store case2 l2acc.id
        set<Id> L2Acc_Case4 = new set<Id>();	//store case4 l2acc.id
        set<Id> oppId = new set<Id>();
       	set<Id> uniqlistofl2acc = new set<Id>();
        
        for(OpportunityLineItem oli : olilist){
            System.debug('::18');
            String key = oli.OpportunityId+' '+oli.Type__c;
            System.debug('key==>'+key);
            if(!firstCaseMap.containsKey(key)){
                System.debug('::22');
                firstCaseMap.put(key,new List<OpportunityLineItem>{oli});
            }else{
                firstCaseMap.get(key).add(oli);
            }
            
            oppId.add(oli.OpportunityId);
        }
      	System.debug('map==>'+firstCaseMap);
        for(Opportunity opp : [select Id,Amount,Account.L2Account__r.Id from Opportunity where Id In :oppId]){
            
            String key1 = opp.Id+' '+'Renewal';
            String key = opp.Id+' '+'New';
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
                L2OppId_case1.add(opp.Id);
            }
            if(news>0 && renewal== 0){
                L2OppId_case2.add(opp.Id);
            }
        }
        for(Opportunity opp : [select Id,Amount,Account.L2Account__r.Id,stageName from Opportunity where Id In :oppId]){
            //if account have multi opp one close won other !close won fail case 4
            //
            if(opp.stageName == 'Closed Won'){
                if(L2OppId_case1.contains(opp.Id)){
                    L2Acc_Case1.add(opp.Account.L2Account__r.Id);
                    continue;
                }
                if(L2OppId_case2.contains(opp.Id) && opp.Amount>=10000){
                    L2Acc_Case2.add(opp.Account.L2Account__r.Id);
                    continue;
                }else{
                    continue;
                }
            }else{
                L2Acc_Case4.add(opp.Account.L2Account__r.Id); //case 4
            }
            //
        }
        for(L2Account__c acc : [select Id,First_Booking_Date__c from L2Account__c where Id In :L2Acc_Case1]){
            System.debug('inside case 1 list');
            acc.First_Booking_Date__c = 'Old Logo';
            uniqlistofl2acc.add(acc.Id);
            l2acclist.add(acc);
        }
        
        
        Map<Id,String> closedatemap = new Map<Id,String>();
        for(Opportunity opp : [select Id,Amount,Account.L2Account__r.Id,CloseDate from Opportunity where Id In :L2OppId_case2]){
            if(!closedatemap.containskey(opp.Account.L2Account__r.Id)){
                closedatemap.put(opp.Account.L2Account__r.Id,String.valueOf(opp.CloseDate));
            }
        }
        for(L2Account__c acc : [select Id,First_Booking_Date__c from L2Account__c where Id In :L2Acc_Case2]){
            if(closedatemap.containskey(acc.Id) && !uniqlistofl2acc.contains(acc.Id)){
                System.debug('inside case 1 list');
                acc.First_Booking_Date__c = closedatemap.get(acc.Id);
                uniqlistofl2acc.add(acc.Id);
                l2acclist.add(acc);
            }
        }
        for(L2Account__c acc : [select Id,First_Booking_Date__c from L2Account__c where Id In :L2Acc_Case4]){
            if(!uniqlistofl2acc.contains(acc.Id)){
                System.debug('inside case 4 list');
                acc.First_Booking_Date__c = 'Not yet signed';
                uniqlistofl2acc.add(acc.Id);
                l2acclist.add(acc);
            }
        }
        System.debug('set uniqlistofl2acc==>'+uniqlistofl2acc);
        List<L2Account__c> lst = new List<L2Account__c>();
        System.debug('lst==>'+l2acclist);
        if(!l2acclist.isEmpty()){
            System.debug('inside l2acclist');
            update l2acclist;
        }
        System.debug('L2accountId_case1==>'+L2Acc_Case1);
        System.debug('L2accountId_case2==>'+L2Acc_Case2);
        System.debug('L2accountId_case4==>'+L2Acc_Case4);
    }
}