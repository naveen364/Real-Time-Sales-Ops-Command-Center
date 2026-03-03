({
    loaddata : function(component, event, helper) {
        try{
            var lst = component.get("v.lst");
            var compfirst = component.find("first");
            var compsecond = component.find("last");
            var objlst = component.get("v.conlist");
            var updatelst = [{}];
            var accId = component.get("v.recordId");
            console.log("inside for loaddata"+lst.length);
            for(var i = 0;i<lst.length;i++){
                console.log("inside for loaddata");
                console.log("all inputs "+compfirst[i].get("v.value"));
                console.log("all inputs "+compsecond[i].get("v.value"));
                console.log("::before name");
                var name = compfirst[i].get("v.value")+" "+compsecond[i].get("v.value");
                //
                objlst={
                    "LastName":name,
                    "sobjectType":"Contact",
                    "AccountId":accId
                };
                updatelst.push(objlst);
                //
                // console.log("name==>"+name);
                // updatelst.push({
                //     "name" : name,
                // });

            }
            console.log("updatelst==>"+JSON.stringify(updatelst));
            component.set("v.lst",updatelst);
        }catch(e){
            console.log("::helper error==>"+e);
        }
    }
})