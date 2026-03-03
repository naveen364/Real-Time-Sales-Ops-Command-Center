/*
Create three custom objects:
       1. Train.(Fileds{Name})
       2. Passenger.(Fields{Name,Phone})
       3. Reservation.(Fields{TrainId,PassengerId,ReservationDate,DestinationFrom,DestinationTo}) .

    WAT to restrict a passenger to apply for reservation for same day and for same train
*/
public class AlertReservation {
    public static void alert(List<Reservation__c> triggerlist){
        List<Reservation__c> revlist = new List<Reservation__c>();
        Map<Id,List<Reservation__c>> maprev = new Map<Id,List<Reservation__c>>();
        List<Passenger__c> pass = new List<Passenger__c>();
        pass = [select Id from Passenger__c];
        revlist = [select Id,PassengerId__c,ReservationDate__c,TrainId__c from Reservation__c where PassengerId__c In (select Id from Passenger__c)];
		
        for(Reservation__c rev : revlist){
            if(!maprev.containskey(rev.PassengerId__c)){
                maprev.put(rev.PassengerId__c,new List<Reservation__c>{rev});
            }else{
                maprev.get(rev.PassengerId__c).add(rev);
            }
        }
        
        for(Passenger__c pid : pass){
            if(maprev.get(pid.Id) != null){
                try{
                    for(Reservation__c rev :maprev.get(pid.Id)){
                        for(Integer i = 0; i<triggerlist.size();i++){
                            if(rev.PassengerId__c == triggerlist[i].PassengerId__c && rev.TrainId__c == triggerlist[i].TrainId__c && rev.ReservationDate__c == triggerlist[i].ReservationDate__c){
                                triggerlist[i].ReservationDate__c.addError('same day');
                                triggerlist[i].TrainId__c.addError('same Train');
                            }
                        }
                    }
                }catch(ListException e){
                    
                }
            }
        }
    }
}