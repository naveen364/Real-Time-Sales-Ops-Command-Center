/*"Create custom object Name as  'Time'.
Create Two Fields  Start_date  and End_Date datatype as date 
Create a Relation between Contact(Parent) and Time(Child) Object
Write a Trigger whenever a Time record will be inserted or updated which name Starts with ""A"" 
and End Date exist in last month then It will create or update contact record last name with same name as time record."*/

trigger timetrigger on Time__c (After insert , After update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        customTimewithContact.abc(trigger.new);
    }
}