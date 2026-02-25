public without sharing class BetchCreate5OppDaily implements Database.Batchable<sObject>{
	public List<Opportunity> start(Database.BatchableContext dbc){
        List<Opportunity> opplist = new List<Opportunity>();
        for(Integer i = 0 ; i<5;i++){
            opplist.add(new Opportunity(Name = 'Test'+i,StageName = 'Closed Won',CloseDate = Date.today()+8+i));
        }
        return opplist;
    }
    public void execute(Database.BatchableContext dbc,List<Opportunity> opplist){
        insert opplist;
    }
    public void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}