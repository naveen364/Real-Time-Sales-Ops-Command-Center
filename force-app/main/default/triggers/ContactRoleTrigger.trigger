trigger ContactRoleTrigger on OpportunityContactRole (Before insert,before update,After insert) {
    if(trigger.isBefore && trigger.isInsert){
         StopInsertMorethen2Cont.stop(trigger.new);
    }
    if(trigger.isAfter && trigger.isInsert){
        //ContactRoleCount.count(trigger.new);
    }
}