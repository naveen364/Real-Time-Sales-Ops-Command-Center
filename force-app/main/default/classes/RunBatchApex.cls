global class RunBatchApex implements database.batchable<sobject> , Database.Stateful{
    
    global Iterable<sObject> start(Database.BatchableContext dbc){
        List<Trailhead_Data__c> traillist = new List<Trailhead_Data__c>();
        integer size = 3000;
        for(Integer i = 2000; i < size; i++){
            traillist.add(new Trailhead_Data__c(Name = 'Test'+i));
        }
        System.debug('::10'+traillist.size());
        return traillist;
    }
    
    global void execute(Database.BatchableContext dbc,List<Trailhead_Data__c> traillist){
        system.debug('::14'+traillist.size());
        insert traillist;
    }
    
    global void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}