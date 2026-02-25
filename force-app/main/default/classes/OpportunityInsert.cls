public class OpportunityInsert {
    public static void insertOpp(String name){
        try{
            Opportunity opp = new Opportunity();
            opp.Name = name;
            Date dates = Date.newInstance(1960, 2, 17);
            opp.CloseDate = dates;
            opp.StageName = 'Prospecting';
            insert opp;
        }catch(DmlException e){
            System.debug(e.getMessage());
        }
    }
    public static void getdata(){
        String picklist = 'Prospecting';
        for(Integer i = 0;i<=20;i++){
            insertOpp('xyz'+i);
        }
    }
}