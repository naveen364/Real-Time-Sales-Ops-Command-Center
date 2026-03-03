public class FibonacciClass {
    public static void print(Integer num){
        Integer first = 0;
        Integer second = 1;
        Integer nxt;
        for(Integer i = 0;i<num;i++){
        	nxt = first+second;
            System.debug(nxt);
            first = second;
            second = nxt;
        }
    }
}