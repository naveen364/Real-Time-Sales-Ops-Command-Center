trigger alertUserWhenCloseDate on Opportunity (after update) {
    List<Opportunity> opplist = new List<Opportunity>();
    opplist = [select Id,Name,CloseDate,OwnerId from Opportunity where CloseDate<= :Date.today()];
    for(Opportunity opp : opplist){
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle('Closed Date');
        notification.setBody('Opportunity is being closed with no Opportunity line items in it');
        notification.setTargetId(opp.OwnerId);
    }
}