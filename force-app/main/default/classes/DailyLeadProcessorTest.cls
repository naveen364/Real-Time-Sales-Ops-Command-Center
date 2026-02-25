@isTest
public class DailyLeadProcessorTest {
    Private static String CRON_EXP = '0 0 0 ? * * * ';
    @isTest static void Case1(){
        List<Lead> ld = new List<Lead>();
        for(Integer i = 0;i<200;i++){
            ld.add(new Lead(LastName = 'Xyz'+i,Company = 'Salesforce'));
        }
        insert ld;
        Test.startTest();
        String JobId = System.Schedule('Process lead',CRON_EXP,new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> updateld = new List<Lead>();
        updateld = [select Id,LeadSource from Lead where LeadSource = 'Dreamforce'];
        System.assertEquals(200, updateld.size());
    }
}