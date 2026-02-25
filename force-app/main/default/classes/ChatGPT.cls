public with sharing class ChatGPT {
    @AuraEnabled
    public static Map<String,Object> getResponse(String endpoint, String prompt) {
        Map<String,Object> requestBody = new Map<String,Object>();
        requestBody.put('prompt', prompt);
        requestBody.put('n', 5);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', 'Bearer sk-PLACEHOLDER');
        //sk-PLACEHOLDER
        request.setBody(JSON.serialize(requestBody));
        HttpResponse response = http.send(request);
        Map<String,Object> json = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        return json;
    }
}