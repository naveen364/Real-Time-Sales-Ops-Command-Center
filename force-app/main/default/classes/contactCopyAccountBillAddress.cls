public class contactCopyAccountBillAddress {
    public static void copy(){
        List<Contact> conlist = new List<Contact>();
        conlist = [select Id,LastName,copy_address_to_contact__c,Account.BillingStreet,MailingStreet from Contact where copy_address_to_contact__c = true And AccountId != null];
        System.debug('conlist'+conlist);
        for(Account acc : [select Id,BillingStreet,Name from Account]){
            for(Contact con : conlist){
                if(acc.Id == con.AccountId){
                    System.debug('Name==>'+acc.Name+':'+con.LastName);
                    con.MailingStreet = acc.BillingStreet;
                }
            }
        }
        update conlist;
    }
}