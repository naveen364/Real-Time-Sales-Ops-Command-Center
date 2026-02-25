({
    getAgePrediction: function(component, event, helper) {
        console.log('INIT');
        var action = component.get("c.getAgePrediction");
        var name = component.get("v.name");

        console.log('Names'+name);
        
        action.setParams({ Names: name });

        action.setCallback(this, function(response) {
            console.log('callback');
            var state = response.getState();
            console.log("Response state: ", state);
            if (state === "SUCCESS") {
                console.log('SUCCESS');
                var returnValue = response.getReturnValue();
                console.log("Response received: ", returnValue);

                if (returnValue) {
                    component.set("v.agePrediction", returnValue);
                } else {
                    console.error("Response is null or undefined");
                }
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.error("Error message: " + errors[0].message);
                    } else {
                        console.error("Unknown error");
                    }
                }
            }
        });

        $A.enqueueAction(action);
    }
});