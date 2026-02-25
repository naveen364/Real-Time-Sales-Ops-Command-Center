public class AccountCloseDateCustom {
    public static boolean runOnce = true;
    public static void closeDate(List<Account> TriggerAcc){
        List<Account> acclist = new List<Account>();
        acclist = [select Id,Upcoming_Close_Date__c from Account where Id In :TriggerAcc];
        Map<Id,Date> mapopp = new Map<Id,Date>();
        List<Opportunity> opplist = new List<Opportunity>();
        //Date d;
        opplist = [select Id,AccountId,CloseDate from Opportunity];
        Date dats = null;
        for(opportunity opp : opplist){
            if(!mapopp.containskey(opp.AccountId)){
                mapopp.put(opp.AccountId,opp.CloseDate);
            }else{
                mapopp.put(opp.AccountId,mapopp.get(opp.AccountId)<opp.CloseDate? mapopp.get(opp.AccountId) : opp.CloseDate);
            }
        }
        for(Account acc : acclist){
            if(mapopp.containskey(acc.Id)){
                acc.Upcoming_Close_Date__c = mapopp.get(acc.Id);
            }
        }
        System.debug('acclist ==>'+acclist);
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}