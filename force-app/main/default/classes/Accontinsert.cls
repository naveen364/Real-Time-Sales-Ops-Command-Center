public class Accontinsert 
{
    

    @AuraEnabled
    public static void InsertMethod(string Apexname){
        list<account> listaccount = new list<account>();
        system.debug('IM IN APEX ++++ ');
        account ac = new account();
        ac.Name = Apexname;
        listaccount.add(ac);
        
        insert listaccount;
        
        
    }
    
    
    
}