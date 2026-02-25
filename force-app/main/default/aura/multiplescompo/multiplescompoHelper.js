({
    helperMethod : function(component, event, helper) {
        console.log("inside hanleclick")
        var range = component.find("range").get("v.value");
        var first = component.find("first").get("v.value");
        console.log("range==>"+range+"  first==>"+first);
        if(range == undefined || first == undefined){
            range = 1;
            first = 1;
        }
        component.set("v.fst",first);
        console.log("range==>"+range);
        var list = [];
        for(var i=1;i<=range;i++){
            console.log("inside for");
            list.push(i);
        }
        console.log("list==>"+list);
        component.set("v.rang",list);
    }
})