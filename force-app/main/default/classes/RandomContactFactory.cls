public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer num, String Name){
        List<Contact> conlist = new List<Contact>();
        for(Integer i = 1; i<=num;i++){
            Contact con = new Contact(FirstName = 'Test '+i, LastName = Name);
            conlist.add(con);
        }
        return conlist;
    }
}