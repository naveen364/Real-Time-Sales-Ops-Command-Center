public class accountoppattach {
    /*
Write a script to get all Account those are associated with opportunity and put the attachment 
from account to their opportunity. If the account does not have attachment put opportunity close lost otherwise close won.
*/
    public static void attach2(){
        List<Attachment> attlist = new List<Attachment>();
        attlist = [select Id,ParentId,Name from Attachment where ParentId In (select Id from Account)];
        //List<Account> acclist = new List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        opplist = [select Id,AccountId from Opportunity where AccountId != null];
        for(Opportunity opp : opplist){
            for(Attachment att : attlist){
                if(att.ParentId == opp.AccountId){
                    opp.StageName = 'Closed Won';
                    Attachment at = new Attachment();
                    at =att.clone();
                    at.ParentId = opp.Id;
                    at.Body = Blob.valueOf(att.Name);
                    at.Name = att.Name+'copy forloop';
                    insert at;
                    update opp;
                }else{
                    opp.StageName = 'Closed Lost';
                    update opp;
                }
            }
        }
    }
}