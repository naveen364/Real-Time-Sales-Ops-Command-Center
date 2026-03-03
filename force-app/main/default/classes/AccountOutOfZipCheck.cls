public class AccountOutOfZipCheck {
    public static boolean var = True;
    public static void zip(Map<Id,Account> mapold,Map<Id,Account> mapnew){
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        conlist = [select Id,AccountId,MailingPostalCode,OtherPostalCode from Contact where AccountId != null];
        acclist = [select Id,Out_of_Zip__c,Name from Account];
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        System.debug('mapcon'+mapcon);
        for(Account acc : acclist){
            if(mapold.containskey(acc.Id)){
                System.debug('mapold'+mapold);
                System.debug('AccountName'+acc.Name);
                //acc.BillingStreet
                System.debug('mapbill'+mapold.get(acc.Id).BillingStreet +':'+mapnew.get(acc.Id).BillingStreet);
                String oldBill = mapold.get(acc.Id).BillingStreet;
                String newBill = mapnew.get(acc.Id).BillingStreet;
                if(oldBill != newBill){
                    System.debug('AccountName'+acc.Name);
                    if(mapcon.containskey(acc.Id)){
                        for(Contact con : mapcon.get(acc.Id)){
                            String postalnew = mapnew.get(acc.Id).BillingPostalCode;
                            if(postalnew != con.MailingPostalCode){
                                acc.Out_of_Zip__c =true;
                                System.debug('acc.Out_of_Zip__c'+acc.Out_of_Zip__c);
                            }
                        }
                    }
                }
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
}