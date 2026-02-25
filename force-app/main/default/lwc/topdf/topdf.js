import { LightningElement, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import downloadjs from '@salesforce/resourceUrl/downloadjs';
import jspdf from '@salesforce/resourceUrl/jspdf'
import { getRecord } from 'lightning/uiRecordApi';
// import demo from '@salesforce/resourceUrl/demo';
// import jspdf_autotable from '@salesforce/resourceUrl/jspdf_plugin_autotable'
// import downloadPDF from '@salesforce/apex/PdfPage.getPdfFileAsBase64String';
const FIELDS = ['Account.Name', 'Account.NumberOfEmployees','Account.totalContact__c'];

export default class toppdf extends LightningElement {
    boolShowSpinner = false;
    pdfString;
    pdf;
    jsPdfInitialized = false;
    doc;
    
    generatePdf(){
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        console.log("::18");
        let data = [
            {
             Epic : "Support",
             Quantity : "30",
             Unit_Price: "165",
             Amount: "4000"
            },
            {
                Epic : "Development",
                Quantity : "50",
                Unit_Price: "100",
                Amount: "5000"
               },
            ];
            console.log("::33");
        let head = ['Epic', 'Quantity', 'Unit_Price','Amount'];
        console.log("::35");
        doc.table(10, 110, data,head,{});
        console.log("::37");
        doc.text(`Subtotal`, 155, 148).setTextColor(128,128,128).text(`$0.00`, 175, 148).setTextColor(0,0,0);
        doc.text(`Total`, 155, 153).setTextColor(128,128,128).text(`$9000.00`, 175, 153).setTextColor(0,0,0);
        console.log("::40");
        doc.save("a4.pdf");
    }
    renderedCallback() {
        if (this.jsPdfInitialized) {
            return;
        }
        this.jsPdfInitialized = true;

        Promise.all([
            loadScript(this, jspdf)
        ]);
    }        
}