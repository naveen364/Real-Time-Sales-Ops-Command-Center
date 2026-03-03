public class TrelloClassHandler {
    public static boolean var = False;
    public static void handler(List<Trello__c> triggerlist){
        Map<Id,String> mapcon = new Map<Id,String>();
        List<Contact> conlist = new List<Contact>();
        List<Trello__c> trellolist = new List<Trello__c>();
        conlist = [select Id,LastName from Contact];
        trellolist = [select Id,Contact__c,Name from Trello__c where Id In :triggerlist];
        for(Contact con : conlist){
            if(!mapcon.containsKey(con.Id)){
                mapcon.put(con.Id,con.LastName);
            }
        }
        
        System.debug('map'+mapcon);
        for(Trello__c t : trellolist){
            t.Name = mapcon.get(t.Contact__c);
            System.debug('t.Name'+t.Name);
        }
        if(!trellolist.isEmpty()){
            update trellolist;
           
        }
    }
}