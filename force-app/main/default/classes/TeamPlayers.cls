public class TeamPlayers {
    public static void play(){
        List<Player__c> plyrlist = new List<Player__c>();
        List<Playing_Eleven__c> plyelelist = new List<Playing_Eleven__c>();
        Team__c team = new Team__c();
        team.Country__c = 'India';
    	team.Name = 'LD Royals';
        insert team;
        for(Integer i = 1; i<=12;i++){
            Player__c plyr = new Player__c();
            plyr.Name = 'player'+i;
            plyr.Jersey_Number__c = i;
            if(i<3){
            	plyr.Type__c = 'Batsman';
            }else if(i>3 && i<7){
                plyr.Type__c = 'Bowler';
            }else if(i>7 && i<9){
                plyr.Type__c = 'WicketKeeper';
            }else if(i>9 && i<12){
                plyr.Type__c = 'All Rounder';
            }else{
                plyr.Type__c = '12th Man';
            }
            plyrlist.add(plyr);
        }
        if(!plyrlist.isEmpty()){
            insert plyrlist;
        }
        Boolean cap = true;
        for(Player__c ply : plyrlist){
            Playing_Eleven__c plyEle = new Playing_Eleven__c();
            plyEle.Player__c = ply.Id;
            plyEle.Team__c = team.Id;
            if(cap){
                plyEle.isCaptain__c = True;
                cap = false;
            }
            plyelelist.add(plyEle);
        }
        if(!plyelelist.isEmpty()){
            insert plyelelist;
        }
        
    }
}