({
    init : function(component, event, helper) {
        helper.helperMethod(component,event,helper);
    },
    sortName : function(component, event, helper) {
        component.set("v.expandstate",false);
        var buttonstate = component.get("v.buttonstate");
        component.set("v.buttonstate", !buttonstate);
        var obj = component.get("v.paginationList");
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
        component.set("v.opp",obj);
        component.set("v.paginationList",obj);
    },
    onSelectChange : function(component, event, helper) {
        component.set("v.expandstate",false);
        var selected = component.find("records").get("v.value");
        component.set("v.pageSize", selected);
        component.set("v.start", 0);
        component.set("v.end", selected-1); 
        var paginationList = [];
        var oppList = component.get("v.opp");
        for(var i=0; i< selected; i++){
            paginationList.push(oppList[i]);
        }
        component.set("v.pageSize",selected);
        helper.helperMethod(component,event,helper);
        component.set("v.paginationList", paginationList);
        console.log("pagelist of limit==>"+JSON.stringify(paginationList));
    },
    first : function(component, event, helper){
        component.set("v.expandstate",false);
        helper.helperMethod(component,event,helper);
        var oppList = component.get("v.opp");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        for(var i=0; i< pageSize; i++){
            paginationList.push(oppList[i]);
        }
        component.set("v.paginationList", paginationList);
        console.log(" first btn pagelist of limit==>"+JSON.stringify(paginationList));
    },
    last : function(component, event, helper){
        try{
            component.set("v.expandstate",false);
            var oppList = component.get("v.opp");
            var pageSize = component.get("v.pageSize");
            var start = component.get("v.start");
            var totalSize = component.get("v.totalSize");
            var end = component.get("v.end"); 
            var paginationList = [];
            console.log("::73 pageSize==>"+pageSize);
            console.log("::74 totalSize==>"+totalSize);
            var rem = totalSize % pageSize;
            var from = parseInt(totalSize) - parseInt(pageSize) + 1;
                for(var i=from; i< totalSize; i++){
                    paginationList.push(oppList[i]);
                }
                console.log("::78 start==>"+start);
                component.set("v.start",end);
                component.set("v.end",parseInt(totalSize)+1);
                component.set("v.paginationList", paginationList);
                console.log("last btn pagelist of limit==>"+JSON.stringify(paginationList));
        }catch(e){
            console.log("last btn error == > ",e);
        }
    },
    next : function(component, event, helper){
        try{
            component.set("v.expandstate",false);
            var oppList = component.get("v.opp"); //list of object api
            var end = component.get("v.end"); 
            var start = component.get("v.start");
            var pageSize = component.get("v.pageSize");
            var paginationList = [];
            var counter = 0;
            var from = parseInt(end) + 1;
            var to = parseInt(end) + parseInt(pageSize) + 1;
            console.log("start==>",start);
            console.log("end==>",end); //4
            console.log("pagesize",pageSize); //5
            console.log("obj.length",oppList.length);
            for(var i=from; i<to; i++){
                
                if(oppList.length > i && oppList[i] != null){
                    paginationList.push(oppList[i]);
                    counter ++ ;
                }else{
                    break;
                }
                
            }
            start = start + counter;
            end = end + counter;
            component.set("v.start",start);
            component.set("v.end",end+1);
            component.set("v.paginationList", paginationList);
            //console.log("nxt btn pagelist of limit==>"+JSON.stringify(paginationList));
            console.log("pagination size ==>",paginationList.length);
        }catch(e){
            console.log("nxt error ==>",e);
        }
    },

    previous : function(component, event, helper){
    component.set("v.expandstate",false);
    var oppList = component.get("v.opp");
    var end = component.get("v.end");
    var start = component.get("v.start");
    var pageSize = component.get("v.pageSize");
    var paginationList = [];
    var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                paginationList.push(oppList[i]);
                counter ++;
            }
            else {
                start++;

            }
        }
    start = start - counter;
    end = end - counter;
    component.set("v.start",start);
    component.set("v.end",end);
    component.set("v.paginationList", paginationList);
    console.log("pre btn pagelist of limit==>"+JSON.stringify(paginationList));
    },
    expand : function(component, event, helper){
        var state = component.get("v.expandstate");
        component.set("v.expandstate",!state);
        console.log("state==>",state);
        var oppList = component.get("v.paginationList");
        console.log("qwertyuio");
        var whichOne = event.getSource().get('v.value');
        console.log(whichOne);

        var start = component.get("v.start");
        component.set("v.index",whichOne);
        console.log("get index==>",component.get("v.index"));
        component.set("v.oppId",oppList[whichOne].Id);
        console.log("oppname==>",oppList[whichOne].Name);

        var id = component.find(event.getSource().getLocalId());
        console.log("id==>",id);

        var spinner = component.find("mySpinner");
        $A.util.toggleClass(spinner, "slds-hide");
    }
    
})