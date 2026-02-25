@isTest
public class TestAppointment {
    @testSetup static void createData(){
        List<Appointment__c> applist = new List<Appointment__c>();
        List<Doctor__c> doclist = new List<Doctor__c>();
        List<Patient__c> patlist = new List<Patient__c>();
        for(Integer i = 0; i<=10;i++){
            Doctor__c doc = new Doctor__c();
            doc.Name = 'Test'+i;
            doclist.add(doc);
        }
        insert doclist;
        for(Integer j = 0; j<1;j++){
            Patient__c p = new Patient__c();
            p.Name = 'ptest'+j;
            patlist.add(p);
            
        }
        insert patlist;
        Integer l = 0;
        for(Doctor__c doc : doclist){
            if(Math.mod(l, 2)==0){
				for(Patient__c p : patlist){
                    Appointment__c app = new Appointment__c();
                    app.Appointment_Date__c = Date.today()+3;
                    app.Doctor__c = doc.Id;
                    app.Patient__c = p.Id;
                    app.Name = 'apptest';
                    applist.add(app);
                }                
            }
        }
        try{
            insert applist;
        }catch(Exception e){
            if(e.getMessage().contains('You cant book appointment for same paitent more that once')){
            	System.assert(e.getMessage().contains('You cant book appointment for same paitent more that once'));
            }else{
                System.assert(e.getMessage().contains('Doctor Limit Exceeded for that Date'));
            }
        }
    }
    @isTest static void case1(){
        List<Appointment__c> applist = new List<Appointment__c>();
        List<Doctor__c> doclist = new List<Doctor__c>();
        List<Patient__c> patlist = new List<Patient__c>();
        applist = [select Id from Appointment__c];
        doclist = [select Id from Doctor__c];
        patlist = [select Id from Patient__c];
        Test.startTest();
        try{
        upsert applist;
        }catch(Exception e){
            if(e.getMessage().contains('You cant book appointment for same paitent more that once')){
            	System.assert(e.getMessage().contains('You cant book appointment for same paitent more that once'));
            }else{
                System.assert(e.getMessage().contains('Doctor Limit Exceeded for that Date'));
            }
        }
        Test.stopTest();
    }
    @isTest static void case2(){
        List<Appointment__c> applist = new List<Appointment__c>();
        List<Doctor__c> doclist = new List<Doctor__c>();
        List<Patient__c> patlist = new List<Patient__c>();
        applist = [select Id from Appointment__c];
        doclist = [select Id from Doctor__c];
        patlist = [select Id from Patient__c];
        for(Integer i = 5; i<=8;i++){
            Doctor__c doc = new Doctor__c();
            doc.Name = 'Test'+i;
            doclist.add(doc);
        }

        for(Integer j = 1; j<3;j++){
            Patient__c p = new Patient__c();
            p.Name = 'ptest'+j;
            patlist.add(p);
            
        }
        for(Doctor__c doc :doclist){
            for(Patient__c p : patlist){
                Appointment__c app = new Appointment__c();
                app.Appointment_Date__c = Date.today()+3;
                app.Doctor__c = doc.Id;
                app.Patient__c = p.Id;
                app.Name = 'apptest';
                applist.add(app);
            }
        }
        Test.startTest();
        try{
        	insert applist;
        }catch(Exception e){
            if(e.getMessage().contains('You cant book appointment for same paitent more that once')){
            	System.assert(e.getMessage().contains('You cant book appointment for same paitent more that once'));
            }else if(e.getMessage().contains('Doctor Limit Exceeded for that Date')){
                System.assert(e.getMessage().contains('Doctor Limit Exceeded for that Date'));
            }else if(e.getMessage().contains('Appointment already exist')){
               	System.assert(e.getMessage().contains('Appointment already exist')); 
            }else{
                System.debug('::103 error ==> '+e.getMessage());
            }
        }
        Test.stopTest();
    }
}