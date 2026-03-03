public class OpportunityStatusClass {
    public static void disp(){
        List<Opportunity> oplist = [select Name,Amount from Opportunity where StageName = 'Closed Won' Order By Amount DESC];
    }
}