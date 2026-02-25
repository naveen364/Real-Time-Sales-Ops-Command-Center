public with sharing class wrappertestRelative {
    @AuraEnabled
    public static wrapper wrappertest(Integer i) {
        List<Account> acclist = new List<Account>();
        acclist = [select Id,Name,(select Id,LastName from Contacts),(select Id,Name from Opportunities) from Account limit 20];
        System.debug('index==>'+i);
        system.debug('opp==>'+acclist[i].Opportunities);
        System.debug('acc--> '+acclist[i].Contacts);
        wrapper wrp = new wrapper();
        wrp.acclist = acclist;
        wrp.conlist = acclist[i].Contacts;
        wrp.opplist = acclist[i].Opportunities;
        return wrp;
    }
    public class wrapper{
        @AuraEnabled
        public List<Account> acclist{get;set;}
        @AuraEnabled
        public List<Contact> conlist{get;set;}
        @AuraEnabled
        public List<Opportunity> opplist{get;set;}
    }
}