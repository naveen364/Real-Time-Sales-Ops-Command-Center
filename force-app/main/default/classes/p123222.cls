public class p123222 {
    public static void x(){
        //a = insertionOrderRecord.Document_for_credit_check_attached__c
        //attached = Bing_CONSTANT.HELPTEXT_CREDIT_CHECK_ATTACHED
        //approved = Bing_CONSTANT.APPROVED
        //aprovedbyarun = insertionOrderRecord.Approved_By_Arun__c
        //submitto = Bing_CONSTANT.HELPTEXT_SUBMITIO
        //b = insertionOrderRecord.Credit_Limit_Status__c
        //rej = Bing_CONSTANT.HELPTEXT_RAISEJIRATICKET
        Boolean a = false;
        String attached = 'attached';
        String placement = 'placement';
        String approved  = 'approved';
        String aprovedbyarun = 'approved';
        String submitto = 'submit';
        String b = 'Approved';
        String rej = 'reject';
        Integer placementRecords_size = 10;
        String creditCheck = '';
        if(a != true) { //(!a){}
            creditCheck += attached;
        }
        if(placementRecords_size <= 0) {
            creditCheck +='\n'+ placement;
        }
        if(b == approved && aprovedbyarun == approved){
            creditCheck +='\n'+ approved;
        }else {
            creditCheck +='\n'+ submitto;
        }
        //creditCheck += (b == approved && aprovedbyarun == approved)? '\n'+approved : '\n'+submitto;
        if(!(b == approved && aprovedbyarun == approved) || 
           placementRecords_size <= 0){
               creditCheck +='\n'+ rej;
           }
    }
}