public class PropertyUtility {
    public static void newListedProperties(){
        List<Property__c> newPropList = new List<Property__c>();
        String propEmail;
        newPropList = [select Name,Days_On_Market__c,Broker__r.Email__c from Property__c where Days_On_Market__c<31];
        for(Property__c prop : newPropList){
            propEmail = prop.Name+':'+prop.Broker__r.Email__c;
            System.debug(propEmail);
        }
    }
}