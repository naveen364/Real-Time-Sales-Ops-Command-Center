@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accId = request.requestURI.substringBetween('Accounts/','/contacts');
        System.debug('accId'+accId);
        Account result =  [SELECT Id,Name,(select id, FirstName, LastName from Contacts) from Account WHERE Id = :accId];
        return result;
    }
}