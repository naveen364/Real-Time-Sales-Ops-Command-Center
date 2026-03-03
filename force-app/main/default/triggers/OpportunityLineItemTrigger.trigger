trigger OpportunityLineItemTrigger on OpportunityLineItem (before update) {
    If(Trigger.isBefore && Trigger.isUpdate){
        Matchingrecordopp.match(Trigger.new);
        System.debug('Oli Call...');
    }
}