public class AutocreateConOppRelated {
    public static void autoCreate(List<Account> triggerlist){
        List<Account> acclist = new List<Account>();
        acclist = [select Id,Name,(select Id from Contacts),(select Id from Opportunities) from Account where Id In :triggerlist And Active__c = 'Yes'];
        
        System.debug('acclist'+acclist);
        
        List<Opportunity> opplist = new List<Opportunity>();
        List<Contact> conlist = new List<Contact>();
        
        Map<Id,Integer> consizemap = new Map<Id,Integer>();
        Map<Id,Integer> oppsizemap = new Map<Id,Integer>();
        system.debug('consizemap-->'+consizemap);
        system.debug('oppsizemap-->'+oppsizemap);
       Integer i = 0;
        for(Account acc : acclist){
            consizemap.put(acc.Id,acc.Contacts.size());
            oppsizemap.put(acc.Id,acc.Opportunities.size());
            System.debug('acc.Opportunities.size()'+acc.Opportunities.size());
        }
        System.debug('maps'+consizemap+':'+oppsizemap);
        for(Account acc : acclist){
            if(consizemap.get(acc.Id) == 0){
                i=0;
                while(i<2){
                    Contact con = new Contact();
                    con.AccountId = acc.Id;
                    con.LastName = acc.Name+'con';
                    conlist.add(con);
                    i++;
                }
            }else if(consizemap.get(acc.Id) == 1){
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = acc.Name+'con';
                conlist.add(con);
            }
            if(oppsizemap.get(acc.Id) == 0){
                i=0;
                while(i<2){
                    Opportunity opp = new Opportunity();
                    opp.AccountId = acc.Id;
                    opp.Name = acc.Name+'opp';
                    opp.StageName = 'Closed Won';
                    opp.CloseDate = Date.today()+60;
                    opplist.add(opp);
                    i++;
                }
            }else if(oppsizemap.get(acc.Id) == 1){
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = acc.Name+'opp';
                opp.StageName = 'Closed Won';
                opp.CloseDate = Date.today()+60;
                opplist.add(opp);
            }
        }
        
        if(!opplist.isEmpty()){
            insert opplist;
        }
        if(!conlist.isEmpty()){
            insert conlist;
        }
        System.debug('opplist'+opplist);
        System.debug('conlist'+conlist);
    }
}