public class InvokableClassWithFuture {
	@InvocableMethod 
    public static void sendEmailToOwner(List<String> listUserNames) {
         System.debug('Hello::4');
        callEmailSend(listUserNames);
    }
    @future
    public static void callEmailSend(List<String> listUserNames) {
        System.debug('Hello::8');
        //Write the logic.
       //If it is a call out, use callout = true in future annoation
    }
}