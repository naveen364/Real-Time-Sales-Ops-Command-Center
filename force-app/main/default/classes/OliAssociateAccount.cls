/*Write a script to calculate total number of opportunity product associated with an account, if any account has equal number 
of opportunity products then print the recent updated account with total number of opportunity products.*/
public class OliAssociateAccount {
    public static void answer(){
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id from Opportunity where AccountId != null limit 50000];
        Map<Id,Integer> mapoli = new Map<Id,Integer>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        olilist = [select Id,Opportunity.AccountId,Opportunity.Account.LastModifiedDate from OpportunityLineItem where Opportunity.AccountId !=null limit 50000];
        System.debug('oliist'+olilist);
        for(OpportunityLineItem oli : olilist){
            if(!mapoli.containsKey(oli.Opportunity.AccountId)){
                mapoli.put(oli.Opportunity.AccountId,1);
            }else{
                mapoli.put(oli.Opportunity.AccountId,mapoli.get(oli.Opportunity.AccountId)+1);
            }
        }
        Map<Id,Account> mapOfAccount = new Map<Id,Account> ([select id,name,LastModifiedDate from Account where id in :mapoli.keyset()]);
        System.debug('mapoli==>'+mapoli);
        Map<Integer,Id> mapOfDiffProduct =new Map<Integer,Id>();
        
        for(Account acc : [select id,name from Account where id in :mapoli.keyset()]){
            if(!mapOfDiffProduct.containskey(mapoli.get(acc.id))){
                mapOfDiffProduct.put(mapoli.get(acc.id),acc.id);
            }else{
                System.debug('old->'+mapOfAccount.get(mapOfDiffProduct.get(mapoli.get(acc.id))).LastModifiedDate+'\t'+mapOfAccount.get(mapOfDiffProduct.get(mapoli.get(acc.id))).Id);
                System.debug('new->'+mapOfAccount.get(acc.id).LastModifiedDate+'\t'+mapOfAccount.get(acc.id).Id);
                if(mapOfAccount.get(acc.id).LastModifiedDate > mapOfAccount.get(mapOfDiffProduct.get(mapoli.get(acc.id))).LastModifiedDate){
                    mapOfDiffProduct.put(mapoli.get(acc.id),acc.id);
                }
            }
        }
		
        System.debug('mapOfDiffProduct==>'+mapOfDiffProduct);
        /*List<Id> ListId = new List<Id>();
        List<Id> newListId = new List<Id>();
        List<Integer> totallist = new List<Integer>();
        List<Integer> total = new List<Integer>();
        
        for(Id ids : mapoli.keySet()){
            ListId.add(ids);
            total.add(mapoli.get(ids).size());
        }
        System.debug('totals'+total);
        
        Integer temp;
        Boolean t =true;
        Id tempId;
        for(Integer i = 0; i<total.size();i++){
            for(Integer j =0;j<total.size();j++){
                if(j != i){
                    if(total[i]!=total[j] && t == true){
                        if(!newListId.contains(ListId[i])){
                            newListId.add(ListId[i]);
                            totallist.add(total[i]);
                        }
                    }else{
                        t = false;
                        break;
                    }
                }
            } 
        }
        Integer i = 0;
        System.debug('newListId'+newListId);
        System.debug('totallist'+totallist);
        for(Id ids : newListId){
            for(Account acc : [select Id,Name from Account]){
                if(acc.Id == ids){
                    System.debug('Name'+acc.Name+':'+totallist[i]);
                    i=i+1;
                }
            }
        }*/
    }
}