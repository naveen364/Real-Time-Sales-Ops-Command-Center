@isTest
public class AccountProcessorTest {
    @testSetup static void createData(){
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        for(Integer i = 0; i<30;  i++){
            acclist.add(new Account(Name = 'Test'+i));
        }
        insert acclist;
        for(Account acc : acclist){
            Contact con = new Contact();
            con.LastName = 'Test';
            con.AccountId = acc.Id;
            conlist.add(con);
        }
        insert conlist;
    }
    testMethod static void case1(){
		List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
		acclist = [select Id,Number_Of_Contacts__c,(select Id from Contacts) from Account];
        conlist = [select Id from Contact];
		List<Id> idslist = new List<Id>();
        for(Account acc : acclist){
            idslist.add(acc.Id);
        }
		Test.startTest();
        AccountProcessor.countContacts(idslist);
		Test.stopTest();  
        System.debug('::30'+acclist);
        System.debug('::31'+conlist);
        acclist = [select Id,Number_Of_Contacts__c,(select Id from Contacts) from Account];
        for(Account acc : acclist){
           System.assertEquals(1,acc.Number_Of_Contacts__c);
           System.debug('acc.noOf'+acc.Number_Of_Contacts__c);
        }
        
    }
}