public class NoPastDateInOpportunity {
    public static void noPast(List<Opportunity> opplist){
        for(Opportunity op : opplist){
            if(op.CloseDate != null){
                if(op.CloseDate < Date.today()){
                    op.CloseDate.addError('Please enter a future Closed Date');
                    System.debug('Please enter a future Closed Date');
                }
            }
    	}
    }
}