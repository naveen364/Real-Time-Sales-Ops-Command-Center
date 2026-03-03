import { LightningElement, track } from 'lwc';
import getResponse from '@salesforce/apex/ChatGPT.getResponse';

export default class FanterrBOT extends LightningElement { 
  @track response;
  @track data;
  @track load;
  @track error;

    // apiKey = 'Bearer sk-PLACEHOLDER';
    endpoint = 'https://api.openai.com/v1/images/generations';

    @track prompt = null;

    handlePromptChange(e){
      this.prompt = e.detail.value;
      console.log(this.prompt)
      this.load = null;
    }

    handleclose(){
      this.error = null;
      this.load = null;
    }

    fetchdata(){
      this.load = 1;
      this.data = null;
      getResponse({ endpoint: this.endpoint, prompt: this.prompt })
            .then(result => {
                this.response = result;
                console.log("JSON Response"+JSON.stringify(this.response,null,'\t'));
                if(this.response.data)
                this.data = this.response.data;
                if(this.response.error)
                this.error = this.response.error;
                console.log(JSON.stringify(this.error,null,'\t'));
                this.load = null;
            })
            .catch(error => {
              this.error.message = "Try again!";
              this.load = null;
              console.error(error);
            });
    }
  }