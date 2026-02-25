public class ContactNameCopyToAccName {
    public static void copyConName(){
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        conlist = [select Id,AccountId,MailingCity,MailingCountry,MailingStreet,LastName from Contact where AccountId != null And (Name Like 'A%' or Name Like 'C%')];
        Map<Id,List<Contact>> mapcon = new Map<Id,List<contact>>();
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        System.debug('mapcon==>'+mapcon);
        acclist = [select Id,BillingCity,BillingCountry,BillingStreet,Name from Account where Id In :mapcon.keyset()];
        System.debug('acclist==>'+acclist);
        for(Account acc :acclist){
            for(Contact con : mapcon.get(acc.Id)){
                if(acc.BillingCity == null && acc.BillingStreet == null && acc.BillingCountry == null){
                    acc.BillingCity = con.MailingCity;
                    acc.BillingCountry = con.MailingCountry;
                    acc.BillingStreet = con.MailingStreet;
                    acc.Name +=' '+con.LastName;
                }else{
                    acc.BillingCity += con.MailingCity;
                    acc.BillingCountry += con.MailingCountry;
                    acc.BillingStreet += con.MailingStreet;
                    acc.Name +=' '+con.LastName;
                }
            }
        }
        System.debug('::27 acclist==>'+acclist);
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}