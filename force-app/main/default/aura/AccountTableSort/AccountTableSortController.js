({
    init : function(component, event, helper) {
        helper.helperMethod(component,event,helper);
    },
    sortName : function(component, event, helper) {
        var buttonstate = component.get("v.buttonstate");
        component.set("v.buttonstate", !buttonstate);
        var obj = component.get("v.Acc");
        console.log("obj==>"+obj[0].Name);
        if(buttonstate){
        obj.sort((a,b)=>{
            let fa = a.Name.toLowerCase(),
            fb = b.Name.toLowerCase();
    
            if (fa < fb) {
                return -1;
            }
            if (fa > fb) {
                return 1;
            }
            return 0;
        });
        }else{
            obj.sort((a,b)=>{
                let fa = a.Name.toLowerCase(),
                fb = b.Name.toLowerCase();
        
                if (fa > fb) {
                    return -1;
                }
                if (fa < fb) {
                    return 1;
                }
                return 0;
            });
        } 
        console.log(obj[0].Name);
        component.set("v.Acc",obj);
    }
})