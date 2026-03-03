//Find atleast 5 Account from your ORG having highest number of Contacts and It should be displayed in ascending order.
//Create a map to store number of contacts in key and list of associated contacts in value. If two Accounts having 
//the same number of Contacts then it should display only one Account among them(Accounts having same no. of Contacts)
public class HighestNoOfContact {
    public static void high(){
        Map<Id,List<Contact>> mapcon = new Map<Id,List<Contact>>();
        List<Contact> conlist = new List<Contact>();
        conlist = [select Id, AccountId from Contact where AccountId != null];
        for(Contact con : conlist){
            if(!mapcon.containskey(con.AccountId)){
                mapcon.put(con.AccountId,new List<Contact>{con});
            }else{
                mapcon.get(con.AccountId).add(con);
            }
        }
        
        List<Integer> valuelist = new List<Integer>();
        List<Id> keylist = new List<Id>();
        for(Id ids : mapcon.keySet()){
            valuelist.add(mapcon.get(ids).size());
            keylist.add(ids);
        }
        //Bubble Sort
        
        Integer temp = 0;
        Id keytemp;
        for(Integer i = 0; i< keylist.size();i++){
            for(Integer j = 1;j<keylist.size()-i;j++){
                if(valuelist[j-1]>valuelist[j]){
                    temp = valuelist[j-1];
                    valuelist[j-1] = valuelist[j];
                    valuelist[j] = temp;
                    keytemp = keylist[j-1];
                    keylist[j-1] = keylist[j];
                    keylist[j] = keytemp;
                }
            }
        }
        System.debug('key'+keylist);
        System.debug('value'+valuelist);
        for(Integer i = 0; i<keylist.size();i++){
            System.debug(keylist[i]+'==>'+valuelist[i]);
        }
        //sortlist.sort();
        //Set<Integer> s1 = new Set<Integer>(sortlist);
        //System.debug('sort==>'+s1);
    }
}