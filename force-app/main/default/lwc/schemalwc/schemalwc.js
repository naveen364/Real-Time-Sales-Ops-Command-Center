import { LightningElement } from 'lwc';
import objName from '@salesforce/apex/SchemaAllObj.objName';
import objfields from '@salesforce/apex/SchemaAllObj.objfields'
export default class Schemalwc extends LightningElement {
    filterList =[];
    objectList =[];
    fields=[];
    textValue;
    item;
    connectedCallback(){
        objName({}).then((res)=>{
            this.objectList = res;
        });
    }

    handleOption(event){
        this.item = event.target.getAttribute("data-id");
        console.log(this.item);
        try{
        this.template.querySelector('.container').classList.add('hide');
        this.template.querySelector('.searchCombo').value = this.item;
        
        objfields({key:this.item}).then((res)=>{
            this.fields = res;
        });

        console.log(this.fields);
        
        }catch(e){
            console.log('message==>'+e);
        }
    }

    handleInputChange(event) {
        this.textValue = event.detail.value;
        console.log(this.textValue);

        this.filterList = this.objectList.filter(value => value.match(this.textValue));
        console.log("filter=>"+this.filterList);
        const selectedEvent = new CustomEvent("filterlist", {
            detail: this.filterList});
            this.dispatchEvent(selectedEvent);

        if(this.textValue.length<1){
            this.template.querySelector('.container').classList.add('hide');
        }else{
            this.template.querySelector('.container').classList.remove('hide');
        }
    }
}