public class AccountTokenize {
	@AuraEnabled
    public Static Account getAccount(String accNum){
        Account acc = [select id,Name,AccountNumber from Account where AccountNumber = :accNum limit 1];
        return acc;
    }
    @AuraEnabled
    public Static Void saveContact(String accID, String fname, String lname){
        Contact con = new Contact();
        con.FirstName = fname;
        con.LastName = lname;
        con.AccountId = accID;
        insert con;
    }
}