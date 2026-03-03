public class ConcateAccountWithContact {
    
    public static void conc(){
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,Name from Account];
        conlist = [select Id,Name,AccountId from Contact where AccountId !=null];
        Map<Id,List<Contact>> maps = new Map<Id,List<Contact>>();
        for(Contact con :conlist){
            if(!maps.containsKey(con.AccountId)){
                List<Contact> listcon = new List<Contact>();
                listcon.add(con);
                maps.put(con.AccountId,listcon);
            }else{
                List<Contact> listcon = new List<Contact>();
                listcon = maps.get(con.AccountId);
                listcon.add(con);
                maps.put(con.AccountId,listcon);
            }
        }
        for(Account act : acclist){
            if(maps.containsKey(act.Id)){
                List<Contact> count = new List<Contact>();
                count = maps.get(act.Id);
                act.Name+= count.size();
                System.debug(act.Name);
            }
        }
        
        //System.debug(maps);
    }
}