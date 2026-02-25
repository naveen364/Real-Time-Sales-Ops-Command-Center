global class SK_EmailAlertJSONParser {
        public string Id;
        public String CcEmails ;
        public String Description ;
        public String DeveloperName ;
        
        public String SenderType ;
        public String EntityDefinitionId ;
        public Metadata Metadata ;
        public String FullName ;
        public string TemplateId;
   
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
        public Object recipient ;
        public String type_Z ;// in json: type
    }
}