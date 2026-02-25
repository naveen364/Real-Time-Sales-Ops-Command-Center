import { LightningElement, track } from 'lwc';
import { subscribe, onError } from 'lightning/empApi';

export default class CdcFeedPanel extends LightningElement {
    @track events = [];
    channelName = '/data/ChangeEvents';
    subscription = {};

    connectedCallback() {
        this.handleSubscribe();
        this.registerErrorListener();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            console.log('CDC Event Received: ', response);
            const payload = response.data.payload;
            const eventHeader = payload.ChangeEventHeader;

            const newEvent = {
                replayId: response.data.event.replayId,
                entityName: eventHeader.entityName,
                changeType: eventHeader.changeType,
                recordId: eventHeader.recordIds[0],
                changedFields: eventHeader.changedFields ? eventHeader.changedFields.join(', ') : '',
                hasChangedFields: eventHeader.changedFields && eventHeader.changedFields.length > 0,
                time: new Date().toLocaleTimeString()
            };

            // Add to the top of the list
            this.events = [newEvent, ...this.events].slice(0, 50);
        };

        subscribe(this.channelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    }

    registerErrorListener() {
        onError(error => {
            console.log('EMP API error: ', JSON.stringify(error));
        });
    }
}
