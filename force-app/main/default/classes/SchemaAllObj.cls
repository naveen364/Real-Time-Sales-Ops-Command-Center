public with sharing class SchemaAllObj {
    @AuraEnabled
    public static List<string> objfields(String key){
        List<String> rtn = new List<String>();
        Map<String , Schema.SObjectType > globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType objType = globalDescription.get(key);

        System.debug('sObject Type==>'+objType);
        Schema.DescribeSObjectResult r1 = objType.getDescribe();   
        Map<String , Schema.SObjectField > mapFieldList = r1.fields.getMap();

        for ( Schema.SObjectField field : mapFieldList.values() ) {    
            Schema.DescribeFieldResult fieldResult = field.getDescribe();
            if ( fieldResult.isAccessible() ) {    
                System.debug('Field Name is ' + objType + '.' + fieldResult.getName() );
                rtn.add(fieldResult.getName());
            }  
            System.debug('field Name ==>'+rtn);     
        }
        return rtn;
    }
    @AuraEnabled
    public static List<String> objName(){
        List<String> rtn = new List<String>();
        Integer i = 0;     
        Map<String , Schema.SObjectType > globalDescription = Schema.getGlobalDescribe();
        //logic for diff class
        for(String str : globalDescription.keyset()){
            if(str.endsWith('__c')){
                rtn.add(str);
            }
        }
        //rtn.addall(globalDescription.keyset());
        System.debug('list of name'+rtn);
        return rtn;
    }
    @AuraEnabled
    public static string getfieldType(String key, String field){
        try {
            String fieldType;
            Map<String , Schema.SObjectType > globalDescription = Schema.getGlobalDescribe();
            Schema.sObjectType objType = globalDescription.get(key);
            System.debug('sObject Type==>'+objType);
            Schema.DescribeSObjectResult r1 = objType.getDescribe();   
            Map<String , Schema.SObjectField > mapFieldList = r1.fields.getMap();
            Schema.SObjectField fld = mapFieldList.get(field);
            Schema.DisplayType FldType = fld.getDescribe().getType();
            fieldType = string.valueof(FldType);
            System.debug('fieldType==>'+fieldType);
            return fieldType;
        } catch (Exception e) {
            return null;
        }
    }
}