public class leadlimithandler {
    public static void handler(List<Lead> triggerlist){
        List<Lead> leadlist,leadlist2 = new List<Lead>();
        List<User> userlist = new List<User>();
        userlist =[select Id from User];
        leadlist = [select Id,OwnerId,LastModifiedDate from Lead where Id In :triggerlist];
        leadlist2 = [select Id,OwnerId,LastModifiedDate from Lead];
        if(triggerlist.size()==1){
            leadlist = leadlist2;
        }
        System.debug('leadlist'+leadlist);
        Integer month = null;
        for(User u : userlist){
            Integer i = 0;
            month = null;
            for(Lead ld : leadlist){
                if(u.Id == ld.OwnerId){
                    if(month == null){
                        month = ld.LastModifiedDate.month();
                    }else{
                        if(ld.LastModifiedDate.month() == month){
                            i++;
                            System.debug('i'+i);
                        }
                    }
                }
                if(i>30){
                	ld.addError('you have cross the limit of change owner to user in this month');
                }
            }
        }
    } 
}