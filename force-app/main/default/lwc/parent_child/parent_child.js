import { LightningElement,track,wire,api } from 'lwc';

export default class Parent_child extends LightningElement {
    LastName = '';
    Email = '';
    Phone = '';
    Contact = [];
    handleINputChange(){
        let obj = {};
        let input = this.template.querySelectorAll('lightning-input');
        input.forEach(element =>{
            obj[element.label] = element.value;
        });
        console.log("obj==>"+JSON.stringify(obj));
        this.Contact = obj;
    }

}