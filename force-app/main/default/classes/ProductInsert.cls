public class ProductInsert {
    public static void insertProd(String name,String descp,String fam){
        Product2 pro = new Product2();
        pro.Name = name;
        pro.Description = descp;
        pro.Family = fam;
        insert pro;
    }
    public static void getData(){
        for(Integer i=0; i<10; i++){
            insertProd('Test '+i,'This is Test '+i,'None');
        }
    }
}