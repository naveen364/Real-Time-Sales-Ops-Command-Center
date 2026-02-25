public class OpportunityTotalMinMaxSumFromOli {
    public static void answer(){
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,Sum_of_TotalPrice__c,sum_of_UnitPrice__c,minimum_Quantity__c,Maximum_Quantity__c from Opportunity];
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        olilist = [select Id,OpportunityId,Quantity,UnitPrice,TotalPrice from OpportunityLineItem where OpportunityId != null];
        Map<Id,List<OpportunityLineItem>> mapoli = new  Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem oli : olilist){
            if(!mapoli.containsKey(oli.OpportunityId)){
                mapoli.put(oli.OpportunityId,new List<OpportunityLineItem>{oli});
            }else{
                mapoli.get(oli.OpportunityId).add(oli);
            }
        }
        Decimal temptotal,tempunit,tempmin,tempmax = null;
        System.debug('Mapoli'+mapoli);
        for(Opportunity opp : opplist){
            if(mapoli.containskey(opp.Id)){
                for(OpportunityLineItem oli : mapoli.get(opp.Id)){
                    if(temptotal == null && tempunit == null && tempmin == null && tempmax == null){
                        temptotal = oli.TotalPrice;
                        tempunit = oli.UnitPrice;
                        tempmin = oli.Quantity;
                        tempmax = oli.Quantity;
                        //System.debug('not xyz');
                    }else{
                        //System.debug('xyz');
                        if(opp.Sum_of_TotalPrice__c == null){
                            opp.Sum_of_TotalPrice__c = temptotal;
                        }
                        if(opp.Sum_of_TotalPrice__c != null){
                            opp.Sum_of_TotalPrice__c += oli.TotalPrice;
                        }
                        if(opp.sum_of_UnitPrice__c == null){
                            opp.sum_of_UnitPrice__c = tempunit;
                        }
                        if(opp.sum_of_UnitPrice__c != null){
                            opp.sum_of_UnitPrice__c +=oli.UnitPrice;
                        }
                        if(opp.minimum_Quantity__c == null){
                            opp.minimum_Quantity__c = tempmin;
                        }
                        if(opp.minimum_Quantity__c > oli.Quantity && opp.minimum_Quantity__c != null){
                             opp.minimum_Quantity__c = oli.Quantity;   
                        }
                        if(opp.Maximum_Quantity__c == null){
                            opp.Maximum_Quantity__c = tempmax;
                        }
                        if(opp.Maximum_Quantity__c < oli.Quantity && opp.Maximum_Quantity__c != null){
                             opp.Maximum_Quantity__c = oli.Quantity;   
                        }
                    }
                }
                System.debug('opp.sum_of_UnitPrice__c'+opp.sum_of_UnitPrice__c);
                System.debug('Sum_of_TotalPrice__c'+opp.Sum_of_TotalPrice__c);
                System.debug('minimum_Quantity__c'+opp.minimum_Quantity__c);
                System.debug('opp.Maximum_Quantity__c'+opp.Maximum_Quantity__c);
                //System.debug('opp.sum_of_UnitPrice__c'+opp.sum_of_UnitPrice__c);
            }
        }
        if(!opplist.isEmpty()){
        	update opplist;
        }
        System.debug('list'+opplist);
    }
}