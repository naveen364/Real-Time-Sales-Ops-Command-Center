public class UserInfoClass {
    public static void detail(){
        String name = UserInfo.getName();
        String email = UserInfo.getUserEmail();
        String user_id = UserInfo.getUserId();
        List<User> ulist = new List<User>();
        String phone;
        ulist = [select Id,MobilePhone from User where Id = :user_id ];
        for(User u : ulist){
            phone = u.MobilePhone;
        }
        System.debug('username '+name+'\n email : '+email+'\n phone'+phone);
    }
}