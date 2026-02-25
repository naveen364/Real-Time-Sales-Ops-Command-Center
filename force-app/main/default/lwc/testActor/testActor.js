import { LightningElement,track } from 'lwc';
import getAct from '@salesforce/apex/ActorTest.actcall';
export default class TestActor extends LightningElement {
    @track actobj = '';

    connectedCallback() {
        //code
        getAct().then((res)=>{
            this.actobj = res;
            console.log(JSON.stringify(res,null,'\t'));
        })
    }
}