public class AccRelateContactCreate {
    @AuraEnabled
    public static Account insertAccCon(String Name, Integer Num){
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        Account acc1 = new Account(Name = Name);
        acclist.add(acc1);
        insert acclist;
        System.debug('::8 acc'+acclist);
        for(Account acc : acclist){
            for(Integer i=0;i<Integer.valueOf(Num);i++){
                conlist.add(new Contact(LastName = Name,AccountId = acc.Id));
                System.debug('::12 inside for loop contact'+conlist);
            }
        }
        insert conlist;
        return acc1;
    }
}