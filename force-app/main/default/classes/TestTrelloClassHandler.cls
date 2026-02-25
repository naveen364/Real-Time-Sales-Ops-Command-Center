@isTest
public class TestTrelloClassHandler {
    @testSetup static void createData(){
        List<Trello__c> trellolist = new List<Trello__c>();
        List<Contact> conlist = new List<Contact>();
        for(Integer i = 0; i<= 10;i++){
            Contact con = new Contact();
            con.LastName = 'Test'+i;
            conlist.add(con);
        }
        insert conlist;
        for(Contact con : conlist){
            Trello__c tr = new Trello__c();
            tr.Name = 'ertyui';
            tr.Contact__c = con.Id;
            trellolist.add(tr);
        }
        insert trellolist;
    }
    testMethod static void case1(){
        List<Trello__c> trellolist = new List<Trello__c>();
        List<Contact> conlist = new List<Contact>();
        trellolist = [select Id from Trello__c];
        conlist = [select Id from Contact];
        if(checkRecursion.runOnce()){
            Test.startTest();
            upsert trellolist;
            Test.stopTest();
        }
    }
}