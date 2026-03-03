public class AccountUtility {
    public static void  viewAnnualRevenue(){
        List<Account> accountsList = new List<Account>();
        accountsList = [SELECT Name,AnnualRevenue from account];
        String acctRev;
        for(Account acc : accountsList){
            acctRev = acc.Name+':'+acc.AnnualRevenue;
            System.debug(acctRev);
        }
    }
}