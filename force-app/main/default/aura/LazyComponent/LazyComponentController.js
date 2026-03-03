({
    onInit : function(component,event,helper){
        component.set("v.accountColums",
                      [
                          {
                              label : 'Contact Name',
                              fieldName : 'Id',
                              type : 'url',
                              sortable: true,
                              typeAttributes:{label:{fieldName:'LastName'},target:'_blank' }
                          },
                          {     
                              label : 'Account Name',
                              sortable: true,
                              fieldName : 'AccountName',
                              type : 'text',
                          },
                          {
                              label : 'Phone',
                              fieldName : 'Phone',
                              type : 'text',
                          }
                      ]);
        helper.getData(component);
    },
    
    handleLoadMore : function(component,event,helper){
        if(!(component.get("v.currentCount") >= component.get("v.totalRows"))){
            //To display the spinner
            event.getSource().set("v.isLoading", true); 
            //To handle data returned from Promise function
            helper.loadData(component).then(function(data){ 
                var currentData = component.get("v.accountData");
                var newData = currentData.concat(data);
                component.set("v.accountData", newData);
                //To hide the spinner
                event.getSource().set("v.isLoading", false); 
            });
        }
        else{
            //To stop loading more rows
            component.set("v.enableInfiniteLoading",false);
            event.getSource().set("v.isLoading", false);
            var toastReference = $A.get("e.force:showToast");
            toastReference.setParams({
                "type":"Success",
                "title":"Success",
                "message":"All Contact records are loaded",
                "mode":"dismissible"
            });
            toastReference.fire();
        }
    }

    
})