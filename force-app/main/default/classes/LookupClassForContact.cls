public class LookupClassForContact {
    public static void lookup(){
        List<Account> actList = [Select ID, Name From Account Where Name Like '%lookupwith%' Limit 50000 ];
        
        List<Contact> conList = new List<Contact>();
        for(Account acc : actList){
            Contact con  = new Contact();
            con.LastName = 'Contact Test'+acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
}