trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    /*List<Task> tasklist = new List<Task>();
    
    for(Opportunity opp : [select Id,StageName,Name from Opportunity where Id In :Trigger.new And StageName = 'Closed Won']){
        Task t =new Task();
        t.WhatId = opp.Id;
        t.Subject = 'Follow Up Test Task';
        t.Status = 'Not Started';
        t.Priority = 'Normal';
        tasklist.add(t);
    }
    if(!tasklist.isEmpty()){
        upsert tasklist;
    }
*/
}