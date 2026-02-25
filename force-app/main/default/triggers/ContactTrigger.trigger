trigger ContactTrigger on Contact (After update ,Before Delete,Before update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        //RollupAccount.roll(Trigger.new);
        //ConcateAccountwithchildEmail.emailupdate(Trigger.new);
        //TotalContactAssociativeAccount.answer();
      
    }
    if(Trigger.isBefore && Trigger.isUpdate){
       
    }
    if(Trigger.isBefore && Trigger.isDelete){
        //ConcateAccountwithchildEmail.delemail(Trigger.old);
    }
}