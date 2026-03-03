public class AppointmentDoctor {
    public static void doctorPatient(List<Appointment__c> triggerlist){
        
        Map<Id,List<Appointment__c>> mapappoint = new Map<Id,List<Appointment__c>>();
        Map<Id,List<Id>> mapId = new  Map<Id,List<Id>>();
        
        List<Appointment__c> applist = new List<Appointment__c>();
        List<Patient__c> Patientlist = new List<Patient__c>();
        List<Doctor__c> Doctorlist = new List<Doctor__c>();
        
        applist = [select Id,Doctor__c,Patient__c,Appointment_Date__c from Appointment__c];
        
        for(Appointment__c app :applist){
            if(!mapappoint.containskey(app.Doctor__c)){
                mapappoint.put(app.Doctor__c,new List<Appointment__c>{app});
            }else{
                mapappoint.get(app.Doctor__c).add(app);
            }
        }
        System.debug('mapappoint'+mapappoint);
        Integer counterDoc;
        for(Id ids : mapappoint.keyset()){
            counterDoc = 0;
            if(counterDoc > 8){
                triggerlist[0].Doctor__c.addError('Limit Exceeded more then 8 appointment!');
            }
            for(Appointment__c app : mapappoint.get(ids)){
                try{
                    for(Integer i = 0; i<triggerlist.size(); i++){
                        if(app.Doctor__c == triggerlist[i].Doctor__c && app.Patient__c == triggerlist[i].Patient__c && app.Appointment_Date__c == triggerlist[i].Appointment_Date__c){
                            triggerlist[i].Patient__c.addError('same Doctor with patient Limit Exceeded for Date ==>'+app.Appointment_Date__c);
                        }
                        if(app.Doctor__c == triggerlist[i].Doctor__c && app.Appointment_Date__c == triggerlist[i].Appointment_Date__c){
                            counterDoc++;
                        }
                    }
                }catch(ListException e){
                    
                }
            }
        }
    }
}