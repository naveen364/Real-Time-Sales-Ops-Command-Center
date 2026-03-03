/*"Create custom object Name as  'Time'.
Create Two Fields  Start_date  and End_Date datatype as date 
Create a Relation between Contact(Parent) and Time(Child) Object
Write a Trigger whenever a Time record will be inserted or updated which name Starts with ""A"" 
and End Date exist in last month then It will create or update contact record last name with same name as time record."*/

public class customTimewithContact {
    
    public static void abc(List<Time__c> triggerlist){
        List<Time__c> timeObjectlist = [select id,End_Date__c,contact__r.LastName,Start_Date__c,Name,contact__c from Time__c where Name like 'A%' And End_Date__c > :Date.Today().addMonths(-1) and id in :triggerlist];
        List<Contact> conlist = new List<Contact>();
        set<Id> contactid = new set<Id>();
        for(Time__c timeIns : timeObjectlist){
            contactid.add(timeIns.Contact__c);
        }
        conlist = [select id from contact where id in :contactid];
        Map<Id,Contact> MapofContact = new Map<Id,Contact> (conlist);
        
        for(Time__c timeIns : timeObjectlist){
            if(timeIns.Contact__c == null){
                Contact con = new Contact();
                con.LastName = timeIns.Name;
                conlist.add(con);
            }else{
                Contact con = MapofContact.get(timeIns.Contact__c);
                con.LastName = timeIns.Name;
                conlist.add(con);
            }
        }
        
        if(!conlist.isEmpty()){
            upsert conlist;
        }
    }
}