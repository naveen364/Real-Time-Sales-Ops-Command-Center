public class BuildingFlat {
    public static void flat(){
        List<Flat__c> flatlist = new List<Flat__c>();
        List<Building__c> buildlist = new List<Building__c>();
        for(Integer i = 0; i<= 2; i++){
            Building__c build = new Building__c(Name = 'Metropolis'+i,Floor_No__c = i,No_of_units__c = String.valueOf(Math.round(Math.random()*10)));
            buildlist.add(build);
        }
        System.debug('::9 buildinglist ==>'+buildlist);
        Integer flatCode;
        for(Building__c build : buildlist){
            flatCode = (Integer) build.Floor_No__c *100;
            System.debug('::13 flatCode==>'+flatCode);
            Integer unit = Math.round(Integer.valueOf(build.No_of_units__c));
            System.debug('::15 unit==>'+unit);
            for(Integer j = 1;j<=unit;j++){
                Flat__c flat = new Flat__c();
                flat.Name = flatCode + j +' '+build.Name;
                flat.Building__c = build.Id;
                flatlist.add(flat);
                System.debug('Flat name ==>'+flat.Name);
            }
        }
        if(!flatlist.isEmpty()){
            insert flatlist;
        }
        
    }
}