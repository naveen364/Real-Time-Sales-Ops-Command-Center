public class AppointmentHandler {
    public static void doctorPatient(List<Appointment__c> triggerlist){
        
        Map<String,List<Appointment__c>> mapappoint = new Map<String,List<Appointment__c>>();
        Map<String,List<Appointment__c>> oldmapappoint = new Map<String,List<Appointment__c>>();
        Map<String,List<Appointment__c>> pmapappoint = new Map<String,List<Appointment__c>>();
        Map<String,List<Appointment__c>> poldmapappoint = new Map<String,List<Appointment__c>>();
        
        List<Appointment__c> applist = new List<Appointment__c>();
        
        set<Id> docset = new set<Id>();
        set<Id> patiantset = new set<Id>();
        set<Date> dateset = new set<Date>();
        
        for(Appointment__c app : triggerlist){
            docset.add(app.Doctor__c);
            patiantset.add(app.Patient__c);
            dateset.add(app.Appointment_Date__c);
        }
        
        applist = [select Id,Doctor__r.Name,Patient__r.Name,Doctor__c,Patient__c,Appointment_Date__c from Appointment__c where (Doctor__c In :docset OR Patient__c In :patiantset) And Appointment_Date__c In :dateset];
        for(Appointment__c app : applist){
            System.debug('::23 applist'+app);
        }
        for(Appointment__c app :triggerlist){
            if(!mapappoint.containskey(app.Doctor__c+'.'+app.Appointment_Date__c)){
                mapappoint.put(app.Doctor__c+'.'+app.Appointment_Date__c,new List<Appointment__c>{app});
            }else{
                mapappoint.get(app.Doctor__c+'.'+app.Appointment_Date__c).add(app);
            }
            if(!pmapappoint.containskey(app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c)){
                pmapappoint.put(app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c,new List<Appointment__c>{app});
            }else{
                pmapappoint.get(app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c).add(app);
            }
        }
        
        for(Appointment__c app : applist){
            if(!oldmapappoint.containskey(app.Doctor__c+'.'+app.Appointment_Date__c)){
                oldmapappoint.put(app.Doctor__c+'.'+app.Appointment_Date__c,new List<Appointment__c>{app});
            }else{
                oldmapappoint.get(app.Doctor__c+'.'+app.Appointment_Date__c).add(app);
                //System.debug('appDoc.date'+app.Appointment_Date__c);
            }
            if(!poldmapappoint.containskey(app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c)){
                poldmapappoint.put(app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c,new List<Appointment__c>{app});
            }else{
                poldmapappoint.get(app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c).add(app);
                //System.debug('app.date'+app.Appointment_Date__c);
            }
        }
        System.debug('oldmapappoint'+oldmapappoint);
        System.debug('poldmapappoint'+poldmapappoint);
        
        for(Appointment__c app : triggerlist){
            string key=app.Doctor__c+'.'+app.Patient__c+'.'+app.Appointment_Date__c;
            String docKey = app.Doctor__c+'.'+app.Appointment_Date__c;
            if(pmapappoint.get(key).size()>1){
                app.addError('You cant book appointment for same paitent more that once');
            }
            else if(poldmapappoint.containskey(key)){
                System.debug('::63 entered');
                app.AddError('Appointment already exist');
            }
            
            System.debug('::67'+poldmapappoint.containskey(key));
            System.debug('::68'+oldmapappoint.containskey(docKey));
            
            if(mapappoint.get(docKey).size()>4){
                app.addError('Doctor Limit Exceeded for that Date');
            }else if(oldmapappoint.containskey(docKey)){
                Integer size = (Integer)(oldmapappoint.get(docKey).size() + mapappoint.get(docKey).size());
                System.debug('size'+size);
                if(size > 4){
                    Integer diff = (Integer)(oldmapappoint.get(docKey).size())-5;
                    System.debug('::71 total appointment of doctor at same date is greater then 5==>'+size+'\n doctor appointment remaining==>'+diff);
                    app.addError('Doctor Limit Exceeded for that Date');
                }
            }
            //System.debug('::77'+oldmapappoint.containskey(key));
        }  
    }
    
}