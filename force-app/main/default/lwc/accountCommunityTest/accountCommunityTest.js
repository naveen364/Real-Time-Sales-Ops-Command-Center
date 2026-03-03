import { LightningElement, track } from 'lwc';
import getAcc from '@salesforce/apex/AccountTokenize.getAccount';
import saveCon from '@salesforce/apex/AccountTokenize.saveContact';
export default class AccountCommunityTest extends LightningElement {
    @track AccCard = true;
    @track conCard = false;
    @track AccountObj = {};
    @track ContactObj = [];
    @track ConObj = {};
    firstName = '';
    LastName = '';
    accNum = '';

    firstNameChange(e){
        console.log('e.target.value of fname event'+e.target.value);
        this.firstName = e.target.value;
    }

    lastNameChange(e){
        console.log('e.target.value of lname event'+e.target.value);
        this.LastName = e.target.value;
    }

    AccNumChange(e){
        console.log('e.target.value of AccountNum event'+e.target.value);
        this.accNum = e.target.value;
    }

    get FName(){
        console.log('FName');
        return this.firstName;
    }

    get LName(){
        console.log('LName');
       return this.LastName; 
    }

    get ANum(){
        console.log('ANum=>'+this.accNum);
        return this.accNum; 
    }

    connectedCallback() {
        //code
        console.log('code runs');
    }

    nxtPageHandler(e) {
        console.log('nxtPageHandler');
        if (this.ANum != null && this.ANum != '') {
            getAcc({accNum : this.ANum}).then((res) => {
                this.AccountObj = res;
                this.AccCard = false;
                this.conCard = true;
                this.CreateContact();
                console.log(JSON.stringify(res, null, '\t'));
            }).catch((error)=>{
                console.log(JSON.stringify(error, null, '\t'));
            });
        }
    }

    saveContact(e){
        console.log('saveContact');
            saveCon({accID : this.AccountObj.id, fname : this.FName, lname: this.LName}).then(() => {
                alert('Contact Saved');
            }).catch((error)=>{
                console.log(JSON.stringify(error, null, '\t'));
            });
        
    }

    CreateContact(){
        this.ConObj.push({
            FirstName : this.FName,
            LastName : this.LName,
            AccountId : this.AccountObj.Id
        });
       
    }

}