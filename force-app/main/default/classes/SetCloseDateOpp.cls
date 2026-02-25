public with sharing class SetCloseDateOpp {
    @AuraEnabled
    public static void SetCloseDate(Id ids,Date clsdate) {
        Opportunity opp = new Opportunity();
        opp.Id = ids;
        opp.closeDate = clsdate;
        System.debug('opp'+opp.name);
        update opp;
    }
}