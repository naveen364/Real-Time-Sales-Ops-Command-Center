public class OrderLocation {
    public static void loc(){
        List<Account> acclist = new List<Account>();
        List<Order_locoation_c__c> ollist = new List<Order_locoation_c__c>();
        acclist = [select Id,Name,Location__c from Account where Location__c != null];
        ollist = [select Id,Account__c,Treval_Location__c,Total_Distance__c,Name from Order_locoation_c__c where Account__c != null];
        for(Account acc : acclist){
            for(Order_locoation_c__c ol : ollist){
                if(ol.Account__c == acc.Id){
                    if(ol.Treval_Location__c == 'B' && acc.Location__c == 'A'){
                        ol.Total_Distance__c = 10.0;
                    }
                    if(ol.Treval_Location__c == 'C' && acc.Location__c == 'B'){
                        ol.Total_Distance__c = 20.0;
                    }
                    if(ol.Treval_Location__c == 'D' && acc.Location__c == 'C'){
                        ol.Total_Distance__c = 38.0;
                    }
                    if(ol.Treval_Location__c == 'E' && acc.Location__c == 'D'){
                        ol.Total_Distance__c = 83.0;
                    }
                    if(ol.Total_Distance__c != null){
                        System.debug('ol.Name'+ol.Name+': Total Dist'+ol.Total_Distance__c+':acc.name'+acc.Name);
                        System.debug(acc.Location__c+'==>'+ol.Treval_Location__c+' : '+ol.Total_Distance__c);
                    }
                }
            }
        }
    }
}