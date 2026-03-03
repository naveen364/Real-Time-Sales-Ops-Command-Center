import { LightningElement,track,wire,api } from 'lwc';
import getDetails from "@salesforce/apex/AccountRelateContact.getDetails";
import getAcc from "@salesforce/apex/AccountRelateContact.getAcc";
import getContacts from "@salesforce/apex/AccountRelateContact.getContacts";
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

const FIELDS = ['Contact.Name', 'Contact.Email', 'Contact.Level__c'];
export default class lwc_Relation_Acc_Contact extends LightningElement {
    conlist;
    accList;
    @track accountData;
    @track contactData;
   
    NameOfContact = '';
    EmailOfContact = '';
    level = '';
    value = '';
    contactvalue = '';

    inputName;
    inputEmail;

    @wire(getAcc,{})
    accList({data,error}){
        if(data){
            try{
                this.accList = JSON.parse(JSON.stringify(data));
                let obj = [];
                console.log('accList 32==>'+JSON.stringify(this.accList));
                this.accList.forEach(element =>{
                    console.log(`elementss>> ${element.Name}`);
                    obj.push({
                        'label': element.Name,
                        'value': element.Id
                    });
                    console.log('value'+JSON.stringify(element.Name));
                })
                this.accountData = obj;
                
                console.log('obj==>'+JSON.stringify(obj));
            }catch(e){
                console.log(e)
            }
        }
        
    }

    @wire(getDetails,{Id : '$value'})
    getContacts({data,error}){
        if(data){
            try{
                this.conlist = JSON.parse(JSON.stringify(data));
                let contactobj = [];
                this.conlist.forEach(element =>{
                    contactobj.push({
                        'label': element.LastName,
                        'value': element.Id
                    });
                    this.contactData = contactobj;

                })
            }catch(e){
                console.log('error'+e);
            }
        }else{
            console.log('ERROR :==> '+JSON.stringify(error));
        }
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
    contacthandleChange(event){
        this.contactvalue = event.detail.value;
        //console.log('ContactDetail==>'+this.contactEmail());
    }

    @wire(getRecord,{recordId: '$contactvalue',fields: FIELDS})
    contactDetails({data,error}){
        if(data){
            this.contact = data;
            this.NameOfContact = this.contact.fields.Name.value;
            this.EmailOfContact = this.contact.fields.Email.value;
            this.LevelOfContact = this.contact.fields.Level__c.value;
            console.log(`name : ${JSON.stringify(this.NameOfContact)} email : ${JSON.stringify(this.EmailOfContact)} Level__c : ${JSON.stringify(this.LevelOfContact)}`);
        }else{
            console.log("error==>"+error);
        }
    }

    handleBtnClick() {
      let input = this.template.querySelectorAll('lightning-input[data-name="personal"]');
      let inputObj = {};
        this.inputName = 'testtt';
      input.forEach(input => {
        
        console.log('input::' + input.label);
        inputObj[input.label] = input.value;
      });
      console.log('inputObj::' + JSON.stringify(inputObj));
    }

    getContacts() {
        getContacts({Id: this.value}).then(result =>{
            console.log('cont::' + JSON.stringify(result));
        }).catch(error => {
            console.log(error);
        });
    }

    constructor() {
        super();

        //alert('constructor');
    }

    connectedCallback() {
        this.inputName = 'testttttttttttt';
        //alert('connectedCallBack');
        this.getContacts();
    }

    handleINputChange(event) {
       
    }

    renderedCallback() {
        //alert('renderedCallback');
    }

    handleChildEvnt(event) {
        this.template.querySelector('c-child-comp-l-w-c').getSum(12,13);
        alert('evnnntt::' + event.detail.name);
    }
}