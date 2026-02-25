public with sharing class CallableDemoController {
    
    @AuraEnabled
    public static Object executeAction(String className, String action, Map<String, Object> args) {
        try {
            
            Type t = Type.forName(className);
            if (t == null) {
                throw new AuraHandledException('Class not found: ' + className);
            }
            
            Object instance = t.newInstance();
            
            if (instance instanceof Callable) {
                Callable callableInstance = (Callable) instance;
                
                return callableInstance.call(action, args);
            } else {
                throw new AuraHandledException('Class ' + className + ' does not implement Callable interface.');
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error executing action: ' + e.getMessage());
        }
    }
}