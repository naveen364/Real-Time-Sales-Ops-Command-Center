public with sharing class Accountget {
    @AuraEnabled
    public static List<Account> get() {
        return [select Id,Name,Website,Phone,Site from Account where Phone != null limit 20];
    }
    @AuraEnabled
    public static List<Account> getName(String name){
        System.debug('name==>'+name);
        System.debug('record-->'+[select Id from Account where Name like :name+'%']);
        return [select Id,Name from Account where Name like :name+'%'];
    }
    @AuraEnabled
    public static void createCon(String name, String ids){
        try {
            System.debug('ids==>'+ids+' name==>'+name);
            Id tempid = Id.valueof(ids);
            System.debug('tempid==>'+tempid+' name==>'+name);
            Contact con = new Contact(LastName=name,AccountId=tempid);
            insert con;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}