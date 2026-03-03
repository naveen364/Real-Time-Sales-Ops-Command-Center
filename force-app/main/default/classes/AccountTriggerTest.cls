@isTest
public class AccountTriggerTest {
    @isTest static void testShippingStateUpdate() {
        List<Account> accList = new List<Account>();
        
        // 200 Accounts create karo jinka BillingState = 'CA'
        for (Integer i = 0; i < 200; i++) {
            accList.add(new Account(
                Name = 'Test Account ' + i,
                BillingState = 'CA'
            ));
        }
        
        insert accList; // Trigger chalega yaha
        
        // Records wapas query karo to check ShippingState
        List<Account> insertedAccs = [
            SELECT Id, BillingState, ShippingState
            FROM Account
            WHERE Id IN :accList
        ];
        
        for (Account acc : insertedAccs) {
            System.assertEquals('CA', acc.ShippingState, 
                'ShippingState should be equal to BillingState');
        }
    }
}