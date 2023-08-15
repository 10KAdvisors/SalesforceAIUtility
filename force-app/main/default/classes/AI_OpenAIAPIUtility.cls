public with sharing class AI_OpenAIAPIUtility {
    
    @AuraEnabled
    public static AI_GPTResponseWrapper processGPTChat(String systemRole, String userContent, String endpoint, String bearerToken, String model) {
        
        //Build up the body of the request
        AI_GPTRequestWrapper requestWrapper = new AI_GPTRequestWrapper(systemRole, userContent, model);
        
        //Send the body to the Chat GPT API
        String gptResponse = callOpenAIAPI(JSON.serialize(requestWrapper), endpoint, bearerToken).getBody().replace('\\n', '<br/>');

        //Parse the response into an Apex structure we can work with it easily
        AI_GPTResponseWrapper responseWrapper = AI_GPTResponseWrapper.parse(gptResponse);
        
        return responseWrapper;
    }

    private static HttpResponse callOpenAIAPI(String req, String endpoint, String bearerToken) {
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + bearerToken);
        request.setTimeout(120000);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(req);
       
        //Call out and then replace the reserved word "object" so our parsing will work properly
        HttpResponse callGPT = http.send(request);
        callGPT.setBody(callGPT.getBody().replace('"object"', '"objectname"'));
        return callGPT;
    }
}