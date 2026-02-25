public class workOrderClass {
    public static void workOrder(){
        List<WorkOrder__c> worklist,updatework = new List<WorkOrder__c>();
        worklist = [select Id,Start_Date__c,CreatedDate,Name from WorkOrder__c where status__c = 'Pending'];
        for(WorkOrder__c w : worklist){
            if(w.CreatedDate -30 < w.Start_Date__c){
                updatework.add(w);
                System.debug('work'+w.Name);
            } 
        }
        System.debug(updatework);
        //delete updatework;
    }
}