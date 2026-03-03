public class AccountUpdateWithContactLastName {
    public static void AccountUpdate(List<Contact> conlisttrigger){
       //List<Account> acclistup = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        //acclist = [select Id,Name,(select Id,Name from Contacts where Id In :Trigger.new) from Account];
        conlist = [select Id,Account.Id,Account.Name,LastName from Contact where Id In :conlisttrigger And AccountId !=null];
        for(Contact con : conlist){
        	Account acc = new Account();
            acc.Id = con.AccountId;
            acc.Name = con.Account.Name+'-'+con.LastName;
            acclist.add(acc);
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
    public static void delContact(List<Contact> triggerlist){
        Set<Id> accIds = new Set<Id>();
        for(Contact con :triggerlist){
            accIds.add(con.AccountId);
        }
        List<Contact> conlistdel = new List<Contact>();
        List<Account> acclist = new List<Account>();
        conlistdel = [select Id,AccountId,LastName from Contact where Id In :triggerlist And AccountId !=null];
        System.debug('conlistdel===>'+conlistdel);
        acclist = [Select Id , Name from account where Id in :accIds];
        for(Contact con : conlistdel){
            for(Account acc:acclist){
                if(con.AccountId == acc.Id){
                    acc.Name = (acc.Name).replace(con.LastName,'');
                    System.debug(acc.Name);
                }  
            }
        }
        if(!acclist.isEmpty()){
    		update acclist;
    	}
    }
}