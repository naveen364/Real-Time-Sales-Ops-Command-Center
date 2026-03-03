public class ThreeCustomStatesCountriContinent {
    public static void answer(){
        List<Continents__c> continent = new List<Continents__c>();
        List<Continents__c> updatecont = new List<Continents__c>();
        continent = [select Id,totalcountries__c from Continents__c Order By totalcountries__c Desc limit 50000]; //highest countries
        List<Countries__c> countrilist = new List<Countries__c>();
        countrilist = [select Id,Name,Continents__c,totalstates__c,Continents__r.totalcountries__c from Countries__c where Continents__c In :continent Order By totalstates__c Desc limit 50000];
        List<States__c> statelist = new List<States__c>();
        statelist = [select Id,population__c,Countries__r.Name,Name from States__c where Countries__c In :countrilist Order by population__c Desc limit 50000];
        
        List<AggregateResult> agr = new List<AggregateResult>();
        agr = [select Max(totalcountries__c) from Continents__c];
        
        List<AggregateResult> agrmin = new List<AggregateResult>();
        agrmin = [select Min(totalcountries__c) from Continents__c];
        
        System.debug('agr.expr0 ==>'+agr[0].get('expr0'));

        List<Id> ListId = new List<Id>();
        set<Id> setId = new set<Id>();
        List<Decimal> totalstate = new List<Decimal>();
        for(States__c st : statelist){
                for(Countries__c count : countrilist){
                    if(count.Continents__r.totalcountries__c == agr[0].get('expr0') && st.Countries__c == count.Id){
                        System.debug('Name'+count.Name+':'+count.totalstates__c+':'+st.population__c);
                        if(!setId.contains(count.Id)){
                            setId.add(count.Id);
                            totalstate.add(count.totalstates__c);
                        }
                    }
                }
        }
        ListId.addall(setId);
        //bubble sort
        Decimal temp;
        Id tempId;
        for(Integer i = 0; i<totalstate.size();i++){
            for(Integer j =1;j<totalstate.size()-i;j++){
                if(totalstate[j-1]>totalstate[j]){
                    temp = totalstate[j-1];
                    totalstate[j-1] =totalstate[j];
                    totalstate[j] =temp;
                    tempId = ListId[j-1];
                    ListId[j-1] =ListId[j];
                    ListId[j] = tempId;
                }
            }
        }
       	System.debug('sortId'+ListId);
        System.debug('sorttotal'+totalstate);
        for(Countries__c count : countrilist){
            if(count.Id == ListId[0]){
                Continents__c conti = new Continents__c();
                conti.Name = count.Name;
                conti.totalcountries__c = (Decimal) agrmin[0].get('expr0');
                System.debug('Change from countrie to continent ==>'+conti.Name);
               	//insert conti;
            }
        }
        
    }
}