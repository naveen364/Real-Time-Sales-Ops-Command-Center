public without sharing class BatchDelAcc implements Database.Batchable<sObject>{
	public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([select Id from Account where CreatedDate > :Date.today()-10]);
    }
    public void execute(Database.BatchableContext dbc,List<Account> acclist){
        delete acclist;
    }
    public void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}