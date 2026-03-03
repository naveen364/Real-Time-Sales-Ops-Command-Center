public class DateDiffClass {
    public static void disp(){
        Date startDate = Date.newInstance(2022, 7, 12);
        Date endDate = Date.newInstance(2020, 2, 1);
        Integer daybtw = startDate.daysBetween(endDate);
        Integer monthbtw = startDate.monthsBetween(endDate);
        Integer yearbtw = startDate.year() - endDate.year();
        Time startTime = Time.newInstance(9, 52, 30, 23);
        Time endTime = Time.newInstance(2, 5, 3, 2);
        Integer diffHour = startTime.hour() - endTime.hour();
		Integer diffMin = startTime.minute() - endTime.minute();        
        Integer diffsec = startTime.second() - endTime.second();
        System.debug('difference are'+' '+diffHour+' '+diffMin+' '+diffsec+' '+daybtw+' '+monthbtw+' '+yearbtw);
    }
}