({
    getNumbers : function(component, event, helper) {
        try{
            console.log('in side in controller ');
            var action = component.get('c.listofacc');
            var check;
            action.setCallback(this , function(res){
                console.log(' inside  in callback ');
                var state = res.getState();
                console.log('state --> '+state);
                console.log('state --> '+res.getReturnValue());
                check = res.getReturnValue();
                if(state =='SUCCESS'){
                    console.log('state  success--> '+state);
                    component.set('v.acclist',res.getReturnValue());
                    console.log('result --> '+res.getReturnValue());
                }
            });
            $A.enqueueAction(action);
        }catch(err){
            console.log('error --> '+err);
        }
        
    },
    onchangeAcc : function(component, event, helper){
        //console.log(component.find('select').get('v.value'));
        var mapCon = component.get('c.childs');
        
        mapCon.setCallback(this , function(res){
            var mapcon = res.getReturnValue();
            var conlist = mapcon[component.find('select').get('v.value')];
            console.log(conlist);
            component.set("v.conlist",conlist)
        });
        $A.enqueueAction(mapCon);
    }
})