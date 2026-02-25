public class color {
    
    public static void disp(){
        List<String> colors = new List<String>{'red','green','blue'};
   		List<String> moreColors = new List<String>();
        moreColors =colors;
        moreColors.add('pink');
        for(Integer i=0;i<moreColors.size();i++) {
            System.debug(moreColors[i]);
        }
    }
}