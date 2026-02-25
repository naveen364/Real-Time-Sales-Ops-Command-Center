public class CheckRecursion {
    Private static boolean run = true;
    Public static boolean runOnce(){
        if(run){
            run=false;
            return true;
        }
        else{
            return run;
        }
    }
}