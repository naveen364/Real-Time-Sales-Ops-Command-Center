({
helperMethod : function(component, event,helper) {
    try{
    console.log("inside helper");

    
    var objkey = component.find('obj').get('v.value');
    var fieldkey = component.find('fields').get('v.value');

    if(objkey == undefined){
        this.getobj(component, event,helper);
    }else{
        component.set("v.apiName",objkey);
        console.log('objkey selected ==>'+component.find("obj").get("v.value"));
        var action = component.get("c.objfields");
        var key = component.find("obj").get("v.value");
        action.setParams({
            "key" : key
        });
        action.setCallback(this,function(res){
            
            if (res.getState() === "SUCCESS") {
                component.set("v.objType",res.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = res.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
    }catch(e){
        console.log("error==>"+e);
    }
},
getobj : function(component, event,helper) {
    try{
        console.log("inside getObj function");
        var action = component.get("c.objName");

        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('statte--> '+state);
            //console.log('response::'+response.getReturnValue());
            if (state === "SUCCESS") {
                component.set("v.key",response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
        }catch(e){
            console.log("error==>"+e);
        }
    },
    getfieldType : function(component, event,helper){
        try{
            console.log("inside getObj function");
            var action = component.get("c.getfieldType");
            var key = component.find("obj").get("v.value");
            var field = component.find("fields").get("v.value");
            action.setParams({
                "key" : key,
                "field" : field
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log('statte--> '+state);
                console.log('getfield response::'+response.getReturnValue());
                if (state === "SUCCESS") {
                    component.set("v.apiType",response.getReturnValue());
                    console.log('type==>'+component.get("v.apiType"));
                }
                else if (state === "INCOMPLETE") {
                    // do something
                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                    errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
        }catch(e){

        }
    }
})