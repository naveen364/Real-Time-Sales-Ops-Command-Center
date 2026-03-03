import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext, APPLICATION_SCOPE } from 'lightning/messageService';
import RECORD_SELECTED_MC from '@salesforce/messageChannel/RecordSelected__c';
import getAccountDetails from '@salesforce/apex/CommandCenterController.getAccountDetails';

export default class AccountDetailSidebar extends LightningElement {
    accountId;
    account;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                RECORD_SELECTED_MC,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    handleMessage(message) {
        // If an Opportunity was selected, it should ideally have the AccountId in the payload
        // because we updated the Kanban to send it.
        if (message.accountId) {
            this.accountId = message.accountId;
            this.fetchAccount();
        }
    }

    async fetchAccount() {
        try {
            this.account = await getAccountDetails({ accountId: this.accountId });
        } catch (error) {
            console.error('Error fetching account:', error);
        }
    }
}
