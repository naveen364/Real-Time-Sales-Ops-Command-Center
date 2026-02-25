import { LightningElement,api,wire } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";

import { getRecord } from "lightning/uiRecordApi";
import ACCOUNT_ID_FIELD from "@salesforce/schema/Contact.AccountId";

const fields = [ACCOUNT_ID_FIELD];

export default class Testemailcomposer extends NavigationMixin(LightningElement) {
@api recordId;
contact;
accountId;

  @wire(getRecord, { recordId: "$recordId", fields })
  wiredContact({ error, data }) {
    if (error) {
      // handle error
    } else if (data) {
      this.contact = data;
      this.accountId = this.contact.fields.AccountId.value;
      this.handleEmail();
    }
  }

  handleEmail() {
    var pageRef = {
      type: "standard__quickAction",
      attributes: {
        apiName: "Global.SendEmail",
      },
      state: {
        recordId: this.recordId,
        defaultFieldValues: encodeDefaultFieldValues({
          Subject: 'Pre-populated Subject of the Email',
          ToAddress: 'test@example.com',
          RelatedToId: this.accountId
        }),
      },
    };
    this[NavigationMixin.Navigate](pageRef);
    console.log('pageRef'+JSON.stringify(pageRef,null,'\t'));
  }
}