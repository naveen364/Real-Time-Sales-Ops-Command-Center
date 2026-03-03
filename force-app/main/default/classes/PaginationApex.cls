public class PaginationApex {
    @AuraEnabled
   public static List<Opportunity> getOpportunities()
   {
       List<Opportunity> oppList = [SELECT Id, Name, StageName, CloseDate, Amount FROM Opportunity
            Where Amount!= Null order by Name ASC limit 30000];
       return oppList;
   }

   // This method is used for retrieving the list of opportunity records based on the search string
   @AuraEnabled
   public static List<Opportunity> getByName(String searchKey)
   {
       String name = '%' + searchKey + '%';
       List<Opportunity> oppList = [SELECT id, Name, StageName, CloseDate, Amount FROM Opportunity
              WHERE name LIKE :name and Amount!= Null order by Name ASC limit 30000];
       return oppList;
   }

}