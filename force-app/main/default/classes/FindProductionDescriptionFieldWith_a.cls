public class FindProductionDescriptionFieldWith_a {
    public static void fieldWith_A(){
        List<Product2> lstproduct = [Select Description from Product2 where Description like '%T%'];
        for(Product2 pro : lstproduct){
            System.debug(pro.Description+' with name '+pro.Name);
        }
    }
}