@isTest
private class TestVerifyDate {
    
    @isTest static void valid(){
        Date d = VerifyDate.CheckDates(Date.today(),Date.today()+20);
        System.assertEquals(Date.today()+20, d);
        Date d1 = VerifyDate.CheckDates(Date.today(),Date.today()+32);
        System.assertEquals(Date.today()+2, d1);
    }
    
    @isTest static void validnxt30(){ 
        Boolean b = VerifyDate.DateWithin30Days(Date.today(),Date.today()+20);
        System.assertEquals(true, b);
        Boolean b1 = VerifyDate.DateWithin30Days(Date.today(),Date.today()-1);
        System.assertEquals(false, b1);
        Boolean b2 = VerifyDate.DateWithin30Days(Date.today(),Date.today()+60);
        System.assertEquals(false, b2);
    }
    
    @isTest static void endOfTheMonthDate(){
        Date date1 = VerifyDate.SetEndOfMonthDate(Date.today());
        System.assertEquals(Date.today()+2, date1);
    }
}