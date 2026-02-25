trigger ReservationTrigger on Reservation__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        //AlertReservation.alert(trigger.new);
        System.debug('Before insert trigger');
    }
}