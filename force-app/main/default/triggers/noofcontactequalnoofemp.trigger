trigger noofcontactequalnoofemp on Account (after insert, after Update) {
    if(Trigger.isAfter && Trigger.isInsert){
    	//NoofContactEqNoOfEmp.createcontact(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        //NoofContactEqNoOfEmp.updateAcc(Trigger.new,Trigger.oldMap);
    }
}