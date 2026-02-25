/*"Create 3 custom objects:  
Continents, Countries, States
and Countries have lookup to continents and States have lookup to countries.
create 3 custom number fields on each object:
1. totalcountries on continent
2. totalstates on countries
3. population on states

Print the continents that has highest countries.

Print in descending order.
E.g->
continents  Countries 
Asia                   50          
Europe               20          */
public class ThreeContinentHighestCountries {
    //with aggrigate
    public static void bestanwer(){
        List<AggregateResult> agr = new List<AggregateResult>();
        agr = [select Continents__r.Name,count(id) from Countries__c group by Continents__r.Name order by count(id) desc limit 200];
    	System.debug('agr=>'+agr);
    }
    //without aggrigate
    public static void answer(){
        List<Countries__c> countrilist = new List<Countries__c>();
        countrilist = [select Id,Name,Continents__c,totalstates__c,Continents__r.totalcountries__c from Countries__c limit 50000];
        Map<Id,List<Countries__c>> mapOfCountriesWithContinent = new Map<Id,List<Countries__c>>();
        
        List<Continents__c> continentList = new List<Continents__c>();
        continentList = [select Id,Name from Continents__c limit 50000];

        for(Countries__c country : countrilist){
            if(!mapOfCountriesWithContinent.containsKey(country.Continents__c)){
                mapOfCountriesWithContinent.put(country.Continents__c,new List<Countries__c>{country});
            }else{
                mapOfCountriesWithContinent.get(country.Continents__c).add(country);
            }
        }
        
        Map<String,Integer> mapsort = new Map<String,Integer>();
        
        for(Continents__c continent : continentList){
            if(mapOfCountriesWithContinent.containsKey(continent.id)){
                if(!mapsort.containskey(continent.Name)){
                    mapsort.put(continent.Name,mapOfCountriesWithContinent.get(continent.id).size());
                }
                System.debug(continent.Name+'\t'+mapOfCountriesWithContinent.get(continent.id).size());
            }
        }
        //mapsort by bubblesort
        System.debug('map=>'+mapsort.values());
        List<Integer> listofNum = new List<Integer>();
        listofNum.addAll(mapsort.values());
        List<String> listofKey = new List<String>();
        listofKey.addAll(mapsort.Keyset());
        Integer temp;
        String tempId;
        for(Integer i = 0; i<listofNum.size();i++){
            for(Integer j =1;j<listofNum.size()-i;j++){
                if(listofNum[j-1]<listofNum[j]){
                    temp = listofNum[j-1];
                    listofNum[j-1] =listofNum[j];
                    listofNum[j] =temp;
                    tempId = listofKey[j-1];
                    listofKey[j-1] =listofKey[j];
                    listofKey[j] = tempId;
                }
            }
        }
        System.debug('Continents \t Countries');
        for(Integer i = 0; i<listofNum.size();i++){
            System.debug(listofKey[i]+' \t '+listofNum[i]);
        }
    }
}