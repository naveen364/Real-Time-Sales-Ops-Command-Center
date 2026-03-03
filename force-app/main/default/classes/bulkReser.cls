public class bulkReser {
    public static void bulky(){
        List<Reservation__c> revlist = new List<Reservation__c>();
        
        	Reservation__c rev = new Reservation__c();
            rev.PassengerId__c ='a0C5j0000019xonEAA';
            rev.TrainId__c = 'a0B5j000000TBefEAG';
            rev.Name = 'xyz100';
            rev.ReservationDate__c = Date.today();
        	revlist.add(rev);
        	
        	Reservation__c rev1 = new Reservation__c();
            rev1.PassengerId__c ='a0C5j0000019xoiEAA';
            rev1.TrainId__c = 'a0B5j000000TBefEAG';
            rev1.Name = 'xyz1001';
            rev1.ReservationDate__c = Date.today();
            revlist.add(rev1);
        
        	Reservation__c rev2 = new Reservation__c();
            rev2.PassengerId__c ='a0C5j0000019xonEAA';
            rev2.TrainId__c = 'a0B5j000000TBefEAG';
            rev2.Name = 'xyz1002';
            rev2.ReservationDate__c = Date.today();
        	revlist.add(rev2);
        
        insert revlist;
    }
}