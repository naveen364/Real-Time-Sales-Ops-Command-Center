public with sharing class logincontact{
    @AuraEnabled
    public static String xyz(String username, String password){
        List<Contact> conlist = new List<Contact>();
        conlist = [select Id,LastName from contact where username__c = :username AND password__c = :password];
        if(!conlist.isEmpty()){
            String s = 'Welcome '+conlist[0].LastName+' successfully Login';
            return s;
        }else{
            return null;
        }
    }
}