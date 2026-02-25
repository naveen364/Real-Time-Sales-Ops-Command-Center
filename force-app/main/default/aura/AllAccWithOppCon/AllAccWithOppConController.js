({
	init : function(component, event, helper) {
		var action = component.get("c.getAcc");
        var listOfAcc;
        action.setCallback(this , function(res){
            var state = res.getState();
            listOfAcc = res.getReturnValue();
            if(state == 'SUCCESS'){
                console.log(listOfAcc);
                component.set("v.listOfAcc",listOfAcc);
            }
        });
        $A.enqueueAction(action);
	},
    onchangeAcc : function(component, event, helper) {
		console.log(component.find('select').get('v.value'));
        var action = component.get("c.getCon");
        var action2 = component.get("c.getOpp");
        var listOfCon;
        var listOfOpp;
        action.setParams({
            "ids" : component.find('select').get('v.value') 
        });
        action.setCallback(this, function(res){
            var state = res.getState();
            listOfCon = res.getReturnValue();
            if(state == 'SUCCESS'){
                console.log(listOfCon);
                component.set("v.conlist",listOfCon);
            }
        });
        $A.enqueueAction(action);
        action2.setParams({
            "ids" : component.find('select').get('v.value') 
        });
        action2.setCallback(this, function(res){
            var state = res.getState();
            listOfOpp = res.getReturnValue();
            if(state == 'SUCCESS'){
                console.log(listOfOpp);
                component.set("v.opplist",listOfOpp);
            }
        });
        $A.enqueueAction(action2);
	}
})