@isTest
public class TestNoOfOpportunityEqNoOfEmp {
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
                for(Integer j =1;j<=6;j++){
                    Opportunity opp = new Opportunity();
                    if(j == 2 && j == 3){
                        opp.AccountId = null;
                    }else{
                        opp.AccountId = acc.Id;
                    }
                    system.debug('opp.AccountId==>'+opp.AccountId);
                    opp.Name = acc.Name+'Testclass';
                    opp.StageName = 'Closed Won';
                    opp.CloseDate = Date.today()+k+j;
                    opplist.add(opp);
                }
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
    @isTest public static void check1(){
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        acclist = [select Id,NumberOfEmployees from Account where Name Like 'Test%'];
        system.debug('accList test class:::' + accList);
        Integer i = 0;
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
        system.debug('accList test class 2:::' + accList);
        accList[0].NumberOfEmployees = 10;
        if(CheckRecursion.runOnce()){
            Test.startTest();
            update acclist;
            Test.stopTest();
        }
    }
    @isTest public static void check2(){
        List<Account> acclist = new List<Account>();
        acclist = [select Id,NumberOfEmployees from Account where Name Like 'Test%'];
        for(Account acc : acclist){
            if(acc.NumberOfEmployees != null){
                acc.NumberOfEmployees = acc.NumberOfEmployees-1;
                    }
        }
        if(CheckRecursion.runOnce()){
            Test.startTest();
            update acclist;
            Test.stopTest();
        }
    }
}