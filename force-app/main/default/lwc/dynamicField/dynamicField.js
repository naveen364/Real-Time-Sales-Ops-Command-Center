import { LightningElement, api } from 'lwc';

export default class DynamicField extends LightningElement {
    @api fieldConfig; // The 'item' from JSON
    @api recordData;

    get value() {
        if (this.recordData && this.fieldConfig && this.fieldConfig.bind) {
            return this.recordData[this.fieldConfig.bind];
        }
        return '';
    }

    get isReadonly() {
        return this.fieldConfig.attrs?.readOnly === true;
    }

    get isRequired() {
        return this.fieldConfig.attrs?.required === true;
    }

    handleChange(event) {
        const newVal = event.detail.value;
        this.dispatchEvent(new CustomEvent('change', {
            detail: {
                fieldName: this.fieldConfig.bind,
                value: newVal
            }
        }));
    }
}