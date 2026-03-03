trigger CustomNotify on Opportunity (after insert, after update) {
    List<Opportunity> opplist = [select Id,Name,owner.Id,AccountId,StageName from Opportunity where Id In :Trigger.new And StageName = 'Closed Won'];
    if(!opplist.isEmpty()){
        set<String> setId = new set<String>();
        for(Opportunity opp : opplist){
            setId.add(opp.owner.Id);
        }
        CustomNotificationType notificationType = [SELECT Id, CustomNotifTypeName,DeveloperName FROM CustomNotificationType where DeveloperName ='CLOSEDWONNOTIFY'];
        System.debug('::812231');
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        if(Trigger.isAfter){
            notification.setTitle('Opportunity==>'+opplist[0].Name);
            notification.setBody('Opportunity StageName ==> '+opplist[0].StageName);
            
            // Set the notification type and target
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(opplist[0].id);
            
            // Actually send the notification
            try {
                System.debug('::21');
                notification.send(setId);
                System.debug('::22');
            }
            catch (Exception e) {
                System.debug('Problem sending notification: ' + e.getStackTraceString());
            }
            if(Trigger.isUpdate){
                
            }
        }
    }
}