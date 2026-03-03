import { LightningElement, api, wire, track } from 'lwc';
import getConfiguration from '@salesforce/apex/FrameworkConfigController.getConfiguration';

export default class DynamicRoot extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api flexipageRegionWidth;
    @api mode = 'View'; // Default, but can be set by parent or app builder

    @track layoutConfig;
    @track error;
    @track isLoading = true;

    // State Store for the Dynamic Form
    @track componentState = {};

    connectedCallback() {
        this.loadConfig();
    }

    loadConfig() {
        this.isLoading = true;
        getConfiguration({
            contextObjectName: this.objectApiName,
            mode: this.mode,
            recordId: this.recordId
        })
            .then(result => {
                if (result) {
                    this.layoutConfig = JSON.parse(result);
                    this.error = undefined;
                } else {
                    this.error = 'No Configuration Found for this context.';
                }
                this.isLoading = false;
            })
            .catch(error => {
                this.error = error;
                this.isLoading = false;
            });
    }

    handleFieldChange(event) {
        // Centralized State Update
        const { fieldName, value } = event.detail;
        this.componentState = { ...this.componentState, [fieldName]: value };
        console.log('State Updated:', JSON.stringify(this.componentState));
    }

    handleAction(event) {
        // Handle Button Clicks from Children
        const actionConf = event.detail;
        console.log('Action Triggered:', actionConf);
        // Dispatch to Provider (Pending Implementation)
    }
}