import { LightningElement, track } from 'lwc';
import executeAction from '@salesforce/apex/CallableDemoController.executeAction';
export default class DynamicCallableDemo extends LightningElement {
    @track selectedClass = '';
    @track selectedAction = '';
    @track val1 = '';
    @track val2 = '';
    @track result = '';
    @track error = '';
    get classOptions() {
        return [
            { label: 'Math Operations', value: 'MathOperation' },
            { label: 'String Operations', value: 'StringOperation' },
        ];
    }
    get actionOptions() {
        if (this.selectedClass === 'MathOperation') {
            return [
                { label: 'Add', value: 'ADD' },
                { label: 'Subtract', value: 'SUBTRACT' },
                { label: 'Multiply', value: 'MULTIPLY' },
                { label: 'Divide', value: 'DIVIDE' },
            ];
        } else if (this.selectedClass === 'StringOperation') {
            return [
                { label: 'Uppercase', value: 'UPPERCASE' },
                { label: 'Lowercase', value: 'LOWERCASE' },
                { label: 'Reverse', value: 'REVERSE' },
            ];
        }
        return [];
    }
    get isActionDisabled() {
        return !this.selectedClass;
    }
    get isExecuteDisabled() {
        return !this.selectedClass || !this.selectedAction;
    }
    handleClassChange(event) {
        this.selectedClass = event.detail.value;
        this.selectedAction = '';
        this.result = '';
        this.error = '';
    }
    handleActionChange(event) {
        this.selectedAction = event.detail.value;
    }
    handleVal1Change(event) {
        this.val1 = event.detail.value;
    }
    handleVal2Change(event) {
        this.val2 = event.detail.value;
    }
    handleExecute() {
        this.result = 'Processing...';
        this.error = '';
        let args = {
            val1: this.val1,
            val2: this.val2
        };
        
        if (this.selectedClass === 'MathOperation') {
            args.val1 = parseFloat(this.val1);
            args.val2 = parseFloat(this.val2);
        }
        executeAction({ className: this.selectedClass, action: this.selectedAction, args: args })
            .then(result => {
                this.result = result;
            })
            .catch(error => {
                this.error = error.body ? error.body.message : error.message;
                this.result = 'Error';
            });
    }
}