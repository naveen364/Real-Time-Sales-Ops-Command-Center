({
    getData : function(component){
        var action = component.get("c.getAccountRecords");
        action.setParams({
            "initialRows" : component.get("v.initialRows")
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            var toastReference = $A.get("e.force:showToast");
            if(state == "SUCCESS"){
                var accountWrapper = response.getReturnValue();
                if(accountWrapper.success){
                    component.set("v.totalRows",accountWrapper.totalRecords);  
                    
                    var accountList = accountWrapper.accountsList;
                    accountList.forEach(function(account){
                        account.Id = '/'+account.Id;
                    });
                    for(var i = 0; i < accountList.length; i++){
                        var row = accountList[i];
                        if (row.Account) row.AccountName = row.Account.Name;
                    }
                    component.set("v.accountData",accountList);
                    toastReference.setParams({
                        "type" : "Success",
                        "title" : "Success",
                        "message" : accountWrapper.message,
                        "mode" : "dismissible"
                    });
                    toastReference.fire();
                }
                else{
                    toastReference.setParams({
                        "type" : "Error",
                        "title" : "Error",
                        "message" : accountWrapper.message,
                        "mode" : "sticky"
                    }); 
                    toastReference.fire();
                }
            }
            else{
                toastReference.setParams({
                    "type" : "Error",
                    "title" : "Error",
                    "message" : 'An error occurred during Initialization '+state,
                    "mode" : "sticky"
                });
                toastReference.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    loadData : function(component){
        return new Promise($A.getCallback(function(resolve){
            var limit = component.get("v.initialRows");
            var offset = component.get("v.currentCount");
            var totalRows = component.get("v.totalRows");
            if(limit + offset > totalRows){
                limit = totalRows - offset;
            }
            var action = component.get("c.loadAccountRecords");
            action.setParams({
                "rowLimit" :  limit,
                "rowOffset" : offset
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                var newData = response.getReturnValue();
                // play a for each loop on list of new accounts and set Account URL in custom 'accountName' field
                newData.forEach(function(contact){
                    contact.Id = '/'+contact.Id;
                });
                for(var i = 0; i < newData.length; i++){
                    var row = newData[i];
                    if (row.Account) row.AccountName = row.Account.Name;
                }
                resolve(newData);
                var currentCount = component.get("v.currentCount");
                currentCount += component.get("v.initialRows");
                // set the current count with number of records loaded 
                component.set("v.currentCount",currentCount);
                console.log("contacts ==> "+JSON.stringify(newData));
            });
            $A.enqueueAction(action);
        }));
    }
})