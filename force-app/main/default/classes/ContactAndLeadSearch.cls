public class ContactAndLeadSearch {
    public static void searchContactsAndLeads(String first){
        
        List<List<sObject>> searchs = [FIND :first IN ALL FIELDS RETURNING Contact(FirstName,LastName)];
        
        Contact[] conlist = (Contact[])searchs[0];
        for(Contact con : conlist){
            System.debug(con.LastName+' '+con.FirstName);
        }
    }
}