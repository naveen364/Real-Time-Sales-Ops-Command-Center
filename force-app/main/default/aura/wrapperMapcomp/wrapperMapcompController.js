({  
   
    init : function(component, event, helper) {
        var action = component.get("c.wrappermap");
        action.setCallback(this,function(res){
            if(res.getState() == "SUCCESS"){
                var wrapper = res.getReturnValue();
                var mapcon = wrapper.conmap;
                var mapopp = wrapper.oppmap;
                component.set("v.conmap",mapcon);
                component.set("v.oppmap",mapopp);
                console.log('wrapper--->'+JSON.stringify(wrapper.acclist));
                console.log('wrapper--->'+JSON.stringify(wrapper.conmap));
                console.log('wrapper--->'+wrapper.oppmap);
                component.set("v.listOfAcc",wrapper.acclist);
            }
        });
        $A.enqueueAction(action);
    },
    onchangeAcc : function(component, event, helper) {
        var key = component.find('select').get('v.value');
        var mapcon = component.get("v.conmap");
        var mapopp = component.get("v.oppmap");
        console.log("on change key==>"+key);
        console.log("inside controller onchange==>"+mapopp[key]);
        helper.helperMethod(component,event,mapcon,mapopp);
    }
})