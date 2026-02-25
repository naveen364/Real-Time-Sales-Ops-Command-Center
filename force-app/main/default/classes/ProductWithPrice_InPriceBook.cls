public class ProductWithPrice_InPriceBook {
    public static void priceBook(){
        for(Integer i=0;i<10;i++){
           
            Pricebook2 price = [select Id from Pricebook2 where isStandard=true limit 1];
            Product2 pro = new Product2();
            pro.Name = 'Algo'+i;
            insert pro;
            PricebookEntry p_entry = new PricebookEntry();
            p_entry.Pricebook2Id = price.Id;
            p_entry.Product2Id = pro.Id;
            p_entry.UnitPrice = 234567 + i;
            p_entry.UseStandardPrice = False;
            p_entry.IsActive = True;
            insert p_entry;
           
        }
        
    }
}