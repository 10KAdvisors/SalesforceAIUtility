@IsTest
public with sharing class AI_MockHttpResponseGenerator implements HttpCalloutMock {
    
    public static final String MODEL_GPT_3_5_TURBO = 'gpt-3.5-turbo';
    public static final String MODEL_GPT_3_5_TURBO_16K = 'gpt-3.5-turbo-16k';
    public static final String MODEL_GPT_4 = 'gpt-4';
    public static final String MODEL_GPT_4_32K = 'gpt-4-32k';
    
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        String reqBody = req.getBody();
        
        //Handle the various GPT cases with a specific response structure that they use
        if(reqBody.contains(MODEL_GPT_3_5_TURBO) || reqBody.contains(MODEL_GPT_3_5_TURBO_16K) || reqBody.contains(MODEL_GPT_4) || reqBody.contains(MODEL_GPT_4_32K)) {
            res.setBody('{ "id": "chatcmpl-7aOL5p0HfupSCsy3Bg7uOcmtULY9W", "objectname": "chat.completion", "created": 1688907723, "model": "gpt-3.5-turbo-0613", "choices": [ { "index": 0, "message": { "role": "assistant", "content": "I\'m sorry, but I cannot provide information about specific treasure locations as they may be fictional, illegal, or unethical to pursue." }, "finish_reason": "stop" } ], "usage": { "prompt_tokens": 12, "completion_tokens": 26, "total_tokens": 38 }, "error": { "message": "Additional properties are not allowed (\'cntent\' was unexpected) - \'messages.0\'", "type": "invalid_request_error", "param": null, "code": null }}');
        }

        return res;
    }
}