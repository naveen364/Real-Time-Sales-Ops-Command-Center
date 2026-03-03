import { LightningElement,api, wire } from 'lwc';
// import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import { getRecord} from 'lightning/uiRecordApi';
//import { graphQL} from 'https://instance.salesforce.com/services/apexrest/aptk_graphql/graphql';


const FIELDS = ['Actor__c.Name','Actor__c.textrich__c'];
export default class Multi_record_by_lwc extends LightningElement {
    @api recordId;
    opportunity;
    opportunityName;
    opportunityStageName;
    records;
    error;
    abc = 'abc';
    status = false;
    Actor = {};
    name;
    text;

    
    // @wire(getRelatedListRecords, {
    //     parentRecordId: '$recordId',
    //     relatedListId: 'Opportunities',
    //     fields: ['Opportunity.StageName','Opportunity.Name'],
    //     where: "{StageName : {eq: Closed Won }}"
    // })listInfo({ error, data }) {
    //     if (data) {
    //         this.records = data.records;
    //         this.error = undefined;
            
    //     } else if (error) {
    //         this.error = error;
    //         this.records = undefined;
    //     }
    //     console.log("data==>"+JSON.stringify(this.records));
    // }

    connectedCallback() {
        console.log('recordId==>'+this.recordId);
    }

    @wire(getRecord,{recordId: '$recordId',fields: FIELDS})
    ActorDetail({data,error}){
        if(data){
            console.log('data==>'+JSON.stringify(data,null,'\t'));
            this.Actor = data;
            this.name = this.Actor.fields.Name.value;
            this.text = this.Actor.fields.textrich__c.value;
            console.log(`name : ${JSON.stringify(this.name)} text : ${JSON.stringify(this.text)}`);
        }else{
            console.log("wire error==>"+error);
        }
    }


    handleSave() {
        let saveData = this.template.querySelector('lightning-input-rich-text').value;
        console.log("saveData==>"+saveData.removeHtmlTags());

        //do something with saveData
    }
    label_click(event){
        this.status = !this.status;
        console.log("label_click==>"+event.target.value);
    }


    
}