({
helperMethod : function(component, event,mapcon,mapopp) {
var key = component.find('select').get('v.value');
console.log("current key==>"+key);
    if(mapcon[key] != null){
        console.log("conlist==>"+mapcon[key]);
        component.set("v.conlist",mapcon[key]);
    }else{
        console.log("key missing");
    }
    if(mapcon[key] != null){
        console.log("opplist==>"+mapopp[key]);
        component.set("v.opplist",mapopp[key]);
    }else{
        console.log("key missing");
    }
}

})