({
	myAction : function(component, event, helper) {
		console.log('Im in controller');
       
        var data = component.get("v.Name");
        console.log('PRint ===>>>> '+data);
         var action = component.get("c.InsertMethod");

    action.setParams({ 
        "Apexname": data
    });
    action.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
               
               alert("hello from here");
            }
        });
    $A.enqueueAction(action)
	}
})