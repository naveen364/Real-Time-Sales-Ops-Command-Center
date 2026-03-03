public class AccountUtils {
    public static List<Account> accountsByState(String stateAbbreviation) {
        // Query only Id and Name for Accounts matching BillingState
        List<Account> accList = [
            SELECT Id, Name
            FROM Account
            WHERE BillingState = :stateAbbreviation
        ];
        return accList;
    }
}