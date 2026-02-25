({
    helperMethod : function(component, event, helper) {
        try{
            console.log("enter in helper");
            var username = component.find("username").get("v.value");
            var password = component.find("password").get("v.value");
            console.log('username==>'+username+' password==>'+password);
            var action = component.get("c.xyz");
            
            if(username == undefined || password == undefined){
                console.log('username==>'+username+' password==>'+password);
            }else{
                console.log('username==>'+username+' password==>'+password);
                action.setParams({
                    "username":username,
                    "password":password
                });
                action.setCallback(this,function(res){
                    console.log('state==>'+res.getState());
                    if(res.getState() == "SUCCESS"){
                        var result = res.getReturnValue();
                        if(res.getReturnValue() != null){
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Success',
                                message: result,
                                duration:' 5000',
                                key: 'info_alt',
                                type: 'success',
                                mode: 'pester'
                            });
                            toastEvent.fire();
                        }else{
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Error',
                                message:'Incorrect UserName or Password',
                                duration:' 5000',
                                key: 'info_alt',
                                type: 'error',
                                mode: 'pester'
                            });
                            toastEvent.fire();
                        }
                    }
                });
                $A.enqueueAction(action);
            }
        }catch(e){
            console.log("error==>"+e);
        }
    }
})