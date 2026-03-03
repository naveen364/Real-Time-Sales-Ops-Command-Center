public class AttachmentRelatedAccCon {
    public static void attach(){
        List<Attachment> attlist = new List<Attachment>();
        List<Contact> conlist = new List<Contact>();
        List<Attachment> listofatt = new List<Attachment>();
        conlist = [select Id,AccountId from Contact];
        attlist = [select Name,Id,ParentId from Attachment ];
        for(Contact con : conlist){
            for(Attachment att : attlist){
                if(att.ParentId == con.AccountId){
                    Attachment at = att.clone();
                    at.ParentId = con.Id;
                    at.Name = att.Name+'copy';
                    at.Body = Blob.valueOf(at.Name);
                    listofatt.add(at);
                    System.debug(att.Name);
                }
        	}
        }
        
    }
    public static void attach2(){
        Map<Id,List<Attachment>> mapsatt = new Map<Id,List<Attachment>>();//<accountid,attachmentslist>
        Map<Id,List<Contact>> mapscon = new Map<Id,List<Contact>>();//<accountid,contactlist>
        List<Attachment> attlist = new List<Attachment>();
         List<Attachment> listatt = new List<Attachment>();
        List<Contact> conlist = new List<Contact>();
        List<Account> acclist = new List<Account>();
        acclist = [select Id,Name from Account];
        attlist = [select ParentId,Name from Attachment where ParentId in :acclist];
        conlist = [select AccountId from Contact where AccountId in :acclist And AccountId != null];
        //System.debug(attlist);
        for(Attachment atts:attlist){
            if(!mapsatt.containsKey(atts.ParentId)){
                List<Attachment> listattach = new List<Attachment>();
                listattach.add(atts);
                mapsatt.put(atts.ParentId,listattach);
            }else{
               	List<Attachment> listattach = new List<Attachment>();
                listattach = mapsatt.get(atts.ParentId);
                listattach.add(atts);
                mapsatt.put(atts.ParentId,listattach);
            }
        }
        for(Contact con :conlist){
            if(!mapscon.containsKey(con.AccountId)){
                List<Contact> listcon = new List<Contact>();
                listcon.add(con);
                mapscon.put(con.AccountId,listcon);
            }else{
                List<Contact> listcon = new List<Contact>();
                listcon = mapscon.get(con.AccountId);
                listcon.add(con);
                mapscon.put(con.AccountId,listcon);
            }
        }
        for(Attachment att : attlist){
                for(Contact c : mapscon.get(att.ParentId)){
                    if(mapsatt.containskey(att.ParentId)){
                        for(Attachment at2 : mapsatt.get(att.ParentId)){
                            Attachment at = at2.clone();
                            at.ParentId = c.Id;
                            at.Name = at2.Name+'copy';
                            at.Body = Blob.valueOf(at.Name);
                            System.debug(at.Name+ ' : '+c.Id);
                        } 
                    }
                } 
        }
        //System.debug(mapsatt);
        //sSystem.debug(mapscon);
    }
    
}