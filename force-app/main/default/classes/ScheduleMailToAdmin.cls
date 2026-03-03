public without sharing class ScheduleMailToAdmin implements Schedulable {
    public static void execute(SchedulableContext sct){
        Database.executeBatch(new BatchEmailLead());
    }
}