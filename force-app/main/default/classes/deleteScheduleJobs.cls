public class deleteScheduleJobs {
    public static void del(){
        List<CronTrigger> jobsToAbort = [select Id from CronTrigger where CronJobDetail.JobType = '7'];
        for (CronTrigger job : jobsToAbort) { 
            System.abortJob(job.Id); 
        }
    }
}