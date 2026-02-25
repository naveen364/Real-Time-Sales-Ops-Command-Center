import { LightningElement, api, wire } from 'lwc';
import { subscribe, onError } from 'lightning/empApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { publish, MessageContext } from 'lightning/messageService';
import ALERT_MC from '@salesforce/messageChannel/AlertReceived__c';

export default class PlatformEventAlerts extends LightningElement {
    @api channelNameDeal = '/event/DealAlert__e';
    @api channelNameSLA = '/event/SLABreach__e';
    @api channelNameSync = '/event/ExternalSync__e';

    @wire(MessageContext)
    messageContext;

    subscriptionDeal = {};
    subscriptionSLA = {};
    subscriptionSync = {};

    connectedCallback() {
        this.handleSubscribe();
        this.registerErrorListener();
    }

    handleSubscribe() {
        // Subscribe to Deal Alerts
        subscribe(this.channelNameDeal, -1, (response) => {
            console.log('Deal Alert Received: ', response);
            this.showToast(
                response.data.payload.AlertType__c === 'CLOSED_WON' ? 'Success!' : 'Opportunity Alert',
                response.data.payload.Message__c,
                response.data.payload.AlertType__c === 'CLOSED_WON' ? 'success' : 'info'
            );
            this.publishToLMS(response.data.payload);
        }).then(response => { this.subscriptionDeal = response; });

        // Subscribe to SLA Breaches
        subscribe(this.channelNameSLA, -1, (response) => {
            console.log('SLA Breach Received: ', response);
            this.showToast(
                'SLA Breach Warning',
                response.data.payload.Message__c,
                'warning'
            );
            this.publishToLMS(response.data.payload);
        }).then(response => { this.subscriptionSLA = response; });

        // Subscribe to External Syncs
        subscribe(this.channelNameSync, -1, (response) => {
            console.log('External Sync Received: ', response);
            this.showToast(
                'System Sync',
                response.data.payload.Message__c,
                'info'
            );
            this.publishToLMS(response.data.payload);
        }).then(response => { this.subscriptionSync = response; });
    }

    registerErrorListener() {
        onError(error => {
            console.log('EMP API error reported by server: ', JSON.stringify(error));
        });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'sticky'
        });
        this.dispatchEvent(event);
    }

    publishToLMS(payload) {
        // Bridge Platform Events to LMS so other UI components can react without each subscribing to EMP API
        const message = {
            source: 'PlatformEventAlerts',
            payload: payload
        };
        publish(this.messageContext, ALERT_MC, message);
    }
}
