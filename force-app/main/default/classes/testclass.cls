public without sharing class testclass {
    //public string test{get;set;}
    public Actor__c act{get;set;}
    public testclass(){
        //test = 'https://developer.salesforce.com/files/salesforce-developer-network-logo.png';
        act = new Actor__c(Name='testGuestUser');
        
    }
    public PageReference dmlOperation() {
        insert act;
        Schema.DescribeSObjectResult describe = SObjectType.Actor__c;
        Boolean isCreateable = describe.isCreateable();
        
        
        if (isCreateable) {
            System.debug('The current user has Create access to the Actor__c object.');
        } else {
            System.debug('The current user does not have Create access to the Actor__c object.');
        }
        
        Schema.DescribeSObjectResult describe1 = SObjectType.Actor__c;
        Boolean hasReadAccess = describe1.isAccessible();

        if (hasReadAccess) {
            System.debug('The current user has read access to the Actor__c object.');
        } else {
            System.debug('The current user does not have read access to the Actor__c object.');
        }
        Actor__c[] act = [select id,name from Actor__c];
        System.debug('testGuestUser record=>'+act);
        System.debug('testGuestUser record size=>'+act.size());
        return null;
    }
}