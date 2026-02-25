({
    helperMethod : function(cmp,evt,helper) {
        
        var action = cmp.get("c.getName");
        var queryTerm = cmp.get("v.key");
        console.log("btn==>key==>"+queryTerm);
        action.setParams({
            "name":queryTerm
        });
        action.setCallback(this,function(res){
            console.log("state==>"+res.getState());
            if(res.getState()=="SUCCESS"){
                var list = res.getReturnValue();
                console.log("list==>"+list);
                if(list != null){
                    //cmp.set("v.AccountName",list);
                    cmp.set("v.Account",list);
                }else{
                    console.log("there is no account");
                }
            }
        });
        $A.enqueueAction(action);
    },
    create : function(cmp,evt,helper){
        try{
            console.log("called create");
            var LastName = cmp.find("LastName").get("v.value");
            cmp.set("v.ContactName",LastName);
            var accId = cmp.get("v.AccId");
            var action = cmp.get("c.createCon");
            console.log("accid==>"+accId+" LastName==>"+LastName);
            action.setParams({
                "name": LastName,
                "ids" : accId
            });
            action.setCallback(this,function(res){
                if(res.getState()=="SUCCESS"){
                    alert("called...");
                }
            });
            $A.enqueueAction(action);
        }catch(e){
            console.log("error==>"+e);
        }
    }
})