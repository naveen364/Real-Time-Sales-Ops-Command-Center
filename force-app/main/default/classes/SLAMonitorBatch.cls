public with sharing class SLAMonitorBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query Cases that have been open for more than 48 hours and are not closed
        DateTime threshold = System.now().addHours(-48);
        return Database.getQueryLocator([
            SELECT Id, CaseNumber, Subject, Account.Name, CreatedDate, Priority, OwnerId 
            FROM Case 
            WHERE IsClosed = false AND CreatedDate < :threshold
        ]);
    }
    
    public void execute(Database.BatchableContext BC, List<Case> scope) {
        List<SLABreach__e> breaches = new List<SLABreach__e>();
        
        for (Case c : scope) {
            Long diffMs = System.now().getTime() - c.CreatedDate.getTime();
            Decimal hoursOpen = Decimal.valueOf(diffMs) / (1000 * 60 * 60);
            
            breaches.add(new SLABreach__e(
                CaseId__c = c.Id,
                CaseNumber__c = c.CaseNumber,
                Subject__c = c.Subject,
                AccountName__c = c.Account.Name,
                HoursOpen__c = hoursOpen.setScale(2),
                Priority__c = c.Priority,
                OwnerId__c = c.OwnerId,
                Message__c = '⚠️ SLA Breach: Case #' + c.CaseNumber + ' has been open for ' + hoursOpen.setScale(1) + ' hours.'
            ));
        }
        
        if (!breaches.isEmpty()) {
            EventBus.publish(breaches);
        }
    }
    
    public void finish(Database.BatchableContext BC) {
        System.debug('SLA Monitor Batch completed.');
    }
}
