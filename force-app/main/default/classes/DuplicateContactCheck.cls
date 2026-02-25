//Create a custom field called duplicate(checkbox)
 //type check box in Account.
//=> Write a script to check if the contact in the Account and contact roles in its related opportunity are same then set the checkbox to true.
public class DuplicateContactCheck {
    public static void contact_Related_ContactRole(){
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        set<Id> accset = new set<Id>();
        
        conlist = [select Id,LastName,AccountId,Account.duplicate__c from Contact Where AccountId != null];
        
        List<OpportunityContactRole> conrolelist = new List<OpportunityContactRole>();
        conrolelist = [select Id,ContactId,OpportunityId,Opportunity.AccountId from OpportunityContactRole where OpportunityId != null And Opportunity.AccountId != null];
        
        Map<Id,List<OpportunityContactRole>> mapoppRcon_role = new Map<Id,List<OpportunityContactRole>>();
        
        for(OpportunityContactRole oppconrole : conrolelist){
            if(!mapoppRcon_role.Containskey(oppconrole.Opportunity.AccountId)){
                mapoppRcon_role.put(oppconrole.Opportunity.AccountId,new List<OpportunityContactRole>{oppconrole});
            }else{
                mapoppRcon_role.get(oppconrole.Opportunity.AccountId).add(oppconrole);
            }
        }
        System.debug('Map opp.acc R con_role ==>'+mapoppRcon_role);
        
        for(Contact con : conlist){
            if(mapoppRcon_role.get(con.AccountId) != null){
                for(OpportunityContactRole ocr : mapoppRcon_role.get(con.AccountId)){
                    if(con.Id == ocr.ContactId){
                        accset.add(con.AccountId);
                    }
                    
                }
            }
        }
        for(Id ids : accset){
            Account acc = new Account();
            acc.Id = ids;
            acc.duplicate__c = True;
            acclist.add(acc);
        }
        
        System.debug('set'+accset);
        //System.debug('List'+acclist);
        if(!acclist.isEmpty()){
            update acclist;
        }
        
    }
}