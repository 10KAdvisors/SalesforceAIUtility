public with sharing class AI_OpenAIFlowUtility {

    public class InputVariable {
        @InvocableVariable
        public String systemRole;

        @InvocableVariable
        public String userContent;
    }

    public class ReturnVariable {
        @InvocableVariable
        public String gptResponse;
    }
    
    @InvocableMethod(label='Call OpenAI Chat API' description='Return responses from the OpenAI Chat API based on user input')
    public static List<ReturnVariable> processGPTChatFromFlow(List<InputVariable> inputVariables) {
        
        OpenAIAPISetting__mdt settings = OpenAIAPISetting__mdt.getInstance('GPT_From_Flow');

        //Parse the inputs
        String systemRole = inputVariables.get(0).systemRole;
        String userContent = inputVariables.get(0).userContent;

        AI_GPTResponseWrapper gptResponse = AI_OpenAIAPIUtility.processGPTChat(systemRole, userContent, settings.Endpoint__c, settings.API_Key__c, settings.Model__c);

        List<ReturnVariable> returnVariableList = new List<ReturnVariable>();
        ReturnVariable returnVar = new ReturnVariable();
        if(gptResponse.isSuccess) {
            returnVar.gptResponse = gptResponse.choices[0].message.content;
        }
        else {
            returnVar.gptResponse = System.Label.AI_General_API_Error + ' ' + gptResponse.error.message;
        }
        
        returnVariableList.add(returnVar);

        return returnVariableList;
    }
}