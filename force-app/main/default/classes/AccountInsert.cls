public class AccountInsert {
    public static void insertAcc(String name,String accNumber,String phone){
        Account act = new Account();
        act.Name = name;
        act.AccountNumber = accNumber;
        act.Phone = phone;
        act.Fax = phone;
        act.NumberOfEmployees = 23;
        act.Website = act.Name+'.com';
        insert act;
    }
    public static void getdata(){
        for(Integer i=0;i<=15;i++){
            insertAcc('xyx'+i,'00001'+i,'99999999'+i);
        }
    }
}