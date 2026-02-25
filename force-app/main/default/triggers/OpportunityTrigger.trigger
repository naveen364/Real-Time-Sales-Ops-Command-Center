trigger OpportunityTrigger on Opportunity (before insert,after insert, after update, before update) {
    
            if(Trigger.isBefore && Trigger.isInsert){
                //NoPastDateInOpportunity.noPast(Trigger.new);//
                System.debug('Before Insert');
            }
            if(Trigger.isBefore && Trigger.isUpdate){
              	//StopUpdatingOpp.stop(Trigger.new); //
                //AlertOpportunityWhenClosedAndNoLinedItem.alert(Trigger.new);
                /*if(CloneOppWithLineItem.staticvar){			//
                    CloneOppWithLineItem.staticvar = false;
                	CloneOppWithLineItem.clone(Trigger.new,Trigger.oldmap);
                }*/
               	System.debug('Before update');
                }
            if(Trigger.isAfter && Trigger.isUpdate){
                //NoOfProductByOpp.addNoOfProductInField(Trigger.new);	//
                System.debug('After Update');
                DealAlertTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
            }
            if(Trigger.isAfter && Trigger.isInsert){
                //OpportunitycloneContactRoleRelative.contactRole(Trigger.new);	//
                System.debug('After Insert');
            }
   // }
        
}