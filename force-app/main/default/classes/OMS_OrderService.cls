public with sharing class OMS_OrderService {
    public class OrderWrapper {
        @AuraEnabled public String customerEmail { get; set; }
        @AuraEnabled public Decimal discount { get; set; }
        @AuraEnabled public List<OrderItemWrapper> items { get; set; }
    }
    public class OrderItemWrapper {
        @AuraEnabled public Id productId { get; set; }
        @AuraEnabled public Integer quantity { get; set; }
        @AuraEnabled public Decimal unitPrice { get; set; }
    }
    /**
     * @description Place a new order with transaction control.
     *              Validates stock, creates Order, creates OrderItems, and decrements stock.
     */
    @AuraEnabled
    public static Id placeOrder(OrderWrapper orderData) {
        Savepoint sp = Database.setSavepoint();
        
        try {
            // 1. Handle Customer (Find or Create)
            Id customerId;
            if (String.isNotBlank(orderData.customerEmail)) {
                List<Contact> existingContacts = [SELECT Id FROM Contact WHERE Email = :orderData.customerEmail LIMIT 1];
                if (!existingContacts.isEmpty()) {
                    customerId = existingContacts[0].Id;
                } else {
                    Contact newContact = new Contact(
                        LastName = 'Guest ' + System.currentTimeMillis(), // Placeholder name
                        Email = orderData.customerEmail
                    );
                    insert newContact;
                    customerId = newContact.Id;
                }
            } else {
                // Handle case where email is missing if strict, but for now we proceed or error?
                // Request said "ask for email", implies required.
                throw new AuraHandledException('Customer Email is required.');
            }
            // 2. Create Order
            Order__c newOrder = new Order__c();
            newOrder.Customer__c = customerId;
            newOrder.Status__c = OMS_Constants.ORDER_STATUS_COMPLETED; // Immediate completion for POS
            newOrder.Order_Date__c = System.now();
            newOrder.Discount__c = orderData.discount != null ? orderData.discount : 0;
            
            // Calculate total later, or let Roll-up Summary do it. 
            // For now, we'll rely on Roll-up Summary on Order__c (Total_Amount__c) from Order_Item__c.
            insert newOrder;
            
            List<Order_Item__c> itemsToInsert = new List<Order_Item__c>();
            List<Product__c> productsToUpdate = new List<Product__c>();
            
            // Collect Product Ids to query stock
            Set<Id> productIds = new Set<Id>();
            for (OrderItemWrapper item : orderData.items) {
                productIds.add(item.productId);
            }
            
            Map<Id, Product__c> productMap = new Map<Id, Product__c>(
                [SELECT Id, Name, Stock_Quantity__c FROM Product__c WHERE Id IN :productIds FOR UPDATE]
            );
            
            // 2. Process Items
            for (OrderItemWrapper item : orderData.items) {
                Product__c prod = productMap.get(item.productId);
                
                if (prod == null) {
                    throw new AuraHandledException(OMS_Constants.ERROR_PRODUCT_NOT_FOUND + ' ID: ' + item.productId);
                }
                
                if (prod.Stock_Quantity__c < item.quantity) {
                    throw new AuraHandledException(OMS_Constants.ERROR_INSUFFICIENT_STOCK + prod.Name);
                }
                
                // Decrement Stock
                prod.Stock_Quantity__c -= item.quantity;
                productsToUpdate.add(prod);
                
                // Create Line Item
                Order_Item__c lineItem = new Order_Item__c();
                lineItem.Order__c = newOrder.Id;
                lineItem.Product__c = item.productId;
                lineItem.Quantity__c = item.quantity;
                lineItem.Unit_Price__c = item.unitPrice;
                itemsToInsert.add(lineItem);
            }
            
            // 3. Commit Changes
            update productsToUpdate;
            insert itemsToInsert;
            
            return newOrder.Id;
            
        } catch (Exception e) {
            Database.rollback(sp);
            throw new AuraHandledException('Order Placement Failed: ' + e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Order__c> getRecentOrders() {
        return [
            SELECT Id, Name, Customer__r.Name, Customer__r.Email, Total_Amount__c, Status__c, Order_Date__c 
            FROM Order__c 
            ORDER BY Order_Date__c DESC 
            LIMIT 50
        ];
    }
}