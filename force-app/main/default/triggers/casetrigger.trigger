trigger casetrigger on Case (before insert,after insert,after update,after delete,before delete) {
    if(Trigger.isAfter && Trigger.isInsert){
       	NumofNewCase.newCase(trigger.new);
    }
  	if(Trigger.isAfter && Trigger.isUpdate){
        NumofNewCase.newCase(trigger.new);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        NumofNewCase.delCase(trigger.old);
    }

}