public class reverseClass {
    public static void print(String str){
        String rev = '';
        System.debug(str.reverse());
        
        for(Integer i=str.length()-1;i>=0;i--){
            rev+=str.substring(i,i+1);
        }
        System.debug(rev);
    }
}