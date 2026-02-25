public with sharing class wrappermaprelative {
    @AuraEnabled
    public static wrapper wrappermap() {
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        Map<Id,List<Opportunity>> mapopp = new Map<Id,List<Opportunity>>();
        
        acclist = [select Id,Name from Account where Id In (select AccountId from opportunity) limit 10];
        conlist = [select Id,Name,AccountId from Contact where AccountId In :acclist];
        opplist = [select Id,Name,AccountId from Opportunity where AccountId In :acclist];
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        System.debug('mapcon'+mapcon);
        for(Opportunity opp : opplist){
            if(!mapopp.containskey(opp.AccountId)){
                mapopp.put(opp.AccountId,new List<Opportunity>{opp});
            }else{
                mapopp.get(opp.AccountId).add(opp);
            }
        }
        System.debug('mapopp'+mapopp);

        wrapper wrp = new wrapper();
        wrp.acclist = acclist;
        wrp.conmap = mapcon;
        wrp.oppmap = mapopp;
        return wrp;
    }
    public class wrapper{
        @AuraEnabled
        public List<Account> acclist{get;set;}
        @AuraEnabled
        public Map<Id,List<Contact>> conmap{get;set;}
        @AuraEnabled
        public Map<Id,List<Opportunity>> oppmap{get;set;}
    }
}