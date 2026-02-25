@isTest
public class TestOpportunitycontactRolecopy {
    @testSetup public static void createData(){
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
            acc.Active__c = 'Yes';
            acclist.add(acc);
        }
        insert acclist;
        for(Account acc : acclist){
            for(Integer j = 0; j<=5;j++){
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.CloseDate =Date.today()+49;
                opp.Name = acc.Name;
                opp.StageName = 'Close Won';
                opplist.add(opp);
                conlist.add(con);
            }
        }
        insert conlist;
        insert opplist;
    }
    @isTest public static void case1(){
        List<Account> acclist = new List<Account>();
        acclist = [select Id,NumberOfEmployees,Name from Account where Name Like 'Test%'];
        Test.startTest();
        update acclist;
        Test.stopTest();
    }
}