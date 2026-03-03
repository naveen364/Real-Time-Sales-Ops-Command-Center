public class oliById {
    @AuraEnabled
    public static List<OpportunityLineItem> get(String ids){
        Id i= Id.valueof(ids);
        System.debug('ids==>'+i);
        return [select Id,Quantity,TotalPrice,Opportunity.Name,Product2.Name from OpportunityLineItem where OpportunityId = :i];
    }
    @AuraEnabled
    public static void updateoli(List<OpportunityLineItem> olilist){
        System.debug('olilist==>'+olilist);
        update olilist;
    }
}