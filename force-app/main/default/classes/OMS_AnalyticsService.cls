public with sharing class OMS_AnalyticsService {
    
    public class DashboardData {
        @AuraEnabled public Decimal totalRevenue;
        @AuraEnabled public Integer totalOrders;
        @AuraEnabled public Integer lowStockCount;
        @AuraEnabled public List<Product__c> lowStockItems;
    }
    
    @AuraEnabled(cacheable=true)
    public static DashboardData getDashboardData() {
        DashboardData data = new DashboardData();
        
        // Mocking aggregate query logic or assuming simple queries for the prototype
        // In a real scenario, use AggregateResult on Order__c and Order_Item__c
        
        // 1. Total Revenue (This month)
        // Ensure Total_Amount__c is a Roll-up Summary or calculated field on Order__c
        List<AggregateResult> revenueResult = [
            SELECT SUM(Total_Amount__c) total 
            FROM Order__c 
            WHERE CreatedDate = THIS_MONTH
        ];
        data.totalRevenue = (Decimal)revenueResult[0].get('total');
        if (data.totalRevenue == null) data.totalRevenue = 0;
        
        // 2. Total Orders (This month)
        List<AggregateResult> orderCountResult = [
            SELECT COUNT(Id) total 
            FROM Order__c 
            WHERE CreatedDate = THIS_MONTH
        ];
        data.totalOrders = (Integer)orderCountResult[0].get('total');
        
        // 3. Low Stock Items (< 10)
        data.lowStockItems = [
            SELECT Id, Name, Stock_Quantity__c, SKU__c 
            FROM Product__c 
            WHERE Stock_Quantity__c < 10 
            ORDER BY Stock_Quantity__c ASC 
            LIMIT 5
        ];
        data.lowStockCount = [SELECT COUNT() FROM Product__c WHERE Stock_Quantity__c < 10];
        
        return data;
    }
}