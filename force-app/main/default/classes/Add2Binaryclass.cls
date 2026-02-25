public class Add2Binaryclass {
    
    public static void add(String s1,String s2){
    integer s1Len = s1.length();
    integer s2Len = s2.length();
    integer carry=0; 
    string result='';
    integer i=0;
        
        while(i<s1Len||i<s2Len||carry!=0){
            Integer x = 0;
            Integer y=0;
            if(i<s1Len &&  s1.substring(s1Len-1-i,s1Len-i)=='1'){
                x=1;
            }
            if(i<s2Len && s2.substring(s2Len-1-i,s2Len-i)=='1'){
                y=1;
            }
            System.debug(x+':'+y);
            Integer temp=math.mod(x+y+carry,2);
            result =  string.valueOf(temp) + result; 
            carry =(x+y+carry)/2;
            i++;
        } 
 
   	system.debug('result :' + result);
    }
    
}