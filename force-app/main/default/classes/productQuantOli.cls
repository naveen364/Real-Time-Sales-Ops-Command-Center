public class productQuantOli {
	public static void oliAssociateAccount(){
        List<OpportunityLineItem> olilist =new List<OpportunityLineItem>();
        olilist = [select Id,Opportunity.AccountId,Quantity,Opportunity.Account.Name,Product2.Name,Product2Id from OpportunityLineItem where Opportunity.AccountId != null And Quantity>100 And Opportunity.StageName = 'Closed Won'];
        for(OpportunityLineItem oli : olilist){
            for(Product2 pro : [select Id,Name from Product2]){
                if(oli.Product2Id == pro.Id){
                    System.debug('name'+pro.Name+'\n quantity'+oli.Quantity);
                }
            }
        }
    }
}