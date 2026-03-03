public class TotalAmountOpp {
    public static void total(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        opplist = [select Id from Opportunity where CloseDate <= :Date.today()+30];
        olilist = [select Id,OpportunityId,TotalPrice from OpportunityLineItem where OpportunityId In :opplist And Quantity >50];
        Decimal total_amount = 0.0;
        for(Opportunity opp : opplist){
            total_amount =	0.0;
            for(OpportunityLineItem oli : olilist){
                if(oli.OpportunityId == opp.Id){
                    total_amount +=oli.TotalPrice;
                }
            }
            System.debug('Total_amount'+total_amount);
        }
    }
}