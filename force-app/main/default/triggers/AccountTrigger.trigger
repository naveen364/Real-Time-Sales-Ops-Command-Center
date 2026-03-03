trigger AccountTrigger on Account (After insert,After update,before update,After Delete,before insert) {
    if(Trigger.isAfter && Trigger.isUpdate){
        /*System.debug('::3'+AccountCloseDateCustom.runOnce);
        if(AccountCloseDateCustom.runOnce == true){
            AccountCloseDateCustom.runOnce = false;
        	AccountCloseDateCustom.closeDate(Trigger.new);
        }*/
        /*if(AccountOutOfZipCheck.var){
            AccountOutOfZipCheck.var = False;
        	AccountOutOfZipCheck.zip(trigger.oldmap,trigger.newmap);
        }*/
        //NoofOpportunityEqNoOfEmp.updateAcc(trigger.new,trigger.oldmap);
        OpportunityContactRoleCopyWithContact.ocrRcontact(trigger.new);
        //NoofContactEqNoOfEmp.updateAcc(trigger.new);
        /*
        if(ConcateEmailWithAccFromContactHandler.state == False){
            ConcateEmailWithAccFromContactHandler.state = True;
            ConcateEmailWithAccFromContactHandler.handler(trigger.new);
        }*/
    }
    if(Trigger.isAfter && Trigger.isInsert){
        
        
    }
  	if(Trigger.isBefore && Trigger.isUpdate){
        //AutocreateConOppRelated.autoCreate(trigger.new);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        
    }
    if (Trigger.isBefore && Trigger.isInsert) {
        AccountTriggerHandler.CreateAccounts(Trigger.new);
    }
    
}