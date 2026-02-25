public class NewCaseListController {
    public List<Case> getNewCases(){
        List<Case> CaseListInnstance = new List<Case>();
        CaseListInnstance = [select Id,CaseNumber from Case where status='New'];
        return CaseListInnstance;
    }
}