import { LightningElement, api } from 'lwc';

export default class ChildCompLWC extends LightningElement {

     _name;

    @api
    get name() {
        return this._name;
    }

    set name(value) {
        this._name = value;
        alert('changed');

        let custEvnt = new CustomEvent('test', { 
            detail : {
                name : 'hiiiiiii'
            }
        });
        this.dispatchEvent(custEvnt);
    }

    @api
    getSum(a,b) {
        return a+b;
    }

}