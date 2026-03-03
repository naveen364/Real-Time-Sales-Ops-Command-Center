public class defaultPriceToProduct {
    public static void setDefaultPrice(List<Product2> prolist){
        Pricebook2 pricebook = [select Id from pricebook2 where IsStandard = True limit 1];
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        for(Product2 pro : prolist){
            PricebookEntry pbe = new PricebookEntry();
            pbe.Pricebook2Id = pricebook.Id;
            pbe.UnitPrice =1;
            pbe.Product2Id = pro.Id;
            pbeList.add(pbe);
        }
        if(!pbeList.isEmpty()){
            insert pbeList;
        }
    }
}