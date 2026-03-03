public class productQueryHighestPrice {
    public static void highestPrice(){
        List<PricebookEntry> pricebookentry = new List<PricebookEntry>();
        pricebookentry = [select Id, Name, Pricebook2Id, Product2Id, UnitPrice, IsActive, UseStandardPrice,ProductCode, IsDeleted,Product2.Id, Product2.Name from PricebookEntry Order By UnitPrice Desc Limit 10];
        for(PricebookEntry pentry : pricebookentry){
            System.debug(pentry.Product2.Name);
        }
        //List<Product2> prolist = [select Id,Name from Product2];
       // List<PricebookEntry> prilist =[select Product2Id,UnitPrice from PricebookEntry Order By UnitPrice Desc Limit 1];
        
        //for(Product2 pro : prolist){
            //for(PricebookEntry price : prilist){
               // if(pro.Id == price.Product2Id){
               //     System.debug(pro.Name);
                //}
            //}
        //}
        
    }
}