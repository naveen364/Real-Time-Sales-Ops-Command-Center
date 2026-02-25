public class BulkycodeForOCR {
    public static void ocr(){
        
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        List<Opportunity> opplist = new List<Opportunity>();
        
        acclist = [select Id,Name from Account where Name like 'ocrtest%'];
        List<Account> ListTOUpdate=new List<Account>();
        
        for(Account acc :acclist){
            Account aObject=new Account();
            aObject.id=acc.id;
            aObject.Name ='test';
            ListToUpdate.add(aObject);
        }
        if(!ListToUpdate.isEmpty()){
            update ListToUpdate;
        }
        
    }
}