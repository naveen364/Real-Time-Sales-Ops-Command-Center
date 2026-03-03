public class PracticeTest {
    public static void test(){
        List<Lead> ldlist = new List<Lead>();
        List<Contact> conlist = new List<Contact>();
        ldlist = [select Id,Status from Lead where Status In ('Working - Contacted','Closed - Converted') And NumberOfEmployees>100];
       	conlist = [select Id,AccountId from contact where AccountId != null];
        for(Contact con : conlist){
            for(Lead ld : ldlist){
            	ld.AccountLookup__c = con.AccountId;
            	ld.ContactLookup__c = con.Id;
                System.debug(ld);
            }
        }
        if(!ldlist.isEmpty()){
           //update ldlist;
        }
    }
    public static void test2(){
        List<Aggregateresult> agrlist = [Select count(Id), Account.Name from Contact where Account.Id != null GROUP BY Account.Name];
        Integer temp = 0;
        String Name;
        for(Aggregateresult agr : agrlist){
            if(Integer.valueOf(agr.get('expr0'))>temp){
                temp = Integer.valueOf(agr.get('expr0'));
                Name = String.valueOf(agr.get('Name'));
            }
        }
        system.debug(temp + '  '+Name);
    }
    public static void test3(){
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
                act.No_of_contact__c = count.size();
                System.debug(act.Name);
            }
        }
        
        //System.debug(maps);
    }
}