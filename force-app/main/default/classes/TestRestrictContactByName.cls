@isTest
public class TestRestrictContactByName {
    @isTest static void restrict(){
        Contact con = new Contact();
        con.LastName = 'INVALIDNAME';
        try{
            Test.startTest();
            upsert con;
            Test.stopTest();
        }catch(Exception e){
            System.assert(e.getMessage().contains('The Last Name "'+con.LastName+'" is not allowed for DML'));
        }
        
    }
}