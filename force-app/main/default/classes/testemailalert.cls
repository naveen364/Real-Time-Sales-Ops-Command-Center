public class testemailalert {
    public static void test(){
        SK_EmailAlertJSONParser  emailAlertDetails = new SK_EmailAlertJSONParser();
        string sessionId= UserInfo.getSessionID();
        string domainUrl=URL.getSalesforceBaseUrl().toExternalForm();
        system.debug('********domainUrl:'+domainUrl);
        string objectId ='Account'; //for custom objects, provide 15 digit or 18 digit object id
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + sessionId);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(domainUrl+'/services/data/v47.0/tooling/query/?q=select+id,SenderType,templateId+from+WorkflowAlert+where+EntityDefinitionId=\''+objectId+'\'');
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        system.debug(res.getBody());
        
        List<string> workflowEmailAlertIds= new List<string>();
        String response=res.getBody();
        JSONParser  parser = JSON.createParser(response);
        System.debug('parse'+parser);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                String fieldValue=parser.getText();
                if(fieldName == 'Id') {
                    workflowEmailAlertIds.add(fieldValue);
                }
            }
        }
        system.debug('***workflowEmailAlertIds size:'+workflowEmailAlertIds.size());
        system.debug('***workflowEmailAlertIds size:'+workflowEmailAlertIds);
        //as there is limit of 100 callouts in single transaction, I am restricting it to 90. Assuming there will not be more than 
        //10 email alert on single object
        String string_obj;
        if(workflowEmailAlertIds.size()<10){
            for(string ss:workflowEmailAlertIds){
                system.debug('***workflowEmailAlertId :'+ss);
                HttpRequest req1 = new HttpRequest();
                req1.setHeader('Authorization', 'Bearer ' +sessionId );
                req1.setHeader('Content-Type', 'application/json');
                req1.setEndPoint(domainUrl+'/services/data/v41.0/tooling/sobjects/WorkflowAlert/'+ss); 
                req1.setMethod('GET');
                Http h1 = new Http();
                HttpResponse res1 = h1.send(req1);
                system.debug(res1.getBody());
               	string_obj = (String)res1.getBody();
            }
            emailAlertDetails =(SK_EmailAlertJSONParser) System.JSON.deserialize(string_obj, SK_EmailAlertJSONParser.class);
            System.debug('emailAlertDetails=>'+emailAlertDetails.Metadata.recipients);
        }
    }
    class SK_EmailAlertJSONParser {
        public string Id;
        //public String CcEmails ;
        public String Description ;
        public String DeveloperName ;
        
        public String SenderType ;
        public String EntityDefinitionId ;
        public Metadata Metadata ;
        public String FullName ;
        public string TemplateId;
    }
    class Metadata {
        public List<String> ccEmails ;
        public String description ;
        public Boolean protected_Z ;// in json: protected
        public List<Recipients> recipients ;
        public String senderAddress ;
        public String senderType ;
        public String template ;
        public Object urls ;
    }
    class Recipients {
        public String field ;
        public String recipient ;
        public String type_Z ;// in json: type
    }
}