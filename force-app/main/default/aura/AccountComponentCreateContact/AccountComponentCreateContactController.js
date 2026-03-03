({
    handleClick : function(component, event, helper) {
        try{
            var lst = component.get("v.lst");
            var index = component.get("v.indx");
            let obj ={};
            let tempArray = lst;
            tempArray.push(obj);
            component.set("v.lst", tempArray);
        }catch(e){
            console.log("error==>"+e);
        }
    },
    delClick : function(component, event, helper) {
        console.log('index::' +event.getSource().get('v.value'));
        var index = event.getSource().get('v.value');
        var lst = component.get("v.lst");
        lst.splice(index,1);
        console.log(lst);
        component.set("v.lst", lst);
    },
    submit : function(component, event, helper) {
        try{
        helper.loaddata(component, event, helper);
        var lst = component.get("v.lst");
        var action = component.get("c.create");
        var accId = component.get("v.recordId");
        lst.shift();
        console.log("lst==>"+JSON.stringify(lst));
        
        var map = JSON.stringify(lst);
        
        action.setParams({
            "name" : lst,
            "ids"  : accId
        });
        action.setCallback(this,function(res){
            if(res.getState() == "SUCCESS"){
                alert("submitted!");
            }
        });
        $A.enqueueAction(action);
        component.set("v.lst",[{}]);
    }catch(e){
        console.log("error==>"+e);
    }
    }
})