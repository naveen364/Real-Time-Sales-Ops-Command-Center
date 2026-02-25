public without Sharing class DailyLeadProcessor implements Schedulable {
    public static void execute(SchedulableContext sct){
        List<Lead> ldlist = new List<Lead>();
        ldlist = [select Id,LeadSource from Lead where LeadSource = null];
        for(Lead ld : ldlist){
            ld.LeadSource = 'Dreamforce';
        }
        update ldlist;
    }
}