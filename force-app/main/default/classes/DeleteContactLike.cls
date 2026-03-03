public class DeleteContactLike {
    public static void deleteContact(){
       	List<Contact> con = [select Name from Contact where Account.Name like '%a%'];
        delete con;
    }
}