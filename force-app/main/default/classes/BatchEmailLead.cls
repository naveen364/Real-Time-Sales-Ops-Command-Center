public without sharing class BatchEmailLead implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([select Id from Lead where Phone != null]);
    }
    public static void execute(Database.BatchableContext dbc,List<Lead> lst){
        EmailManager mail = new EmailManager();
        mail.sendMail(UserInfo.getUserEmail(),'Lead with No Phone Number',String.valueOf(lst));
    }
    public static void finish(Database.BatchableContext dbc){
        System.debug('Done ^^');
    }
}

//CreatedDate < :Date.today() And CreatedDate > :Date.today()-2 And