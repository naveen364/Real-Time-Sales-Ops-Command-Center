import { LightningElement } from 'lwc';

export default class Header_lwc extends LightningElement {
    event = {
        Tagline_update__c : 'Tagline_update__c',
        Time_Zone_short_form__c :'Time_Zone_short_form__c'

    }
    dayOfWeek = 2;
    sitestartdate = Date.now();
    startnewtime = Date.now()+12;
    endnewtime = Date.now()+24;
    DocumentImageUrl = 'https://talent--ardev--c.sandbox.vf.force.com/servlet/servlet.ImageServer?oid=00D7j0000004bbzEAA&id=0157j000000BTakAAG';
}