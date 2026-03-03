public class Case5accCon {
    public static void add(){
        List<Case> caselist = new List<Case>();
        for(Integer i = 0; i<5;i++){
            Account acc = new Account();
            acc.Name = 'case'+i;
            Contact con = new Contact();
            con.FirstName = 'con';
            con.LastName = 'case'+i;
            insert acc;
            insert con;
            Case c = new Case();
            c.AccountId = acc.Id;
            c.ContactId = con.Id;
            caselist.add(c);
            
        }
        if(!caselist.isEmpty()){
            insert caselist;
            System.debug(caselist);
        }
    }
}