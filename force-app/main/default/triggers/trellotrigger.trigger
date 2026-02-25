trigger trellotrigger on Trello__c (before insert,before update,after update) {
    if(trigger.isAfter && trigger.isUpdate){
        if(TrelloClassHandler.var == False){
            TrelloClassHandler.var = True;
        	TrelloClassHandler.handler(trigger.new);
        }
        System.debug('After update call...');
    }
}