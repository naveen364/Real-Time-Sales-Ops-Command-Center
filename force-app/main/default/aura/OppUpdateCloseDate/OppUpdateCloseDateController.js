({
    doInit : function(component, event, helper) {
        var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
    },

    setOutput : function(component, event, helper) {
        var recordId = component.get('v.recordId');
    	var cmpMsg = component.find("msg");
    	$A.util.removeClass(cmpMsg, 'hide');
        var expdate = component.find("expdate").get("v.value");

        var oDate = component.find("oDate");
        oDate.set("v.value", expdate);
        console.log("recordId"+recordId);
        var action = component.get("c.SetCloseDate");
        action.setParams({
            "ids" : recordId,
            "clsdate" : expdate
        });
        console.log("Date"+expdate);
        action.setCallback(this,function(a){
            var state = a.getState();
            if (state === "SUCCESS") {
               alert("success updated CloseDate");
            }
        });
        $A.enqueueAction(action);
    }
})