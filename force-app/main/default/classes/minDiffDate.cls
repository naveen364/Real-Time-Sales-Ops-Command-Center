public class minDiffDate {
    public static void mindiff(){
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,startDate__c,endDate__c from Account];
        conlist = [select Id,startDate__c,endDate__c,AccountId from Contact where AccountId != null];
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        for(Contact con : conlist){
            if(!mapcon.containsKey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        long diff = null;
        Date tempstart;
        Date tempend;
        system.debug('map'+mapcon);
        for(Account acc : acclist){
            diff = null;
            if(mapcon.containskey(acc.Id)){
                for(Contact con : mapcon.get(acc.Id)){
                    if(diff == null){
                        diff = con.startDate__c.daysBetween(con.endDate__c);
                    }else{
                        if(con.startDate__c.daysBetween(con.endDate__c) <diff){
                            diff = con.startDate__c.daysBetween(con.endDate__c);
                            tempstart = con.startDate__c;
                            tempend =con.endDate__c;
                        }
                    }
                }
            }
            acc.startDate__c = tempstart;
            acc.endDate__c = tempend;
        }
        
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}