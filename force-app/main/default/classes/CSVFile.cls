public without sharing class CSVFile {
    @AuraEnabled
    public static wrapper loadData( String sObjectName, Id contentDocumentId ) {
        wrapper wrp = new wrapper();
        System.debug( 'Loading data for content document' + contentDocumentId );

        String strMessage;
        String listType = 'List<'+sObjectName+'>';
        List < sObject > contactList = (List<sObject>)Type.forName(listType).newInstance();

        if ( contentDocumentId != null ) {
            
            ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId ];
            List < String > records = contentVersionObj.VersionData.toString().split('\n');
            
            System.debug( 'records: ' + records.size() );
            //Removing the Header
            records.remove( 0 );

            for ( String record : records ) {

                if ( record != null ) {

                    sObject objContact = (sObject)Type.forName(sObjectName).newInstance();
                    List < String > row = record.split( ',' );
                    Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
                    
                    Map <String, Schema.SObjectField> fieldMap = schemaMap.get(sObjectName).getDescribe().fields.getMap();
                    for(Schema.SObjectField sfield : fieldMap.Values())
                    {
                        schema.describefieldresult dfield = sfield.getDescribe();
                        system.debug('#######' + dfield );
                        system.debug('#######4444' +  dfield.getname());
                        //lstfieldname.add(field);
                    }

                    contactList.add( objContact );
                    wrp.lstObject = contactList;
                }

            }
            System.debug( 'contactList: ' + contactList );

            try {    

                if ( contactList.size() > 0 ) {
                    system.debug( 'contactList.size(): ' + contactList.size() );
                    //Database.DeleteResult deleteResult = Database.delete( contentDocumentId, true );
                    insert contactList;
                    strMessage = 'Records loaded successfully';

                }

            }
            catch ( Exception e ) {

                strMessage = 'Some error occured. Please reach out to your System Admin';
                system.debug( e.getMessage() );

            } 
        }
        System.debug( 'strMessage: ' + strMessage );
        return wrp;

    }

    class wrapper{
        public List<SObject> lstObject{get;set;}
    }

}