public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accList) {
        for (Account acc : accList) {
            // Agar BillingState me value hai to ShippingState usi ke barabar kar do
            if (acc.BillingState != null) {
                acc.ShippingState = acc.BillingState;
            }
        }
    }
}