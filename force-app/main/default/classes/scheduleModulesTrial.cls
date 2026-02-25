public class scheduleModulesTrial implements Schedulable{
    public static void execute(SchedulableContext sct){
        Database.executeBatch(new BatchModule(), 2000);
    }
}