public class AccountIsClosedWhenOpporunityTotalQuant {
    public static void is_Closed(){
        set<Id> setid = new set<Id>();
        List<Account> acclist = new List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        Map<Id,Decimal> mapofOppWithTotalQuant = new  Map<Id,Decimal>();
        opplist =[select Id,StageName,Name,AccountId from Opportunity where AccountId != null];
        olilist =[select Id,Quantity,OpportunityId from OpportunityLineItem where OpportunityId In :opplist];
        System.debug('::10 olilist ==>'+olilist);
        for(OpportunityLineItem oli : olilist){
            if(!mapofOppWithTotalQuant.containskey(oli.OpportunityId)){
                mapofOppWithTotalQuant.put(oli.OpportunityId,oli.Quantity);
            }else{
                mapofOppWithTotalQuant.put(oli.OpportunityId,mapofOppWithTotalQuant.get(oli.OpportunityId)+oli.Quantity);
            }
        }
        system.debug('mapofOppWithTotalQuant==>'+mapofOppWithTotalQuant);
        for(Opportunity opp : opplist){
            if(mapofOppWithTotalQuant.containskey(opp.Id)){
                if(mapofOppWithTotalQuant.get(opp.Id)>500 && mapofOppWithTotalQuant.get(opp.Id)<1600){
                    System.debug('::22 inside if 500 - 600'+opp.Name);
                    opp.StageName = 'Closed Won';
                    setid.add(opp.AccountId);
                }else if(mapofOppWithTotalQuant.get(opp.Id)>100 && mapofOppWithTotalQuant.get(opp.Id)<150){
                    System.debug('::27 inside if 100 - 150'+opp.Name);
                    opp.StageName = 'Closed Lost';
                    setid.add(opp.AccountId);
                }
            }
        }
        acclist = [select Id,Name,Is_Closed__c from Account where Id In :setid];
        for(Account acc : acclist){
            System.debug('::34 Account Name that closed'+acc.Name);
            acc.Is_Closed__c = true;
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
        System.debug('acclist==>'+acclist);
    }
}