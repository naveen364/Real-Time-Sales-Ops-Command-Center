public with sharing class DealAlertTriggerHandler {
    
    public static void handleAfterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap) {
        List<DealAlert__e> alerts = new List<DealAlert__e>();
        
        // Fetch Owner Names for richer alerts
        Set<Id> ownerIds = new Set<Id>();
        for (Opportunity opp : newOpps) {
            ownerIds.add(opp.OwnerId);
        }
        Map<Id, User> ownerMap = new Map<Id, User>([SELECT Id, Name FROM User WHERE Id IN :ownerIds]);

        for (Opportunity opp : newOpps) {
            Opportunity oldOpp = oldOppMap.get(opp.Id);
            
            // 1. High-Value Deal Alert (Amount > 50,000)
            if (opp.Amount >= 50000 && (oldOpp.Amount < 50000 || oldOpp.Amount == null)) {
                alerts.add(createAlert(opp, ownerMap.get(opp.OwnerId), 'HIGH_VALUE', '🔥 High-value deal detected!'));
            }
            
            // 2. Closed Won Alert
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                alerts.add(createAlert(opp, ownerMap.get(opp.OwnerId), 'CLOSED_WON', '🎉 Deal Closed Won!'));
            }
            
            // 3. Stage Change Alert (General)
            if (opp.StageName != oldOpp.StageName && opp.StageName != 'Closed Won') {
                alerts.add(createAlert(opp, ownerMap.get(opp.OwnerId), 'STAGE_CHANGE', '📈 Opportunity stage moved to ' + opp.StageName));
            }
        }
        
        if (!alerts.isEmpty()) {
            EventBus.publish(alerts);
        }
    }
    
    private static DealAlert__e createAlert(Opportunity opp, User owner, String type, String message) {
        return new DealAlert__e(
            OpportunityId__c = opp.Id,
            OpportunityName__c = opp.Name,
            Amount__c = opp.Amount,
            StageName__c = opp.StageName,
            OwnerId__c = opp.OwnerId,
            OwnerName__c = owner != null ? owner.Name : 'System',
            AlertType__c = type,
            Message__c = message
        );
    }
}
