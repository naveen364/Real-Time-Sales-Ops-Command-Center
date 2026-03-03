public without sharing class ActorTest {
    @AuraEnabled
    public static String actcall(){
        Actor__c acts = new Actor__c(Name='testGuestUser');
        insert acts;
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
        Actor__c[] act1 = [select id,name from Actor__c];
        Actor__c act = [select id,name from Actor__c order by createdDate DESC limit 1];
        System.debug('testGuestUser record=>'+act1);
        System.debug('testGuestUser record size=>'+act1.size());
               
        if(act1.size()>0){
            act.Name = 'testGuestUser Updated';
            update act; 
        	return act.name;
        }else{
            return 'NO DATA FOUND!';
        }
    }
}