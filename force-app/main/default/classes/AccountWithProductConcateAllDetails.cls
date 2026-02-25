public class AccountWithProductConcateAllDetails {
    public static void concate(){
        List<Account> acclist = new List<Account>();
        List<OrderItem> olilist = new List<OrderItem>();
        Map<Id,List<OrderItem>> mapoli = new Map<Id,List<OrderItem>>();
        acclist = [select Id,order_Date__c,total_Amount__c,Quantity__c,Product_Name__c from Account];
        olilist =[select Id,Quantity,OrderId,Order.AccountId,Order.TotalAmount,Order.EffectiveDate from OrderItem where Order.AccountId In :acclist];
        
        for(OrderItem oli : olilist){
            if(!mapoli.containsKey(oli.Order.AccountId)){
                mapoli.put(oli.Order.AccountId,new List<OrderItem>{oli});
            }else{
                mapoli.get(oli.Order.AccountId).add(oli);
            }
        }
        System.debug('mapoli==>'+mapoli);
        for(Account acc : acclist){
            if(mapoli.containskey(acc.Id)){
                for(OrderItem oli : mapoli.get(acc.Id)){
                    acc.Product_Name__c = acc.Product_Name__c == null? oli.Product2.Name : acc.Product_Name__c + oli.Product2.Name;
                    acc.Quantity__c = acc.Quantity__c == null? String.valueOf(oli.Quantity) : acc.Quantity__c + String.valueOf(oli.Quantity);
                    acc.total_Amount__c = acc.total_Amount__c == null? String.valueOf(oli.Order.TotalAmount) : acc.total_Amount__c + String.valueOf(oli.Order.TotalAmount);
                    acc.order_Date__c = acc.order_Date__c == null? String.valueOf(oli.ServiceDate) : acc.order_Date__c + String.valueOf(oli.ServiceDate);
                }
            }
        }
        System.debug('acclist==>'+acclist);
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}