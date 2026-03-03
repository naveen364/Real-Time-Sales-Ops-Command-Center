import { LightningElement,api, track} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import loadData from '@salesforce/apex/CSVFile.loadData';

export default class FileUpload extends LightningElement {

    @track filterlist = [];
    error;
    isLoaded = false;
    mappingData = [];
    get acceptedFormats() {
        return ['.csv'];
    }

    handlechildfilterlist(event){
        this.filterlist = event.detail;
    }
    uploadFileHandler( event ) {

        console.log('uploadFileHandler==>'+JSON.stringify(this.filterlist,null,"\t"));
        
        this.isLoaded = true;
        const uploadedFiles = event.detail.files;

        loadData( { sObjectName : 'Account', contentDocumentId : uploadedFiles[0].documentId } )
        .then( result => {

            this.isLoaded = false;

            window.console.log('result ===> '+JSON.stringify(result,null,"\t"));
            this.strMessage = result;
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Success',
                    message: result,
                    variant: result.includes("success") ? 'success' : 'error',
                    mode: 'sticky'
                } ),
            );

        })
        .catch( error => {

            this.isLoaded = false;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Error!!',
                    message: JSON.stringify( error ),
                    variant: 'error',
                    mode: 'sticky'
                } ),
            );     

        } )

    }
}