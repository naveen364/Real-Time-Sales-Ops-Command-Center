public class BatchModule implements Database.Batchable<sobject> , Database.Stateful {
    
    public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([select id,Name ,TrailHead_Data__c ,status__c from Modules__c where TrailHead_Data__c != NULL AND
status__c = 'Completed']);
    }
    public void execute(Database.BatchableContext dbc,List<Modules__c> Modulelist){
        List<TrailHead_Data__c> TrailHead = new List<TrailHead_Data__c>();
        Map<Id,String> maps = new Map<Id,String>();
        for(Modules__c module : Modulelist){
            if(!maps.containsKey(module.TrailHead_Data__c)){
                maps.put(module.TrailHead_Data__c,module.Name);
            }else{
                maps.put(module.TrailHead_Data__c,maps.get(module.TrailHead_Data__c) +'=>'+ module.Name);
            }
        }    
        for(Id ids : maps.keyset()){
            TrailHead_Data__c thd = new TrailHead_Data__c();
            thd.Id = ids;
            thd.Module_Name__c = maps.get(ids);
            TrailHead.add(thd);
        }
        update TrailHead;
    }
    public static void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}