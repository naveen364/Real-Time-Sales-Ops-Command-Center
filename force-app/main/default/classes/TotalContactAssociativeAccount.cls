public class TotalContactAssociativeAccount {
    public static void answer(){
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        Map<Id,List<Contact>> mapcon_all = new Map<Id,List<Contact>>(); 
        List<Contact> conlist = new List<Contact>();
        List<Contact> conlist_all = new List<Contact>();
        List<Account> acclist = new List<Account>();
        conlist_all = [select Id,Name,AccountId from Contact where AccountId !=null];
        acclist = [select Id,Name,totalContact__c from Account];
        conlist = [select Id,Name,AccountId from Contact where AccountId !=null];
        for(Contact con : conlist){
            if(!mapcon.containsKey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        System.debug('map'+mapcon);
        
        for(Account acc :acclist){
            if(mapcon.containskey(acc.Id)){
                acc.totalContact__c =(Decimal) mapcon.get(acc.Id).size();
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}