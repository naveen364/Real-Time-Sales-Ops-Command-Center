import { LightningElement, wire, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import fetchCaseRecords from '@salesforce/apex/CaseListView_controller.fetchCaseRecords';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
import fetchCaseRecordBySort from '@salesforce/apex/CaseListView_controller.fetchCaseRecordBySort';
import getRecordByFilter from '@salesforce/apex/CaseListView_controller.getRecordByFilter';
import { getListUi,MRU } from 'lightning/uiListApi';
import {deleteRecord} from 'lightning/uiRecordApi';
import Case_OBJECT from '@salesforce/schema/Case';

export default class listviewlwc extends NavigationMixin(LightningElement) {
   // @api boolnewbtn = false;
    @track currentRecordId;
    @track isModalopen = false;
    @track filterCaseData = 'AllOpenCases';
    @track listOfCase = [];
    @track listOfStatus;
    @track allSelect = false;
    @track selectAllRecord = [];
    @track StageNameOpoup = false;
    @track statusFilterList = [];
    @track switcher = true;
    @track status_icon = 'utility:arrowup';
    @track listViewList =[];
    @track CaseListViewName ='All Cases';
    @track colomName = [
        { key: 'CaseNumber', value: 'Case Number', checkIcon: false },
        { key: 'Account.Name', value: 'Account Name', checkIcon: false },
        { key: 'Financial_Firm__c', value: 'Financial Firm', checkIcon: false },
        { key: 'Respondent_Name__c', value: 'Respondent Name', checkIcon: false },
        { key: 'Status', value: 'Status', checkIcon: true },
        { key: 'Due_Date__c', value: 'Due Date', checkIcon: false },
        { key: 'IDR_Date__c', value: 'IDR Date', checkIcon: false },
        { key: 'Final_Response_Due__c', value: 'Final Response Due', checkIcon: false },
        { key: 'Premium_Charges__c', value: 'Premium Charges', checkIcon: false },
        { key: 'CreatedDate', value: 'Date/Time Opened', checkIcon: false },
        { key: 'Owner.Name', value: 'Owner Name', checkIcon: false },

    ]

    //wire call ListViewName
    @wire(getListUi, {
        objectApiName: Case_OBJECT,
        listViewApiName: `AllOpenCases`
    })listView({ error, data }) {
        if (data) {
            console.log("data=>"+JSON.stringify(data));
        } else if (error) {
            console.log("error=>"+JSON.stringify(error));
        }
    }

    connectedCallback() {
        try {
            // console.log('inside in conncted call back');
            fetchCaseRecords().then(res => {
                //  console.log(' --> '+JSON.stringify(res.caseList));
                this.listOfCase = res.caseList
                this.listOfStatus = res.StageValuesList;
                this.listViewList = res.listViewList;
                this.setValuesunchecked();

            }).catch(error => {
                this.error = error;
            });
        } catch (err) {
            console.log(' connectedCallback error--> ' + err);
        }
    }

    setValuesunchecked() {
        try {
            this.listOfCase.forEach(data => {
                data.checkbox = false;
            });
        } catch (error) {
            console.log('error -> ' + error);
        }
    }

    setValueschecked() {
        try {
            this.listOfCase.forEach(data => {
                data.checkbox = true;
            });
        } catch (error) {
            console.log('error -> ' + error);
        }
    }

    SelectAllRecords(event) {
        try {
            let checkboxes = this.template.querySelector('[data-id="checkbox"]');
            console.log('check box -> ' + checkboxes.checked);
            if (checkboxes.checked == true) {
                this.listOfCase.forEach(data => {
                    this.selectAllRecord.push(data.id);
                    this.setValueschecked();
                });
            } else {
                this.selectAllRecord = [];
                this.setValuesunchecked();
            }
            console.log('inside in all select' + this.selectAllRecord);

        } catch (error) {
            console.log('error -> ' + error);
        }
    }

    SelectRecord(event) {
        try {
            let recordId = event.currentTarget.value;
            console.log('recordId ' + recordId);
            let index = event.currentTarget.dataset.indexcol;
            console.log('index ' + index);
            let checkboxes = this.template.querySelectorAll('[data-id="checkbox1"]');

            if (checkboxes[index].checked == true) {
                this.selectAllRecord.push(recordId);
                this.listOfCase.forEach(data => {
                    if (recordId == data.Id)
                        data.checkbox = true;
                });
            } else {
                this.selectAllRecord = arrayRemove(this.selectAllRecord, recordId);
                this.listOfCase.forEach(data => {
                    if (recordId == data.Id)
                        data.checkbox = false;
                });
            }
            function arrayRemove(arr, value) {
                return arr.filter(function (ele) {
                    return ele != value;
                });
            }
            this.selectAllRecord.forEach(data => {
                console.log('error -> ' + data);
            }) 

        } catch (error) {
            console.log('error -> ' + error);
        }
    }

    soringdata(event) {
        try {
            let apiName = event.currentTarget.dataset.id;
            console.log('type-> ' + apiName);
            console.log('Id ->  ' + apiName + ' data -> ' + this.listOfCase);
            console.log('data -> ' + JSON.stringify(this.listOfCase));
            if(!this.switcher){
                this.listOfCase.sort((a, b) => a[apiName] > b[apiName] ? 1 : -1);  // Sorteing data according service territory
                this.status_icon = 'utility:arrowup';
                this.switcher = true;
            }else{
                 this.listOfCase.sort((a, b) => a[apiName] > b[apiName] ? -1 : 1);  // Sorteing data according service territory 
                 this.status_icon = 'utility:arrowdown';
                 this.switcher = false;
            }

        } catch (error) {
            console.log('soringdata error -> ' + error);
        }
    }
    openFilterModal(event) {
        try {
            this.StageNameOpoup = true;
        } catch (eror) {
            console.log(' openFilterModal error -> ' + eror);
        }
    }

    sortByStatus(event) {
        try {

        } catch (error) {
            console.log('error -> ' + error);
        }
    }

    filterByStatusField(event) {
        try {
            let status = event.currentTarget.value;
            let index = event.currentTarget.dataset.index;
            console.log('status - > ' + status + ' => ' + index);

            let checkboxes = this.template.querySelectorAll('[data-id="checkboxstatus"]');
            console.log('check box -> ' + checkboxes[index].checked);
            if (checkboxes[index].checked == true) {
                this.statusFilterList.push(status);
            } else {
                this.statusFilterList = arrayRemove(this.statusFilterList, status);
            }

            function arrayRemove(arr, value) {
                return arr.filter(function (ele) {
                    return ele != value;
                });
            }

        } catch (error) {
            console.log('filterByStatusField error -> ' + error);
        }
    }

    CancelStatusModal() {
        try {
            console.log('inside in closed');
            this.StageNameOpoup = false;
            this.statusFilterList = [];
            console.log('inside in closed');

        } catch (error) {
            console.log('filterByStatusField error -> ' + error);
        }
    }

    appylyFilter(event) {
        try {
            this.listOfCase = [];
            console.log('inside in filter methods ');
            getRecordByFilter({ statusFilterList: this.statusFilterList }).then(res => {
                console.log('insode response', res.caseList);
                this.CancelStatusModal();
                this.listOfCase = res.caseList;
                this.listOfCase.forEach(data => {
                    data.checkbox = false;
                })

                //console.log('List --> '+JSON.stringify(res.caseList));


            }).catch(error => {
                console.log('11verror => ' + error);
            })

        } catch (error) {
            console.log('filterByStatusField 140  error -> ' + error);
        }
    }

    get disableButton() {
        if (this.statusFilterList.length > 0) {
            return true;
        } else {
            return false;
        }
    }

    @api CreateNewCase(){
       // this.boolnewbtn = true;
        console.log("::231");
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Case',
                actionName: 'new',
            },
        });
        console.log("::239");
       // this.boolnewbtn = false;
    }
    
    clickOnEdit(event){
        var value = event.target.value;
        console.log("Id==>"+value);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: value,
                actionName: 'edit'
            }
        });
    }

    showModalBox() {  
        this.isModalopen = true;
    }

    hideModalBox() {  
        this.isModalopen = false;
    }

    ConfirmDelete(){
        console.log("Id==>"+this.currentRecordId);
        deleteRecord(this.currentRecordId) 
        .then(() =>{
    
        const toastEvent = new ShowToastEvent({
            title:'Record Deleted',
            message:'Record deleted successfully',
            variant:'success',
        })
        this.dispatchEvent(toastEvent);
        refreshApex(this.result);
        
        })
        .catch(error =>{
            console.log('Unable to delete record due to ' + error.body.message);
        });
        this.hideModalBox();
    }

    CancelDelete(){
        this.hideModalBox();
    }
    //without modal delete
    clickOnDelete(event){
        this.currentRecordId = event.target.value;
        this.showModalBox();
    }

     handleOnselectListView(event){
       try {
        console.log('we are in handleOnselect11' );
        var detailValues = event.detail.value;
        var index = event.detail.label
        var value =  event.currentTarget.dataset.label;
          console.log('DeveloperName--> '+detailValues+' value -> '+value+' ind => '+index);
            //this.filterCaseData = detailValues;

        for(var i=0;i<this.listViewList.length;i++){
            console.log()
            if(this.myMenuItems[i].DeveloperName === detailValues ){
                // console.log('developerName--> '+detailValues);
                // console.log('myMenuItems[i] --> '+this.myMenuItems[i].Name);
                this.OpportunityListView = this.myMenuItems[i].Name
                this.findListApiName = event.detail.value;
            }
        } 
       } catch (error) { 
           console.log(`error- ${error}`); 
       }
    }
}