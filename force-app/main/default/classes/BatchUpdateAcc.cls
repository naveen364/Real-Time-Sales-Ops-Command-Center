public class BatchUpdateAcc implements Database.Batchable<sObject>{
	public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([select Id,Name from Account]);
    }
    public void execute(Database.BatchableContext dbc,List<Account> acclist){
        for(Account acc : acclist){
            acc.Name +='Cloud';
        }
        update acclist;
    }
    public void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}