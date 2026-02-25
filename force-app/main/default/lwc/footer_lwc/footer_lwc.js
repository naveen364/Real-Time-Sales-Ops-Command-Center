import { LightningElement, track } from 'lwc';
import year from '@salesforce/label/c.AR_Copyright_year';

export default class Footer_lwc extends LightningElement {
    @track AR_CopyRight_year = year;
}