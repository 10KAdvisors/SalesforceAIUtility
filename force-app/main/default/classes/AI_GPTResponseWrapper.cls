public with sharing class AI_GPTResponseWrapper {

	public String id;
	public String objectname;
	public Integer created;
	public String model;
	public List<Choice> choices;
	public Usage usage;
	public Error error;
    public Boolean isSuccess;
    
    public class Choice {
		public Integer index;
		public Message message;
		public String finish_reason;
	}

    public class Message {
		public String role;
		public String content;
	}

    public class Usage {
		public Integer prompt_tokens;
		public Integer completion_tokens;
		public Integer total_tokens;
	}

	public class Error {
		public String message;
		public String type;
		public String param;
		public String code;
	}
	
	public static AI_GPTResponseWrapper parse(String json) {
		AI_GPTResponseWrapper responseWrapper = (AI_GPTResponseWrapper) System.JSON.deserialize(json, AI_GPTResponseWrapper.class);        
        responseWrapper.isSuccess = (responseWrapper.error == null) ? true : false;
        return responseWrapper;
	}
}

/*

Here's a sample of what a combined response looks like. We'll either get a success (e.g. error will be null) or failure (e.g.
error will be the only thing not null) response from GPT

{
    "id": "chatcmpl-7aOL5p0HfupSCsy3Bg7uOcmtULY9W",
    "objectname": "chat.completion",
    "created": 1688907723,
    "model": "gpt-3.5-turbo-0613",
    "choices": [
        {
            "index": 0,
            "message": {
                "role": "assistant",
                "content": "I'm sorry, but I cannot provide information about specific treasure locations as they may be fictional, illegal, or unethical to pursue."
            },
            "finish_reason": "stop"
        }
    ],
    "usage": {
        "prompt_tokens": 12,
        "completion_tokens": 26,
        "total_tokens": 38
    },
    "error": {
        "message": "Additional properties are not allowed ('content' was unexpected) - 'messages.0'",
        "type": "invalid_request_error",
        "param": null,
        "code": null
    }
}


*/