public with sharing class OMS_ProductService {
    
    /**
     * @description Fetch products with optional filtering.
     * @param category Filter by category (optional)
     * @param searchKey Search term for Name or SKU (optional)
     * @return List of Product__c
     */
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getProducts(String category, String searchKey) {
        String query = 'SELECT Id, Name, SKU__c, Price__c, Stock_Quantity__c, Category__c, Image_URL__c FROM Product__c';
        List<String> conditions = new List<String>();
        
        if (String.isNotBlank(category) && category != 'All') {
            conditions.add('Category__c = :category');
        }
        
        if (String.isNotBlank(searchKey)) {
            String searchLike = '%' + searchKey + '%';
            conditions.add('(Name LIKE :searchLike OR SKU__c LIKE :searchLike)');
        }
        
        if (!conditions.isEmpty()) {
            query += ' WHERE ' + String.join(conditions, ' AND ');
        }
        
        query += ' ORDER BY Name ASC LIMIT 100';
        
        return Database.query(query);
    }
    
    /**
     * @description Update stock for a product.
     */
    @AuraEnabled
    public static void updateStock(Id productId, Integer newQuantity) {
        try {
            Product__c prod = [SELECT Id, Stock_Quantity__c FROM Product__c WHERE Id = :productId LIMIT 1];
            prod.Stock_Quantity__c = newQuantity;
            update prod;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating stock: ' + e.getMessage());
        }
    }
    
    /**
     * @description Create or Update a product.
     */
    @AuraEnabled
    public static Product__c upsertProduct(Product__c product) {
         try {
            upsert product;
            return product;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving product: ' + e.getMessage());
        }
    }
}