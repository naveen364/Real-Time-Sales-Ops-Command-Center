@isTest
public class TestAccountoutofzipcheck {
    @testSetup static void createData(){
        //afterupdate; 
        List<Account> acclist = new List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        List<Contact> conlist = new List<Contact>();
        for(Integer i = 0; i<10; i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            if(Math.mod(i, 2) == 0){
                acc.NumberOfEmployees = 4;
            }else{
                acc.NumberOfEmployees = null;
            }
            system.debug('acc.NumberOfEmployees==>'+acc.NumberOfEmployees);
            acc.Match_Billing_Address__c = True;
            acc.BillingCity = 'delhi'+i+3;
            acc.BillingPostalCode = String.valueOf(i+3);
            acc.BillingStreet = 'm'+i+3;
            acc.BillingCountry = 'india';
            acclist.add(acc);
        }
        insert acclist;
        for(Account acc : acclist){
            integer k = 0;
            if(acc.Name != 'Test0'){
                System.debug('acc.Name'+acc.Name);
                for(Integer l = 0; l<=6;l++){
                    Contact con = new Contact();
                    con.LastName = acc.Name+'Test'+l;
                    con.AccountId = acc.Id;
                    con.MailingCity = 'delhi'+l;
                    con.MailingCountry = 'india';
                    con.MailingStreet = 'm'+l;
                    con.MailingPostalCode = String.valueOf(l);
                    conlist.add(con);
                }
                k++;
            }
        }
        insert opplist;
        insert conlist;
        //return acclist;
    }
	@isTest public static void accoutofzipcheck(){
        Integer l = 654;
        Integer i = 3;
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        acclist = [select Id,NumberOfEmployees from Account where Name Like 'Test%'];
        conlist = [select Id,LastName,MailingCity,MailingCountry,MailingStreet,MailingPostalCode from Contact where Name like 'Test%'];
        for(Account acc : acclist){
            system.debug('acc.NumberOfEmployee:::' + acc.NumberOfEmployees);
            if(acc.NumberOfEmployees != null){
                acc.NumberOfEmployees = acc.NumberOfEmployees+1;
                acc.BillingCity = 'delhi'+i;
                acc.BillingPostalCode = String.valueOf(i+4);
                acc.BillingStreet = 'm'+i;
                acc.BillingCountry = 'india';
                i++;
            } 
        }
        if(CheckRecursion.runOnce()){
            Test.startTest();
            update acclist;
            Test.stopTest();
        }
    }
}