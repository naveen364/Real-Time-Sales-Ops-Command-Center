public class ScheduleForEvery5min implements Schedulable {
	public static void execute(SchedulableContext sct){
        Database.executeBatch(new BatchUpdateAccCountContact());
    }
}
/*System.schedule('5min update acc', '0 0 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc1', '0 5 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc2', '0 10 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc3', '0 15 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc4', '0 20 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc5', '0 25 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc6', '0 30 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc7', '0 35 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc8', '0 40 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc9', '0 45 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc10', '0 50 0 ? * * *', new ScheduleForEvery5min());
System.schedule('5min update acc11', '0 55 0 ? * * *', new ScheduleForEvery5min());

for(Integer i = 0;i<60;i+=5){
	System.schedule('5min update acc'+i, '0 '+i+' 0 ? * * *', new ScheduleForEvery5min());
}

*/