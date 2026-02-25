trigger PolicyTrigger on Policy__c (After update) {
    if(PolicyRwithOpp.staticvar){
        PolicyRwithOpp.staticvar = true;
        if(Trigger.isAfter && Trigger.isUpdate){
            //PolicyRwithOpp.policy(Trigger.new);
        }
    }
}