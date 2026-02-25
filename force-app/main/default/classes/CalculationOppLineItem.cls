/*"Create 4 custom fileds in Opportunity
 * 1: Sum of TotalPrice
 * 2: sum of UnitPrice
 * 3: Maximum Quantity
 * 4: minimum Quantity
 Write a script to calculate total price, TOtal unitPrice , maximum Quantity, and minimum Quantity of the opportuniyLineItem ,
 and store the values in Every opportunity custom fields."*/

public class CalculationOppLineItem {
    public static void calculateOpportunity(){
        Map<Id,List<opportunityLineItem>> mapofOpportunityWithLineItem = new Map<Id,List<opportunityLineItem>>();
        List<opportunityLineItem> listofLineItem = new List<opportunityLineItem>();
        listofLineItem = [select id,TotalPrice,UnitPrice,Quantity from opportunityLineItem limit 50000];
        
        //iterate each lineItem and store with respected opportunity map
        for(opportunityLineItem lineItem : listofLineItem){
            if(!mapofOpportunityWithLineItem.containskey(lineItem.OpportunityId)){
                mapofOpportunityWithLineItem.put(lineItem.OpportunityId,new List<opportunityLineItem>{lineItem});
            }else{
                mapofOpportunityWithLineItem.get(lineItem.OpportunityId).add(lineItem);
            }
        }
        
        List<Opportunity> listOfOpportunity = new List<Opportunity>();
        listOfOpportunity = [select id,Maximum_Quantity__c,minimum_Quantity__c,sum_of_UnitPrice__c,Sum_of_TotalPrice__c from Opportunity limit 50000];
        Integer tempMinQuantity;
        Integer tempMaxQuantity;
        Integer tempTotalUnitPrice;
        Integer tempTotalPrice;
        List<Integer> tempListOfQuantity = new List<Integer>();
        //iterate opportunity & perform logic to calculate.
        for(Opportunity opp : listOfOpportunity){
            tempMinQuantity = 0;
            tempMaxQuantity = 0;
            tempTotalUnitPrice = 0;
            tempTotalPrice = 0;
            tempListOfQuantity.clear();
            if(mapofOpportunityWithLineItem.containsKey(opp.Id)){
                for(opportunityLineItem lineItem : mapofOpportunityWithLineItem.get(opp.Id)){
                    tempTotalPrice = lineItem.TotalPrice == null?0:tempTotalPrice + Integer.valueOf(lineItem.TotalPrice);
                    tempTotalUnitPrice = lineItem.UnitPrice == null?0:tempTotalUnitPrice + Integer.valueOf(lineItem.UnitPrice);
                    tempListOfQuantity.add(Integer.valueOf(lineItem.Quantity));
                }
            }
            tempListOfQuantity.sort();
            opp.Sum_of_TotalPrice__c = tempTotalPrice;
            opp.sum_of_UnitPrice__c = tempTotalUnitPrice;
            opp.Maximum_Quantity__c = tempListOfQuantity[tempListOfQuantity.size()-1];
            opp.minimum_Quantity__c = tempListOfQuantity[0];
        }
    }
}