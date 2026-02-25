public with sharing class AccountRelateContact {
    @AuraEnabled(cacheable = true)
    public static List<Contact> getDetails(String Id){
        try {
            return [select Id,LastName,AccountId from Contact where AccountId = :Id Limit 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> getAcc(){
        try{
            return [select Id,Name from Account Limit 10];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(String Id){
        try {
            return [select Id,LastName,AccountId from Contact where AccountId = :Id Limit 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}