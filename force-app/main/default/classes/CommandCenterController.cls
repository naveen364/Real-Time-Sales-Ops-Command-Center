public with sharing class CommandCenterController {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities() {
        return [
            SELECT Id, Name, Amount, StageName, CloseDate, Account.Name, Owner.Name 
            FROM Opportunity 
            ORDER BY CloseDate DESC 
            LIMIT 500
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(Id accountId) {
        return [
            SELECT Id, Name, Industry, Type, Phone, Website, AnnualRevenue, Description 
            FROM Account 
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId) {
        return [
            SELECT Id, Name, Title, Email, Phone 
            FROM Contact 
            WHERE AccountId = :accountId 
            ORDER BY Name ASC
        ];
    }
}
