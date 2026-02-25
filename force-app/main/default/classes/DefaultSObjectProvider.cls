public with sharing class DefaultSObjectProvider implements FrameworkDataProvider {
    
    public Map<String, Object> getData(Map<String, Object> params) {
        String recordId = (String)params.get('recordId');
        String objectName = (String)params.get('objectApiName');
        List<String> fields = (List<String>)params.get('fields'); // UI passes fields it needs

        if(String.isBlank(recordId) || String.isBlank(objectName)) {
            return new Map<String, Object>();
        }

        // Dynamic SOQL
        String query = 'SELECT ' + (fields != null && !fields.isEmpty() ? String.join(fields, ',') : 'Id, Name') + 
                       ' FROM ' + String.escapeSingleQuotes(objectName) + 
                       ' WHERE Id = :recordId';
        
        SObject record = Database.query(query);
        return (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(record));
    }

    public Map<String, Object> executeAction(String actionName, Map<String, Object> data) {
        Map<String, Object> result = new Map<String, Object>();
        
        if (actionName == 'save') {
             // Basic Update Logic
             try {
                String objectName = (String)data.get('objectApiName');
                String recordId = (String)data.get('Id');
                
                SObject obj = Schema.getGlobalDescribe().get(objectName).newSObject();
                obj.put('Id', recordId);
                
                for(String key : data.keySet()) {
                    if(key != 'attributes' && key != 'Id' && key != 'objectApiName') {
                         // Very simplified type conversion would go here
                         obj.put(key, data.get(key));
                    }
                }
                
                update obj;
                result.put('success', true);
                result.put('message', 'Record Updated Successfully');

             } catch(Exception e) {
                result.put('success', false);
                result.put('message', e.getMessage());
             }
        } else {
             result.put('success', false);
             result.put('message', 'Action not supported: ' + actionName);
        }
        
        return result;
    }
}