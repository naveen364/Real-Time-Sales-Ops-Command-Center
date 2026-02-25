public with sharing class MathOperation implements Callable {
    
    public Object call(String action, Map<String, Object> args) {
        
        Decimal val1 = (Decimal) args.get('val1');
        Decimal val2 = (Decimal) args.get('val2');
        if (val1 == null || val2 == null) {
            return 'Please provide both values.';
        }
        switch on action {
            when 'ADD' {
                return val1 + val2;
            }
            when 'SUBTRACT' {
                return val1 - val2;
            }
            when 'MULTIPLY' {
                return val1 * val2;
            }
             when 'DIVIDE' {
                if (val2 == 0) return 'Cannot divide by zero';
                return val1 / val2;
            }
            when else {
                return 'Action not supported by MathOperation: ' + action;
            }
        }
    }
}