public class MailHandler {
    public static void check(){
        EmailManager mail = new EmailManager();
        //List<String> str = new List<String>();
        //str =['npandit364@gmail.com','npandit463@gmail.com','panditnaveenbaidnath@gmail.com','xrtyuio@gmail.com','lkjhgfrfvhk@gmail.com'];
        String[] arr = new String[] {'npandit364@gmail.com','npandit463#gmailcom','npandit463@gmail.com','panditnaveenbaidnath@gmail.com','-@gmailcom','lkjhgfrfvhkmail.com'};
            for(String a : arr){
                System.debug('a==>'+a);
                mail.sendMail( a , 'This is Test Apex', 'nice to meet you');
            }
    }
}