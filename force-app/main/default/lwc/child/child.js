import { LightningElement,api} from 'lwc';
import getContacts from "@salesforce/apex/createCon.createcontact";
export default class Child extends LightningElement {
    @api name;
    getContacts(){
        getContacts({con: this.name}).then(() =>{
            console.log('SUCESS::');
        }).catch(error => {
            console.log(error);
        });
    }

    handleBtnClick(){
        console.log("name==>"+JSON.stringify(this.name));
        this.getContacts();
    }
}