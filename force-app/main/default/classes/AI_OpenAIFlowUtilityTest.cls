@IsTest
public with sharing class AI_OpenAIFlowUtilityTest {
    
    @isTest
    static void testFlow() {
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new AI_MockHttpResponseGenerator());
            
            List<AI_OpenAIFlowUtility.InputVariable> inputVariableList = new List<AI_OpenAIFlowUtility.InputVariable>();
            AI_OpenAIFlowUtility.InputVariable inputVar = new AI_OpenAIFlowUtility.InputVariable();
            inputVar.systemRole = 'You are Blackbeard the pirate';
            inputVar.userContent = 'Where is all the treasure?';
            inputVariableList.add(inputVar);
            
            List<AI_OpenAIFlowUtility.ReturnVariable> returnVariableList = new List<AI_OpenAIFlowUtility.ReturnVariable>();
            returnVariableList = AI_OpenAIFlowUtility.processGPTChatFromFlow(inputVariableList);
        Test.stopTest();
    }
}