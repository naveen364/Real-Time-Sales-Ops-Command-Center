({
    helperMethod : function(component,event,helper) {
        try{
        var pageSize = component.get("v.pageSize");
        var action = component.get("c.get");
        action.setCallback(this,function(res){
            console.log("state==>"+res.getState());
            if(res.getState()=="SUCCESS"){
                console.log("::8 inside success");
                var obj = res.getReturnValue();
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
                component.set("v.opp",obj);
                //console.log("nxt total size"+component.get("v.opp").length);
                component.set("v.totalSize",component.get("v.opp").length);
                //console.log("nxt start");
                component.set("v.start",0);
                component.set("v.end",pageSize-1);
                console.log(" end");
                var paginationList = [];
                for(var i=0; i< pageSize; i++){
                    paginationList.push(res.getReturnValue()[i]);
                }
                component.set("v.paginationList", paginationList);
                console.log("pagination"+JSON.stringify(paginationList));
            }
        });
        $A.enqueueAction(action);
        }catch(e){
            console.log("error==>"+e);
        }
    }
})