public class ActorsHavingLookupWithAcc {
    public static void actorAccount(){
        List<Account> acclist = new List<Account>();
        Map<Id,Decimal> maps = new Map<Id,Decimal>();
        List<Actor__c> actorlist = new List<Actor__c>();
        actorlist = [SELECT Id, Name, Rating__c,Account_Names__c FROM Actor__c where Rating__c >=10 And (Name like 'A%' Or Name like 'D%')];
        acclist = [SELECT Id, Name, TotalRating__c FROM Account];
        for(Account act : acclist){
            for(Actor__c actor : actorlist){
                if(actor.Account_Names__c == act.Id){
                    act.TotalRating__c = (act.TotalRating__c == null ? actor.Rating__c:act.TotalRating__c + actor.Rating__c);
                }
            }
            if(act.TotalRating__c != null){
                if(!maps.containsKey(act.Id)){
                    maps.put(act.Id,act.TotalRating__c);
                }
            }
        }
        System.debug(maps);
    }
}