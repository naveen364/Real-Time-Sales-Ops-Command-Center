trigger CampaignTrigger on Campaign (before insert, After update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        //CloseOpportunity.close(Trigger.new);
    }
}