public class NoofOpportunityEqNoOfEmp {
    public static void updateAcc(List<Account> acclist, Map<Id,Account> maps){
        System.debug('acclist==>'+acclist);
        System.debug('maps==>'+maps);
        List<Opportunity> opplist = new List<Opportunity>();
        List<Opportunity> opplistformap = new List<Opportunity>();
        List<Opportunity> dellist = new List<Opportunity>();
        opplistformap = [select Id,Name,AccountId from Opportunity where AccountId != null];
        System.debug('opplistformap'+opplistformap);
        Map<Id,List<Opportunity>> mapoppWithAcc = new Map<Id,List<Opportunity>>();
        for(Opportunity opp : opplistformap){
            if(!mapoppWithAcc.containsKey(opp.AccountId)){
                mapoppWithAcc.put(opp.AccountId,new List<Opportunity>{opp});
            }else{
                mapoppWithAcc.get(opp.AccountId).add(opp);
            }
        }
        System.debug('mapoppWithAcc==>'+mapoppWithAcc);
        for(Account acc : acclist){
            if(mapoppWithAcc.get(acc.Id) == null){
                for(Integer i = 0; i<acc.NumberOfEmployees;i++){
                    Opportunity opp = new Opportunity();
                    Opp.Name = acc.Name+'opp'+i;
                    opp.AccountId = acc.Id;
                    opp.CloseDate = Date.today()+60+i;
                    opp.StageName = 'Closed Won';
                    opplist.add(opp);
                }
            }
            if(mapoppWithAcc.containskey(acc.Id)){
               /* if(maps.get(acc.Id).NumberOfEmployees == null){
                    maps.get(acc.Id).NumberOfEmployees = 0;
                } */
                Integer diff;
                Integer oldNumberOfEmployees = maps.get(acc.Id).NumberOfEmployees == null ? 0 : maps.get(acc.Id).NumberOfEmployees;
                System.debug('Name'+acc.Name);
                System.debug('old map==>'+maps.get(acc.Id).NumberOfEmployees);
                if(acc.NumberOfEmployees > oldNumberOfEmployees){
                   
                    diff = acc.NumberOfEmployees - oldNumberOfEmployees;
                    System.debug('diff'+diff);
                    for(Integer i = 0; i<diff;i++){
                        Opportunity opp = new Opportunity();
                        Opp.Name = acc.Name+'opp'+i;
                        opp.AccountId = acc.Id;
                        opp.CloseDate = Date.today()+60+i;
                        opp.StageName = 'Closed Won';
                        opplist.add(opp);
                    }
                }
                else if(oldNumberOfEmployees >= acc.NumberOfEmployees){
                    diff = oldNumberOfEmployees - acc.NumberOfEmployees;
                    System.debug('else if diff==>'+diff);
                    List<Opportunity> oldopplist = new List<Opportunity>();
                    oldopplist = mapoppWithAcc.get(acc.Id);
                    System.debug('oldconlist==>'+oldopplist);
                    for(Integer i = 0; i< diff;i++){
                        dellist.add(oldopplist[i]);
                    }
                    System.debug(diff);
                }
            }
            
        }
        if(!opplist.isEmpty()){
            insert opplist;
        } 
        if(!dellist.isEmpty()){
            delete dellist;
        }else{
            System.debug(dellist);
        } 
    }
}