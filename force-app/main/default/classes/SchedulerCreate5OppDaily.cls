public class SchedulerCreate5OppDaily implements Schedulable{
	public static void execute(SchedulableContext sct){
        Database.executeBatch(new BetchCreate5OppDaily());
    }
}
//public static String CRON_EXP = '0 0 0 ? * *';
//public static String CRON_EXP1 = '0 0 6 ? * *';
//public static String CRON_EXP2 = '0 0 12 ? * *';
//public static String CRON_EXP3 = '0 0 18 ? * *';
//System.Schedule('scheduleModulesTrial',CRON_EXP,new scheduleModulesTrial());
//
//Delete above Schedule
//List<CronTrigger> jobsToAbort = [select Id from CronTrigger where CronJobDetail.JobType = '7'];
//for (CronTrigger job : jobsToAbort) { System.abortJob(job.Id); }