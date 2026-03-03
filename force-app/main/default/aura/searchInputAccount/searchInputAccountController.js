({
    onchangekey: function (cmp, evt, helper) {
        try{
        console.log("start onchange");
            var queryTerm = cmp.find('range').get('v.value');
            if(queryTerm != undefined){
                console.log("key==>"+queryTerm);
                cmp.set("v.key",queryTerm);
                helper.helperMethod(cmp,evt,helper);
            }
        }catch(e){
            console.log("Error==>"+e);
        }
    },
    myAction: function(cmp,evt,helper){
        helper.helperMethod(cmp,evt,helper);
        helper.create(cmp,evt,helper);
    },
    onchangeacc : function(cmp,evt,helper){
        try{
            var id = cmp.find("accs").get("v.value");
            console.log("id==>"+id);
            cmp.set("v.AccId",id);
        }catch(e){
            console.log("Error==>"+e);
        }
    }
})