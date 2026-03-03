public with sharing class StringOperation implements Callable {
    
    public Object call(String action, Map<String, Object> args) {
        
        String inputStr = (String) args.get('val1'); // Reuse 'val1' as main input
        if (inputStr == null) {
            return 'Please provide a string value.';
        }
        switch on action {
            when 'UPPERCASE' {
                return inputStr.toUpperCase();
            }
            when 'LOWERCASE' {
                return inputStr.toLowerCase();
            }
            when 'REVERSE' {
                return inputStr.reverse();
            }
            when else {
                return 'Action not supported by StringOperation: ' + action;
            }
        }
    }
}