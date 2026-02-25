public class FinancialAccClass {
    public static void finAcc(){
        List<Receivables__c> reclist = new List<Receivables__c>();
        List<Financial_Account__c> finlist = new  List<Financial_Account__c>();
        reclist = [select Id,Financial_Account__c,Total_Fees__c,Name from Receivables__c where Financial_Account__c != null];
        finlist = [select Id,Total_Fees__c,Name from Financial_Account__c];
        for(Financial_Account__c fin : finlist){
            for(Receivables__c rec : reclist){
                if(fin.Id == rec.Financial_Account__c){
                    fin.Total_Fees__c = fin.Total_Fees__c == null? rec.Total_Fees__c : fin.Total_Fees__c + rec.Total_Fees__c;
                }
            }
            System.debug('fintotal : '+fin.Total_Fees__c+'==>'+fin.Name);
        }
    }
}