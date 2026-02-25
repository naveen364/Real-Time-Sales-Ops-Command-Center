({
    myAction : function(component, event, helper) {
        var AccountName = component.get("v.AccountName");
        var NumOfContact = component.get("v.NumberOfContact");
        var action = component.get("c.insertAccCon");
        console.log("AccountName==>"+AccountName);
        console.log("Number of contact==>"+NumOfContact);
        action.setParams({
            "Name": AccountName,
            "Num": NumOfContact
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            component.set("v.Result",a.getReturnValue());
            if (state === "SUCCESS") {
                
                alert("hello from here");
            }
        });
        $A.enqueueAction(action)
    }
 })