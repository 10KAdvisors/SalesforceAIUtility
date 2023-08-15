public with sharing class AI_GPTRequestWrapper {

    private static final String ROLE_SYSTEM = 'system';
    private static final String ROLE_USER = 'user';

    public String model;
	public List<Message> messages;

	public class Message {
		public String role;
		public String content;

        public Message (String role, String content) {
            this.role = role;
            this.content = content;
        }
	}

    public AI_GPTRequestWrapper(String systemRole, String userContent, String model) {
        this.model = model;

        this.messages = new List<Message>();

        if(String.isNotBlank(systemRole)) {
            this.messages.add(new Message(ROLE_SYSTEM, systemRole));
        }

        this.messages.add(new Message(ROLE_USER, userContent));
    }

    /*
    Here's an example of a request to the OpenAI GPT API. The system message is optional if you want to assign a certain persona to the AI.

    {
        "model":"gpt-3.5-turbo",
        "messages":[
            {
                "role": "system","content": "You are a helpful AI assistant"
            },
            {
                "role": "user","content": "What is the meaning of life?"
            }
        ]
    }
    */
}