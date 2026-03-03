public without Sharing class BatchTrailhead implements Schedulable {
    public static void  execute(SchedulableContext sct){
        Database.executeBatch(new RunBatchApex(),2000);
    }
}