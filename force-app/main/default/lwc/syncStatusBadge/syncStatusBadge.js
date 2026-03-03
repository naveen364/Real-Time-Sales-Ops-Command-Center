import { LightningElement, track } from 'lwc';
import { subscribe, onError } from 'lightning/empApi';

export default class SyncStatusBadge extends LightningElement {
    @track statusMessage = 'System Online';
    channelName = '/event/ExternalSync__e';
    subscription = {};

    connectedCallback() {
        this.handleSubscribe();
    }

    handleSubscribe() {
        subscribe(this.channelName, -1, (response) => {
            const payload = response.data.payload;
            this.statusMessage = `Synced ${payload.ObjectType__c}`;
            
            // Reset message after 5 seconds
            setTimeout(() => {
                this.statusMessage = 'System Online';
            }, 5000);
        }).then(response => {
            this.subscription = response;
        });
    }
}
