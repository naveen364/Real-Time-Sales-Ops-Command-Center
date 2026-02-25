/*Make two number fields on contact object
        Amount_X
        Amount_Y
        2) Make one picklist field "Type" , values ('Positive', 'Negative') on Account Object
        3) Make two number fields on account
        Rollup_Amount_X
        Rollup_Amount_Y
        Rollup_Amount
        4) Make one trigger on contact object, which will do following:
        --> Sum all child of contact's field "Amount_X" and store in parent account's "Rollup_Amount_X" Where Account's Type is "Positive"
        --> Sum all child of contact's field "Amount_Y" and store in parent account's "Rollup_Amount_Y" Where Account's Type is "Negative"
        --> Sum all child of contact's field "Amount_X" + "Amount_Y" and store in parent account's "Rollup_Amount"*/
public class RollupAccount {
    public static void roll(List<Contact> triggerlist){
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        System.debug('triggerlist'+triggerlist);
        acclist = [select Id,Rollup_Amount_X__c,Type__c,Rollup_Amount_Y__c from Account where Id In (select AccountId from Contact where Id In :triggerlist)];
        System.debug('acclist==>'+acclist);
        conlist = [select Id,AccountId,Amount_Y__c,Amount_X__c from Contact where Id In :triggerlist];
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        Decimal Amount_X = null , Amount_Y = null,total;
        for(Account acc : acclist){
            for(Contact con : mapcon.get(acc.Id)){
                if(Amount_X == null && Amount_Y == null){
                    Amount_X = con.Amount_X__c;
                    Amount_Y = con.Amount_Y__c;
                    continue;
                }
                Amount_X +=con.Amount_X__c;
                Amount_Y +=con.Amount_Y__c;
            }
            if(acc.Type__c == 'Positive'){
            	acc.Rollup_Amount_X__c = Amount_X;
            }else
            if(acc.Type__c == 'Negative'){
            	acc.Rollup_Amount_Y__c = Amount_Y;
            }
            acc.Rollup_Amount__c = Amount_X+Amount_Y;
            
            System.debug('Acc'+acc);
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}