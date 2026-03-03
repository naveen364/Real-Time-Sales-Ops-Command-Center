//Handler
public class AlertOpportunityWhenClosedAndNoLinedItem {
    public static void alert(List<Opportunity> opplist){
        List<OpportunityLineItem> lineitemlist = new List<OpportunityLineItem>();
        lineitemlist = [select Id,OpportunityId from OpportunityLineItem where OpportunityId In :opplist];
        for(Opportunity opp : opplist){
            if(lineitemlist.size()<1 && opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
                opp.addError(' Opportunity is being closed with no Opportunity line items in it');
            }
        }
    }
}