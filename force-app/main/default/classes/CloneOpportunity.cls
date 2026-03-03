public class CloneOpportunity {
    public static void disp(){
      	Opportunity op = new Opportunity();
        op.Name='abxd';
        op.StageName = 'Prospecting';
        op.CloseDate = Date.today();
        insert op;
        Opportunity opclone = op.clone(false,false,false,false);
        opclone.Name = op.Name+'clone';
        opclone.CloseDate = Date.today()+30;
        insert opclone;
    }
    
}