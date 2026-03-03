public class LeadWithOliAndPro {
    public static void lead(List<Lead> triggerlist){
        List<Lead> leadlist = new List<Lead>();
       	List<Product2> prolist = new List<Product2>();
        List<Opportunity> opplist = new List<Opportunity>();
        Pricebook2 pb= [select Id from Pricebook2 where IsStandard = true Limit 1];
        List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
        Map<Id,List<Product2>> mappro = new Map<Id,List<Product2>>();
        leadlist = [select Id,Product__c,Name from Lead where Id In :triggerlist];
        prolist = [select Id,Lead__c from Product2 where Lead__c In :leadlist];
        System.debug('leadlist'+leadlist);
        System.debug('prolist'+prolist);
        for(Product2 pro : prolist){
            if(!mappro.containskey(pro.Lead__c)){
                mappro.put(pro.Lead__c,new List<Product2>{pro});
            }else{
                mappro.get(pro.Lead__c).add(pro);
            }
        }
        System.debug('Mappro'+mappro);
        
        for(Lead ld : leadlist){
            if(mappro.containskey(ld.Id)){
                Opportunity opp = new Opportunity();
                opp.StageName = 'Closed Won';
                opp.Name = ld.Name+'opp';
                opp.CloseDate = Date.today()+60;
                opplist.add(opp);
                insert opp;
                for(Integer i = 0;i<mappro.get(ld.Id).size();i++){
                    OpportunityLineItem oli =new OpportunityLineItem();
                   	oli.OpportunityId = opp.Id;
                    oli.Quantity = 1;
                    oli.TotalPrice = 10;
                    PricebookEntry pbe = new PricebookEntry();
                    pbe.Pricebook2Id =pb.Id;
                    pbe.Product2Id = mappro.get(ld.Id)[i].Id;
                    pbe.UnitPrice = 12;
                    pbe.IsActive =true;
                    insert pbe;
                    oli.PricebookEntryId = pbe.Id;
                    oli.Product2Id = mappro.get(ld.Id)[i].Id;
                    olilist.add(oli);
                }
            }
        }
        if(!olilist.isEmpty()){
            insert olilist;
        }
        System.debug('olist'+olilist);
    }
}