public class Agify {
    
    @AuraEnabled
    public static AgeApi getAgePrediction(String Names){
        AgeApi apiresult = new AgeApi();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.agify.io/?name='+Names);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            apiresult = (AgeApi)JSON.deserialize(response.getBody(),AgeApi.class);
            system.debug('apiresult>>'+apiresult);
            return apiresult;
        } else {
            throw new AuraHandledException('Error from Agify API: ' + response.getStatus());
        }
    }
    
    public class AgeApi{
        @AuraEnabled
        public String name { get; set;}
        @AuraEnabled
        public String age { get; set;}
        @AuraEnabled
        public String count {get; set;}
    }

}