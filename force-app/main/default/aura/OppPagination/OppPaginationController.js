({
    mahesh : function(component, event, helper)
    {
        var pageSize = component.get("v.pageSize");
        var action = component.get("c.getOpportunities");
          console.log(pageSize);
        action.setCallback(this, function(response)
        {
            var state = response.getState();

            if (component.isValid() && state === "SUCCESS")
            {
                component.set('v.opportunityList', response.getReturnValue());
                component.set("v.totalSize", component.get("v.opportunityList").length);
                component.set("v.start", 0);
                component.set("v.end", pageSize-1);
                var paginationList = [];

                for(var i=0; i< pageSize; i++)
                {
                    paginationList.push(response.getReturnValue()[i]);
                }

                component.set('v.paginationList', paginationList);
           }
       });

       $A.enqueueAction(action);
    },
    onSelectChange : function(component, event, helper)
    {
        var selected = component.find("records").get("v.value");
        component.set("v.pageSize", selected);
        component.set("v.start", 0);
        component.set("v.end", selected-1);    
        var paginationList = [];
        var oppList = component.get("v.opportunityList");

        for(var i=0; i< selected; i++)
        {
            paginationList.push(oppList[i]);
        }

        component.set('v.paginationList', paginationList);
    },
    searchKeyChange: function(component, event)
    {
        var searchKey = component.find("input1").get("v.value");
        console.log(searchKey);
        var action = component.get("c.getByName");
        var keysize = component.get("v.totalSize");
        var pageSize = component.get("v.pageSize");
        
        action.setParams({
            "searchKey": searchKey
        });

        action.setCallback(this, function(response)
        {
            var state = response.getState();

            if (component.isValid() && state === "SUCCESS")
            {
                component.set('v.opportunityList', response.getReturnValue());
                component.set("v.totalSize", component.get("v.opportunityList").length);
                var paginationList = [];
                var retrievedTotalSize = component.get("v.totalSize");
                 
                for(var i=0; i < pageSize; i++)
                {
                    paginationList.push(response.getReturnValue()[i]);
                }

                component.set('v.paginationList', paginationList);
                component.set("v.start", 0);
                component.set("v.end", pageSize-1);        
            }
        });
        $A.enqueueAction(action);
    },
    first : function(component, event, helper)
    {
        var oppList = component.get("v.opportunityList");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];

        for(var i=0; i< pageSize; i++)
        {
            paginationList.push(oppList[i]);
        }

        component.set('v.paginationList', paginationList);
        component.set("v.start", 0);
        component.set("v.end", pageSize-1);
    },
    last : function(component, event, helper)
    {
        var oppList = component.get("v.opportunityList");
        var pageSize = component.get("v.pageSize");
        var totalSize = component.get("v.totalSize");
        var paginationList = [];
        var start = component.get("v.start");              
        var end = component.get("v.end");
        
        do
        {
            start = parseInt(start) + parseInt(pageSize);
            end = parseInt(end) + parseInt(pageSize);    
        } while(end < totalSize);
        
        start = start - parseInt(pageSize);
        end = end - parseInt(pageSize);        
        var counter = 0;
        var EndPlusOne = end + 1;
        
        if(totalSize > EndPlusOne)
        {
            //alert('totalSize is greater than EndPlusOne');  
        }
        else
        {
            start = start - parseInt(pageSize);
            end = end - parseInt(pageSize);
        }

        var EndAddOne = end + 1;
        var endPlusPageSizePlusOne = end + parseInt(pageSize) + 1;
        
        for(var i = EndAddOne; i < endPlusPageSizePlusOne; i++)
        {
            if(oppList.length > end)
            {
                if(i > -1)
                {
                    paginationList.push(oppList[i]);
                    counter ++ ;
                }
            }
        }

        start = start + counter;
        end = end + counter;
        component.set('v.paginationList', paginationList);
        component.set("v.start",start);  
        component.set("v.end",end);
    },
    next : function(component, event, helper)
    {
        var oppList = component.get("v.opportunityList");
        var end = component.get("v.end");        
        var start = component.get("v.start");
        var pageSize = component.get("v.pageSize");
        var totalSize = component.get("v.totalSize");
        var paginationList = [];
        var counter = 0;        
        var EndPlusOne = end + 1;
        var EndPlusPageSizePlusOne = end + parseInt(pageSize) + 1;
        
        for(var i = EndPlusOne; i < EndPlusPageSizePlusOne; i++)
        {
            if(oppList.length > end)
            {
                paginationList.push(oppList[i]);
                counter ++ ;
            }
        }
        
        start = start + counter;
        end = end + counter;
        component.set("v.start",start);        
        component.set("v.end",end);        
        component.set('v.paginationList', paginationList);
    },
    previous : function(component, event, helper)
    {
        var oppList = component.get("v.opportunityList");
        var end = component.get("v.end");
        var start = component.get("v.start");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        var counter = 0;

        for(var i= start-pageSize; i < start ; i++)
        {
            if(i > -1)
            {
                paginationList.push(oppList[i]);
                counter ++;
            }
            else
            {
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.start", start);
        component.set("v.end",end);
        component.set('v.paginationList', paginationList);
    }
})