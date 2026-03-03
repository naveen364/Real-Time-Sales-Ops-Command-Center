/*Write a script to get all the opportunity name if opportunity' 
account name is same as the ContactRole Account name and Opportunity is Closed won or closed lost.*/

public class OppAccNameEqualContactRoleAccName {
    public static void answer(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityContactRole> crlist = new List<OpportunityContactRole>();
		opplist =[select Id,Name,Account.Name,StageName from Opportunity where AccountId != null limit 50000];
		crlist =[select Id,OpportunityId,Opportunity.Account.Name from OpportunityContactRole where OpportunityId != null limit 50000];
        for(Opportunity opp : opplist){
            for(OpportunityContactRole ocr : crlist){
                if(opp.Account.Name == ocr.Opportunity.Account.Name && (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost')){
                    System.debug('Name'+opp.Name);
                }
            }
        } 
        //confused in this question 
        //we can do by query too
        //crlist =[select Id,OpportunityId,Opportunity.Account.Name from OpportunityContactRole where OpportunityId != null and Opportunity.StageName == 'Closed Won' || Opportunity.StageName == 'Closed Lost' limit 50000];
    }
}