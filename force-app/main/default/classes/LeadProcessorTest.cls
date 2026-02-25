@isTest
public class LeadProcessorTest {
    @testSetup static void createData(){
        List<Lead> leadlist = new List<Lead>();
        for(Integer i = 0; i<200;i++){
            Lead ld = new Lead();
            ld.LastName = 'Test'+i;
            ld.Company = 'Salesforce';
            leadlist.add(ld);
        }
        insert leadlist;
    }
    testMethod static void case1(){
        List<Lead> leadlist = new List<Lead>();
        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Database.executeBatch(lp,200);
        Test.stopTest();
        leadlist = [select Id from Lead where LeadSource = 'Dreamforce'];
        System.assertEquals(200, leadlist.size());
    }
}