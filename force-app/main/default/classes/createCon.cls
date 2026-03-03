public with sharing class createCon {
    @AuraEnabled
    public static void create(List<Contact> name,String ids) {
        // Id accId = Id.valueof(ids);
        // System.debug('accId'+accId+'lst'+name);
        // //Map<String,Object> jsMap = (Map<String,Object>)JSON.deserializeUntyped(name);
        // List<Contact> conlist = new List<Contact>();
        // Type idArrType = Type.forName('List<Contact>');
        // List<Contact> results = (List<Contact>) JSON.deserialize(name,idArrType);
        // System.debug('conlist==>'+results);
        // System.debug('conlist==>'+conlist);
        // insert results;
        System.debug('name==> '+name);
        insert name;
    }
    @AuraEnabled
    public static void createcontact(Contact con){
        try {
            insert con;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}