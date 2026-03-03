public without sharing class BatchUpdateAccCountContact implements Database.Batchable<sObject>{
	public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([select Id from Contact where AccountId !=null]);
    }
    public void execute(Database.BatchableContext dbc,List<Contact> conlist){
        Map<Id, List<Contact>> mapcon = new Map<Id,List<Contact>>();
        set<Id> ids = new set<Id>();
        for(Contact con : conlist){
            if(!mapcon.containsKey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
                ids.add(con.AccountId);
            }else{
                mapcon.get(con.AccountId).add(con);
            }            
        }
        List<Account> acclist = new List<Account>();
        acclist = [select Id from Account where Id In :ids];
        for(Account acc : acclist){
            acc.count__c = mapcon.get(acc.Id).size();
        }
        update acclist;
    }
    public void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}