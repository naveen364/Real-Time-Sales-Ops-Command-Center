public class LazyLoad {
    @AuraEnabled
    public static AccountWrapper getAccountRecords(Integer initialRows){
        AccountWrapper accountWrapper= new AccountWrapper();
        try{
            accountWrapper.accountsList = [SELECT ID,LastName,Account.Name,phone FROM Contact ORDER BY LastName ASC LIMIT :initialRows OFFSET 0];
            accountWrapper.totalRecords = [SELECT COUNT() FROM Contact];
            accountWrapper.message = 'Account records are loaded';
            accountWrapper.success = true;
        }
        catch(Exception e){
            accountWrapper.message = e.getMessage();
            accountWrapper.success = false;
        }
        return accountWrapper;
    }
    
    //To return additional records based on offset
    @AuraEnabled
    public static List<Contact> loadAccountRecords(Integer rowLimit,Integer rowOffset){
        return [SELECT ID,Name,Account.Name,phone FROM Contact ORDER BY LastName ASC LIMIT :rowLimit OFFSET :rowOffset];
    }
    
    // wrapper class
    public class AccountWrapper{
        @AuraEnabled
        public Integer totalRecords = 0;
        @AuraEnabled
        public List<Contact> accountsList = new List<Contact>();
        @AuraEnabled
        public String message;
        @AuraEnabled
        public Boolean success;
    }
}