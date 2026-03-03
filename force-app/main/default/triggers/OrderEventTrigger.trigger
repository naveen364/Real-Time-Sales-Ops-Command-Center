trigger OrderEventTrigger on Order_Event__e (after insert) {
	List<Task> tasks = new List<Task>();
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            Task tk = new Task();
            tk.Priority = 'Medium';
            tk.Subject = 'Follow up on shipped order 105';
            tk.OwnerId = event.CreatedById;
            tasks.add(tk);
        }
   }
    insert tasks;
}