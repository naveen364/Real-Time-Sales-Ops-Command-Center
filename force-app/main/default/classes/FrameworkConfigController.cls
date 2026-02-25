public with sharing class FrameworkConfigController {
    
    @AuraEnabled(cacheable=true)
    public static String getConfiguration(String contextObjectName, String mode, String recordId) {
        // 1. Find the Configure_Object__c for this context
        List<Configure_Object__c> configs = [
            SELECT Id 
            FROM Configure_Object__c 
            WHERE Object_API_Name__c = :contextObjectName 
            LIMIT 1
        ];
        
        if (configs.isEmpty()) {
            throw new AuraHandledException('No Configuration found for Object: ' + contextObjectName);
        }
        Id configId = configs[0].Id;

        // 2. Resolve Layout Key based on Criteria (simplified for MVP: Match Mode only or First Match)
        // In a real scenario, we would fetch ALL keys and evaluate Criteria_JSON__c against the Record Data.
        List<Layout_Key__c> keys = [
            SELECT Layout_Definition__c 
            FROM Layout_Key__c 
            WHERE Configure_Object__c = :configId 
            AND Mode__c = :mode
            LIMIT 1
        ];

        if (keys.isEmpty()) {
             // Fallback or Error
             return null;
        }

        Id layoutId = keys[0].Layout_Definition__c;

        // 3. Fetch Layout Definition & Items
        Layout_Definition__c def = [SELECT Name, Type__c FROM Layout_Definition__c WHERE Id = :layoutId];
        
        List<Layout_Item__c> items = [
            SELECT Id, Type__c, Label__c, Bind_To__c, Attributes_JSON__c, Parent_Item__c, Parent_Item__r.Id 
            FROM Layout_Item__c 
            WHERE Layout_Definition__c = :layoutId 
            ORDER BY Order__c ASC
        ];

        // 4. Construct JSON Tree
        Map<String, Object> result = new Map<String, Object>();
        result.put('layoutName', def.Name);
        result.put('layoutType', def.Type__c);
        result.put('structure', buildTree(items));

        return JSON.serialize(result);
    }

    private static List<Object> buildTree(List<Layout_Item__c> items) {
        // Simple linear -> tree converter
        // Checks for Parent_Identifier__c logic or standard Parent_Item__c lookup
        // For efficiency in this demo, returning list. LWC can handle hierarchy if needed.
        // Or we implement a proper recursive map builder here.
        Map<Id, Map<String, Object>> idToNode = new Map<Id, Map<String, Object>>();
        List<Map<String, Object>> roots = new List<Map<String, Object>>();

        for(Layout_Item__c item : items) {
            Map<String, Object> node = new Map<String, Object>{
                'id' => item.Id,
                'type' => item.Type__c,
                'label' => item.Label__c,
                'bind' => item.Bind_To__c,
                'attrs' => item.Attributes_JSON__c != null ? JSON.deserializeUntyped(item.Attributes_JSON__c) : null,
                'children' => new List<Map<String, Object>>()
            };
            idToNode.put(item.Id, node);
        }

        for(Layout_Item__c item : items) {
            Map<String, Object> node = idToNode.get(item.Id);
            if(item.Parent_Item__c != null && idToNode.containsKey(item.Parent_Item__c)) {
                Map<String, Object> parent = idToNode.get(item.Parent_Item__c);
                ((List<Map<String, Object>>)parent.get('children')).add(node);
            } else {
                roots.add(node);
            }
        }
        return roots;
    }
}