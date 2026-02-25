trigger leadtrigger on Lead (before insert,after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        //leadlimithandler.handler(trigger.new);
        //LeadWithOliAndPro.lead(trigger.new);
    }
}