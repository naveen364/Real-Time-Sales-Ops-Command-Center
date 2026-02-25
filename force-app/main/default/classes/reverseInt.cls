public class reverseInt {
    public static void print(Integer num){
        Integer rev=0;
        while(num!=0){
            Integer rem = Math.mod(num,10);
            rev = rev*10+rem;
            num = num/10;
        }
        System.debug(rev);
    }
}