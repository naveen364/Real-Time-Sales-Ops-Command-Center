public class CreateSystemAdminUser {
    public static void disp(String name, String alias){
        Profile pf = [select Id from Profile where Name = 'System Administrator' Limit 1];
        User user = new User();
        user.LastName = name;
        user.Username = 'anish.swar01@cloudanalogy.com';
        user.Email = 'anish.swar@cloudanalogy.com';
        user.Alias = alias;
       	user.LocaleSidKey = 'en_US';
		user.TimeZoneSidKey = 'GMT';
        user.IsActive = true;
        user.ProfileID = pf.Id;
		user.LanguageLocaleKey = 'en_US';
		user.EmailEncodingKey = 'UTF-8';
        try{
           insert user;
            
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        
    }
}