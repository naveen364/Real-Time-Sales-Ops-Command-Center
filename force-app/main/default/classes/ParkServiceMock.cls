@isTest
global class ParkServiceMock implements WebServiceMock {
	global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
               List<String> str = new List<String>();
               //(Hamburg Wadden Sea National Park, Hainich National Park, Bavarian Forest National Park)
               str.add('Hamburg Wadden Sea National Park');
               str.add('Hainich National Park');
               str.add('Bavarian Forest National Park');
        response_x.return_x = str;
        // end
        response.put('response_x', response_x); 
   }
}