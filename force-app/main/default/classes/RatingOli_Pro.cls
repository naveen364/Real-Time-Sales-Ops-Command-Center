/*Create a Multi picklist field ""Rate"" [Values as 1 star, 2 stars, 3 stars, 4 stars, 5 stars] on Product2 and same Multi picklist field 
""Rate"" on Opportunitylineitem with the same value. Write a script to get all the Products which got less than 3 ratings in opportunity line 
items but the Product rate for those was 5 star*/
public class RatingOli_Pro {
    public static void rating(){
        List<Opportunitylineitem> olilist = new List<Opportunitylineitem>();
        olilist = [select Id,Name,rate__c,Product2.Name,Product2.rate__c from Opportunitylineitem where Product2.rate__c = ' 5 stars '];
        for(Opportunitylineitem oli : olilist){
            //oli.rate__c = ' 1 stars ; 2 stars ';
            //System.debug('oli '+oli.rate__c);
           	List<String> lstrate = oli.rate__c.split(';');
            System.debug('oli rate list '+lstrate);
            if(lstrate.size()<3){
                System.debug('product info==>'+oli.Product2.Name+' '+oli.Product2.rate__c);
            }
        }
        
    }
}