({
    init : function(component, event, helper) {
        console.log("here child");
        console.log("ids==>",component.get("v.theId"));
        var ids = component.get("v.theId");
        var action = component.get("c.get");
        action.setParams({
            'ids':ids
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            console.log(state);
            if(state === "SUCCESS"){
                component.set("v.lst",res.getReturnValue());
                console.log("datas==>"+res.getReturnValue());
                if(res.getReturnValue().length>0){
                    component.set("v.NoLineItem",false);
                }else{
                    console.log("else no data==>"+component.get("v.NoLineItem"));
                    //component.set("v.spinner",false);
                    component.set("v.NoLineItem",true);
                }
            }
        });
        $A.enqueueAction(action);
    },
    showSpinner : function(component, event, helper){
        component.set("v.spinner", true);
    },
    hideSpinner : function(component, event, helper){
        component.set("v.spinner", false);
    },
    updatebtn :function(component, event, helper){
        try{
            var lst = component.get("v.lst");
            var action = component.get('c.updateoli');
            action.setParams({
                'olilist' : lst
            });
            action.setCallback(this,function(res){
                console.log("state==>"+res.getState());
                if(res.getState() == "SUCCESS"){
                    var toastEvent = $A.get("e.force:showToast");
                    console.log("here ::44");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Updated Successfully',
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
                        message:'Incorrect Fields',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
            console.log("newlist==>"+lst);
            
        }catch(e){
            console.log("error in update==>"+e);
        }
    }
})