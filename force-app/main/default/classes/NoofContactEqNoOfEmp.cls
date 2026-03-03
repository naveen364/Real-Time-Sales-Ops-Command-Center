public class NoofContactEqNoOfEmp {
    public static void updateAcc(List<Account> acclist, Map<Id,Account> maps){
        System.debug('acclist==>'+acclist);
        System.debug('maps==>'+maps);
        List<Contact> conlist = new List<Contact>();
        List<Contact> conlistformap = new List<Contact>();
        conlistformap = [select Id,Name,AccountId from Contact where AccountId In :acclist And AccountId != null];
        List<Contact> dellist = new List<Contact>();
        Map<Id,List<Contact>> mapconWithAcc = new Map<Id,List<Contact>>();
        for(Contact con : conlistformap){
            if(!mapconWithAcc.containsKey(con.AccountId)){
                mapconWithAcc.put(con.AccountId,new List<Contact>{con});
            }else{
                mapconWithAcc.get(con.AccountId).add(con);
            }
        }
        System.debug('mapconWithAcc==>'+mapconWithAcc);
        for(Account acc : acclist){
            Integer diff;
            if(acc.NumberOfEmployees > maps.get(acc.Id).NumberOfEmployees){
                diff = acc.NumberOfEmployees - maps.get(acc.Id).NumberOfEmployees;
                for(Integer i = 0; i<diff;i++){
                    Contact con = new Contact();
                    con.LastName = acc.Name+'Con'+i;
                    con.AccountId = acc.Id;
                    conlist.add(con);
            	}
            }
            else if(maps.get(acc.Id).NumberOfEmployees > acc.NumberOfEmployees){
                diff = maps.get(acc.Id).NumberOfEmployees - acc.NumberOfEmployees;
                System.debug('else if diff==>'+diff);
                List<Contact> oldconlist = new List<Contact>();
                oldconlist = mapconWithAcc.get(acc.Id);
                System.debug('oldconlist==>'+oldconlist);
                for(Integer i = 0; i< diff;i++){
                    dellist.add(oldconlist[i]);
                }
                System.debug(diff);
            }
        }
        if(!conlist.isEmpty()){
        	insert conlist;
        } 
        if(!dellist.isEmpty()){
        	delete dellist;
        }else{
            System.debug(dellist);
        } 
    }
    
}