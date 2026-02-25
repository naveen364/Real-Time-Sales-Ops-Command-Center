public class updateOpp {
    public static void updates(){
        Date dates = Date.today();
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Name from Opportunity where CloseDate>:Date.today()];
        System.debug(opplist);
        for(Opportunity opp : opplist){
            opp.Name+='F';
            
            System.debug(opp.Name);
        }
        if(!opplist.isEmpty()){
            update opplist;
        }
    }

}