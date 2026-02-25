public class EmployeeAndCompanyGenderCount {
    public static void genderCount(){
        List<Employee__c> emplist = new List<Employee__c>();
        List<Company__c> complist = new List<Company__c>();
        emplist = [select Id,Company__c,Gender__c from Employee__c where Company__c != null];
        Complist = [select Id,Male_Employee__c,Female_Employee__c from Company__c];
        Map<String,List<Employee__c>> mapOfCompanyAndEmp = new Map<String,List<Employee__c>>();
        for(Employee__c emp : emplist){
            if(!mapOfCompanyAndEmp.containsKey(emp.Company__c+'.'+emp.Gender__c)){
                mapOfCompanyAndEmp.put(emp.Company__c+'.'+emp.Gender__c,new List<Employee__c>{emp});
            }else{
                mapOfCompanyAndEmp.get(emp.Company__c+'.'+emp.Gender__c).add(emp);
                System.debug('::13 inside map key =>'+emp.Company__c+'.'+emp.Gender__c);
            }
        }
        System.debug('mapOfCompanyAndEmp==>'+mapOfCompanyAndEmp);
        for(Company__c comp : complist){
            String maleId = comp.Id+'.Male';
            String femaleId = comp.Id+'.Female';
            System.debug('::20 maleId==>'+maleId);
            System.debug('::21 femaleId==>'+femaleId);
            if(mapOfCompanyAndEmp.containskey(maleId)){
                comp.Male_Employee__c = mapOfCompanyAndEmp.get(maleId).size();
            }
            if(mapOfCompanyAndEmp.containskey(femaleId)){
               comp.Female_Employee__c = mapOfCompanyAndEmp.get(femaleId).size(); 
            }
        }
        if(!complist.isEmpty()){
            update complist;
        }
        System.debug('complist==>'+complist);
    }
}