public with sharing class GetOpportunity {
    @AuraEnabled
    public static List<Opportunity> get() {
        return [select Id,Name,CloseDate,StageName,Account.Name from Opportunity];
    }
}