({
    helperMethod : function(component,event,helper) {
        try{
        var action = component.get("c.get");
        action.setCallback(this,function(res){
            console.log("state==>"+res.getState());
            if(res.getState()=="SUCCESS"){
                console.log("inside success");
                var obj = res.getReturnValue();
                component.set("v.Acc",obj);
            }
        });
        $A.enqueueAction(action);
        }catch(e){
            console.log("error==>"+e);
        }
    }
})