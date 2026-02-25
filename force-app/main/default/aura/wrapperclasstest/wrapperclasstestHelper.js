({
    helperMethod : function(component, event) {
        var action = component.get("c.wrappertest");
        var position = component.find('select').get('v.value');
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
    }
})