public class leadAccConLookup {
    public static void lookup(){
        List<Lead> ldlist = new List<Lead>();
        List<Account> acclist = new List<Account>();
        ldlist = [select Id from Lead where status In ('Working - Contacted','Closed - Converted') And NumberOfEmployees > 100];
        Account acc = new Account(name='ldname');
        insert acc;
        Contact con = new Contact(LastName = 'ldcon', AccountId = acc.Id);
        insert con;
        for(Lead ld : ldlist){
            ld.AccountLookup__c = acc.Id;
            ld.ContactLookup__c = con.Id;
        }
    }
}