public class AccountHandler {
    public static void insertAccount(Integer num){
    	List<Account> addAccounts = new List<Account>();
        Integer N = 0;
        while(N < num){
            Account act = new Account();
            act.Name = 'Acme Inc'+N;
            act.AccountNumber = 'A000'+N;
            addAccounts.add(act);
            N++;
        }
        if(!addAccounts.isEmpty()){
            insert addAccounts;
        }
    }
}