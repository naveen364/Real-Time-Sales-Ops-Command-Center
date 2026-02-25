public class listofaccTest {
    @AuraEnabled
    public static List<account> listofacc(){
        return [select Id,name from Account where Id In (select AccountId from Contact where AccountId != null) limit 50];
    }
    @AuraEnabled
    public static Map<Id,List<Contact>> childs(){
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        List<Contact> conlist = new List<Contact>();
        conlist = [select Id,AccountId,LastName from Contact where AccountId In :listofacc()];
        System.debug('conlist==>'+conlist);
        
        for(Contact con : conlist){
            if(!mapcon.containsKey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
                System.debug('inside');
            }else{
                mapcon.get(con.AccountId).add(con);
                System.debug('inside else');
            }
        }
        
        system.debug(mapcon);
        return mapcon;
    }
}