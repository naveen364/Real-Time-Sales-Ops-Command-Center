public class ConcateEmailWithAccFromContactHandler {
    public static boolean state = False;
    public static void handler(List<Account> triggerlist){
        
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        List<Contact> conlistinsert = new List<Contact>();
        
        acclist = [select Id,AccountEmail__c from Account where Id In :triggerlist];
        conlist = [select Id,AccountId,LastName,Email from Contact where AccountId In :triggerlist];
        
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        for(Contact con : conlist){
            if(!mapcon.containsKey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        Integer i = 0;
        for(Account acc : acclist){
            if(mapcon.containskey(acc.Id)){
                for(Contact con : mapcon.get(acc.Id)){
                    acc.AccountEmail__c = acc.AccountEmail__c == null ? con.Email : acc.AccountEmail__c+';'+ con.Email;
                }
            }else{
                Contact ct = new Contact();
                ct.LastName = acc.Name+'conDefault';
                ct.AccountId = acc.Id;
                ct.Email = acc.Name+i+++'@gmail.com';
                ct.Default__c = true;
                conlistinsert.add(ct);
            }
            System.debug('accEmail'+acc.AccountEmail__c);
        }
        if(!conlistinsert.isEmpty()){
            insert conlistinsert;
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}
/*
List<Account> acclist = new List<Account>();
acclist = [select Id from Account where name like 'ocrtest%'];
update acclist;
*/