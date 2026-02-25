public class NumofNewCase {
    public static void newCase(List<Case> triggerlist){
        List<Case> caselist = new List<Case>();
        caselist = [select Id,AccountId from Case where Status = 'New'];
        Map<Id,List<Case>> mapc = new Map<Id,List<Case>>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,NumberOfCase__c,Name from Account where Id In (select AccountId from Case where Id In :triggerlist)];
        for(Case c : caselist){
            if(!mapc.containsKey(c.AccountId)){
                mapc.put(c.AccountId,new List<Case>{c});
            }else{
                mapc.get(c.AccountId).add(c);
            }
        }
        System.debug('mapc'+mapc);
        for(Account acc : acclist){
            if(mapc.containskey(acc.Id)){
                acc.NumberOfCase__c = mapc.get(acc.Id).size();
                System.debug('acc.Num'+acc.NumberOfCase__c+':'+acc.Name);
            }
        }
        update acclist;
    }
    public static void delCase(List<Case> triggerlist){
        List<Case> caselist = new List<Case>();
        caselist = [select Id,AccountId from Case where Status = 'New'];
        Map<Id,List<Case>> mapc = new Map<Id,List<Case>>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,NumberOfCase__c,Name from Account where Id In (select AccountId from Case where Id In :triggerlist)];
        for(Case c : caselist){
            if(!mapc.containsKey(c.AccountId)){
                mapc.put(c.AccountId,new List<Case>{c});
            }else{
                mapc.get(c.AccountId).add(c);
            }
        }
        System.debug('mapc'+mapc);
        for(Account acc : acclist){
            if(mapc.containskey(acc.Id)){
                acc.NumberOfCase__c = mapc.get(acc.Id).size() - triggerlist.size();
                System.debug('acc.Num'+acc.NumberOfCase__c+':'+acc.Name);
            }
        }
        update acclist;
    }
}