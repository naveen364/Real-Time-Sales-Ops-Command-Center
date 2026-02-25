public class AccountProcessor {
	@future
    public static void countContacts(List<Id> idlist){
        List<Account> acclist = new List<Account>();
        acclist = [select Id,(select Id from Contacts) from Account where Id In :idlist];
        for(Account acc : acclist){
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }
        update acclist;
    }
}