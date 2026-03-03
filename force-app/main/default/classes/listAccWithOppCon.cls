public class listAccWithOppCon {
	@AuraEnabled
    public static List<Account> getAcc(){
        return [select Id,Name from Account where Id In (select AccountId from Contact where AccountId != null)];
    }
    @AuraEnabled
    public static List<Contact> getCon(Id ids){
        return [select Id,Name from Contact where AccountId = :ids];
    }
    @AuraEnabled
    public static List<Opportunity> getOpp(Id ids){
        return [select Id,Name from Opportunity where AccountId = :ids];
    }
}