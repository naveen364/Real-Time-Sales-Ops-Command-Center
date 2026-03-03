@isTest
public class AccountManagerTest {
    @isTest
    public static Id createTestRecord(){
        Account acc = new Account();
        acc.Name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        insert con;
        return acc.Id;
    }
    @isTest static void test() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://cloudanalogycom300-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        AccountManager.getAccount();
    }
}