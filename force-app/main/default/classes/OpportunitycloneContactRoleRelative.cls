public class OpportunitycloneContactRoleRelative {
    
    public static void contactRole(List<Opportunity> Triggerlist){
        
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,Name,AccountId from Opportunity where AccountId != null And Id In :Triggerlist];
        
        System.debug('Opp List --> '+opplist);
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        List<Contact> conlist = new List<Contact>();
        
        List<contact> conList1 = New List<Contact>();
        conList1 =[SELECT Id, Lastname , AccountId FROM Contact];
        System.debug('conList--> '+conList);
        conlist = [select Id,AccountId,Name from Contact where AccountId In (select AccountId from Opportunity where Id In :opplist)];
        List<OpportunityContactRole> rolelist = new List<OpportunityContactRole>();
        System.debug('::11 conlist'+conlist);
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        
        System.debug(mapcon);
        
        for(Opportunity opp : opplist){
            if(mapcon.containskey(opp.AccountId)){
                for(Contact con : mapcon.get(opp.AccountId)){
                    OpportunityContactRole role = new OpportunityContactRole();
                    role.ContactId = con.Id;
                    role.OpportunityId = opp.Id;
                    rolelist.add(role);
                }
            }
        }
        
        if(!rolelist.isEmpty()){
            insert rolelist;
        }
    }
}