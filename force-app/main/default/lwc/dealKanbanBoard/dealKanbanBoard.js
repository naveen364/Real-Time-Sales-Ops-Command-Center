import { LightningElement, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/CommandCenterController.getOpportunities';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { publish, MessageContext } from 'lightning/messageService';
import RECORD_SELECTED_MC from '@salesforce/messageChannel/RecordSelected__c';
import ID_FIELD from '@salesforce/schema/Opportunity.Id';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';

export default class DealKanbanBoard extends LightningElement {
    opportunities = [];
    error;
    stages = ['Prospecting', 'Qualification', 'Needs Analysis', 'Proposal/Price Quote', 'Negotiation/Review', 'Closed Won'];

    @wire(MessageContext)
    messageContext;

    wiredOppsResult;

    @wire(getOpportunities)
    wiredOpps(result) {
        this.wiredOppsResult = result;
        const { error, data } = result;
        if (data) {
            this.opportunities = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.opportunities = undefined;
        }
    }

    handleDragStart(event) {
        event.dataTransfer.setData('recordId', event.currentTarget.dataset.id);
    }

    handleDragOver(event) {
        event.preventDefault();
    }

    handleDrop(event) {
        const recordId = event.dataTransfer.getData('recordId');
        const newStage = event.currentTarget.dataset.stage;

        const fields = {};
        fields[ID_FIELD.fieldApiName] = recordId;
        fields[STAGE_FIELD.fieldApiName] = newStage;

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Opportunity updated to ' + newStage,
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredOppsResult);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    get kanbanData() {
        if (!this.opportunities) return [];
        return this.stages.map(stage => {
            return {
                label: stage,
                items: this.opportunities
                    .filter(opp => opp.StageName === stage)
                    .map(opp => ({
                        ...opp,
                        AccountName: opp.Account ? opp.Account.Name : 'No Account 🙂‍↔️🙅‍♂️'
                    }))
            };
        });
    }

    handleCardClick(event) {
        const recordId = event.currentTarget.dataset.id;
        const recordName = event.currentTarget.dataset.name;
        const accountId = event.currentTarget.dataset.accid;

        const payload = { 
            recordId: recordId,
            objectApiName: 'Opportunity',
            recordName: recordName,
            accountId: accountId 
        };

        publish(this.messageContext, RECORD_SELECTED_MC, payload);
    }
}
