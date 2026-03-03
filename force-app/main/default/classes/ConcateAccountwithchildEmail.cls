//Pandit Naveen
public class ConcateAccountwithchildEmail {
    public static void concate(){
        List<Account> actlist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        actlist = [select Id,Name from Account];
        Date days = Date.today() - 10;
        conlist = [select Id,AccountId,Email from Contact where AccountId != null And CreatedDate<:days And Email != null];
        for(Account act : actlist){
            for(Contact con : conlist){
                if(act.Id == con.AccountId){
                    act.Name +=con.Email;
                    acclist.add(act); 
                }
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
    
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
    //Q2 Create a new Product ""Gandhiji Chasma"". Add Price as 100$ in standard price book and any other price books as well. 
	//Create few oppportunites with Opportunity line item ""Gandhiji Chasma"". Write a script to get the total Price of all the Opportunity 
	//sold having Product ""Gandhiji Chasma
    public static void gandhiji(){
        Pricebook2 pb = [select Id from Pricebook2 where Name = 'Standard Price Book'];
        List<Product2> pro = [select Id from Product2 where Name = 'Gandhiji Chasma'];
        Decimal total = null;
        List<OpportunityLineItem> olilist = [select Id,OpportunityId,Product2Id,TotalPrice from OpportunityLineItem where Product2Id In :pro];
        for(OpportunityLineItem oli : olilist){
            
            if(total == null){
                total = oli.TotalPrice;
            }
            if(oli.TotalPrice != null){
                total = total+oli.TotalPrice;
            }
        }
        System.debug('total==>'+total);
    }
    
    //write a script to get the totalQuantity of product sold in only Account working on CA
    public static void totalQuantity(){
        Map<Id,Decimal> mapquant = new Map<Id,Decimal>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();//i have not make multipick in account for CA,BA etc
        olilist = [select Id,Opportunity.AccountId,Quantity from OpportunityLineItem where Opportunity.AccountId != null];
        for(OpportunityLineItem oli : olilist){
            if(!mapquant.containskey(oli.Opportunity.AccountId)){
                mapquant.put(oli.Opportunity.AccountId,oli.Quantity);
            }else{
                mapquant.put(oli.Opportunity.AccountId,mapquant.get(oli.Opportunity.AccountId)+oli.Quantity);
            }
        }
        System.debug('map==>'+mapquant);
    }
    //write a script to get all the Accounts having Opportunitylineitem >100 under their opportunty is Closed Lost only
    public static void oliAssociateAccount(){
        List<OpportunityLineItem> olilist =new List<OpportunityLineItem>();
        olilist = [select Id,Opportunity.AccountId,Quantity,Opportunity.Account.Name from OpportunityLineItem where Opportunity.AccountId != null And Quantity>100 And Opportunity.StageName = 'Closed Lost'];
        for(OpportunityLineItem oli : olilist){
            for(Account acc : [select Id,Name from Account]){
                if(oli.Opportunity.AccountId == acc.Id){
                    System.debug('name'+acc.Name+'\n quantity'+oli.Quantity);
                }
            }
        }
    }
  	// Write a trigger to update thr email field of account according to the related contact. 
  	// For ex. if a contact gets deleted its email should be removed,
 	//if contact is updated its email that should also be updated in account.
    public static void emailupdate(List<Contact> triggerlist){
        List<Account> acclist = new List<Account>();
        acclist =  [select Id,Email__c from Account where Id In (select AccountId from Contact where Id In :triggerlist)];
        List<Contact> conlist = [select Id,Name,AccountId,Email from Contact where AccountId != null And Id In :triggerlist];
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        System.debug('map'+mapcon);
        for(Account acc : acclist){
            for(Contact con : mapcon.get(acc.Id)){
                acc.Email__c = acc.Email__c == null ? con.Email : con.Email; 
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
    public static void delemail(List<Contact> triggerlist){
        List<Account> acclist = new List<Account>();
        acclist =  [select Id,Email__c from Account];
        List<Contact> conlist = [select Id,Name,AccountId,Email from Contact where AccountId != null And Id In :triggerlist];
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        System.debug('conlist'+conlist);
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        System.debug('map'+mapcon);
        for(Account acc : acclist){
            if(mapcon.containskey(acc.Id)){
                for(Contact con : mapcon.get(acc.Id)){
                    if(acc.Email__c != null){
                        acc.Email__c = (acc.Email__c).replace(con.Email,'');
                    }
                }
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}
//Write a script to get the total Quantity of Products sold in only Accounts working in B."
//List<Account> acclist = [select Id,Working from Account Where Working__c ='B'];
//List<Opp> opplist = [select Id,AccountId from Opp where AccountId In :acclist];
//List<OppLineitem> lineitem = [select Id,Total_price,OpportunityId from Opplineitem where OpportunityId In :opplist];