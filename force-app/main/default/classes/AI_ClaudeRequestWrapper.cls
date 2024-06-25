public with sharing class AI_ClaudeRequestWrapper {
    public AI_ClaudeRequestWrapper() {

    }
}



public with sharing class AI_ClaudeRequestWrapper {

    private static final String ROLE_ASSISTANT = 'assistant';
    private static final String ROLE_USER = 'user';

    public String model;
    public String maxTokens;
    public String system;
	public List<Message> messages;

	public class Message {
		public String role;
		public String content;

        public Message (String role, String content) {
            this.role = role;
            this.content = content;
        }
	}

    public AI_ClaudeRequestWrapper(String model, String maxTokens, String system, String role) {
        
        this.model = model;
        this.maxTokens = maxTokens;
        this.system = system;

        this.messages.add(new Message(ROLE_USER, userContent));
    }

    /*
    Here's an example of a request to the Anthropic Claude.ai API. The system message is optional if you want to assign a certain persona to the AI.

    {
        "model": "claude-3-opus-20240229",
        "max_tokens": 1024,
        "system": "You are a helpful Salesforce product manager",
        "messages": [
            {"role": "user", "content": "Hello there."},
            {"role": "assistant", "content": "Hi, I'm Claude. How can I help you?"},
            {"role": "user", "content": "Can you explain LLMs in plain English?"}
        ]
    }
    */
}