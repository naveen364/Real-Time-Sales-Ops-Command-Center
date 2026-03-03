trigger AccountUpdateWithContactLastName on Contact (After update,Before delete) {
   
    if(Trigger.isUpdate && Trigger.isAfter){
        //AccountUpdateWithContactLastName.AccountUpdate(Trigger.new);
    }
    if(Trigger.isDelete && Trigger.isBefore){
        //AccountUpdateWithContactLastName.delContact(Trigger.old);
    }
    
}