public class CaseListView_controller {
    @AuraEnabled
    public static CaseWrapper fetchCaseRecords(){
        try {
            integer offset =10;
            CaseWrapper caseWrapper = new CaseWrapper();
            List<Case> caseList =  new List<Case>(); 
            List<ListView> listViewList = new List<ListView>();
            for(Case taskObject : [SELECT Id,CaseNumber ,AccountId, Account.Name, OwnerId,Owner.Name ,Status,CreatedDate  FROM Case  OFFSET :offset ]){
                caseList.add(taskObject);
            }
            List<String> StageValuesList= new List<String>();
            Schema.DescribeFieldResult fieldResult = case.Status.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                StageValuesList.add(pickListVal.getLabel());
            }  

            listViewList = [SELECT Id, Name, SobjectType , DeveloperName FROM ListView WHERE SobjectType =:'Case'];
            caseWrapper.caseList= caseList;
            caseWrapper.StageValuesList= StageValuesList; 
             caseWrapper.listViewList= listViewList;
            return caseWrapper; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 
    
    public Class CaseWrapper{
        @AuraEnabled
        public List<case> caseList {get;set;}
        @AuraEnabled
        public List<String> StageValuesList {get;set;}

        @AuraEnabled
        public List<ListView> listViewList{get;set;}

    }
 @AuraEnabled
    public static List<case> fetchCaseRecordBySort(String fieldName){
        try{
            System.debug('fieldApiName--> '+fieldName);
            String query = 'SELECT Id,CaseNumber ,AccountId, Account.Name, OwnerId,Owner.Name ,Status,CreatedDate  FROM Case ORDER BY '+fieldName+' desc';
           // return [SELECT Id,CaseNumber ,AccountId, Account.Name, OwnerId,Owner.Name ,Status,CreatedDate  FROM Case ORDER BY :fieldApiName ASC];

           List<case> caseList = new List<case>();

           for(case caseObj : Database.Query(query)) {
                    caseList.add(caseObj);
                }
                return caseList;

        }catch(Exception e){
          System.debug('Error ->'+e.getMessage()+' line -> '+e.getLineNumber());
          return null;
        }
    }

    @AuraEnabled
    public static WrapperClassOfFilterData getRecordByFilter(List<String> statusFilterList){
        try {
            integer offset= 10;
            Set<String> statusFieldSet = new Set<String>();
            for(String status : statusFilterList){
                statusFieldSet.add(status);
            }
            System.debug('statusFieldSet --> '+statusFieldSet);
            WrapperClassOfFilterData WrapperClassOfFilterDataobj = new WrapperClassOfFilterData();
            List<case> caseList = new List<case>();
            Set<String> statusList = new Set<String>();
            for(case caseobj : [SELECT Id,CaseNumber ,AccountId, Account.Name, OwnerId,Owner.Name ,Status,CreatedDate  FROM Case WHERE Status IN : statusList OFFSET :offset ]){
                 
                caseList.add(caseobj);
                
                statusList.add(caseobj.Status);
            }
            WrapperClassOfFilterDataobj.caseList=caseList;
            WrapperClassOfFilterDataobj.StatusList=StatusList;
            System.debug('Wrapper --> '+WrapperClassOfFilterDataobj);
            return WrapperClassOfFilterDataobj;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

public class WrapperClassOfFilterData{
    @AuraEnabled
    public List<case> caseList{get;set;}
    @AuraEnabled
    public Set<String> StatusList{get;set;}
}

}