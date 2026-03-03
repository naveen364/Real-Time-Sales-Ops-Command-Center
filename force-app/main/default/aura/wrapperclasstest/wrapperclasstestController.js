({
    init : function(component, event, helper) {
        var action = component.get("c.wrappertest");
        var position = component.find('select').get('v.value');
        if(position == undefined){
            position = 0;
        }
        action.setParams({
            "i" : position
        });
        action.setCallback(this,function(a){
            var res = a.getReturnValue();
            component.set("v.listOfAcc",res.acclist);
            component.set("v.conlist",res.conlist);
            component.set("v.opplist",res.opplist);
        });
        $A.enqueueAction(action);
        
    },
    onchangeAcc : function(component, event, helper) {
        console.log(component.find('select').get('v.value'));
        helper.helperMethod(component, event);
    }
})