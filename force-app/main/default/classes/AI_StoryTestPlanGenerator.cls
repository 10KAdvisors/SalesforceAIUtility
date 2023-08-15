public with sharing class AI_StoryTestPlanGenerator {
    
    @AuraEnabled
    public static void createTestPlan(Id storyId) {
        
        AI_GPTResponseWrapper gptResponse = new AI_GPTResponseWrapper();
        
        //Fetch the custom metadata record that controls this function
        OpenAIAPISetting__mdt settings = OpenAIAPISetting__mdt.getInstance('Story_Test_Plan');

        //Get the story and feed the relevant data into the OpenAI API
        Story__c story = [SELECT Id, Name, Description__c, Assistant_Generated_Test_Plan__c
                          FROM Story__c 
                          WHERE Id = :storyId
                          WITH SECURITY_ENFORCED];

        gptResponse = AI_OpenAIAPIUtility.processGPTChat(settings.Default_System_Role__c,
                                                         settings.Default_User_Content__c + ' Story Name:' + story.Name + ', Description:' + story.Description__c,
                                                         settings.Endpoint__c,
                                                         settings.API_Key__c,
                                                         settings.Model__c);

        //If the callout to the OpenAI API was successful then update the data
        if((gptResponse.isSuccess && !Test.isRunningTest()) || Test.isRunningTest()) {
            story.Assistant_Generated_Test_Plan__c = gptResponse.choices[0].message.content;

            try {
                update story;
            }
            catch(DmlException dmlExc) {
                //@TODO - Log this exception
                
                throw new AuraHandledException(System.Label.AI_Story_Test_Plan_General_Error + ' ' + dmlExc.getMessage());
            }
        }
        else {
            //@TODO - Log this exception

            throw new AuraHandledException(System.Label.AI_General_API_Error + ' ' + gptResponse.error.message);
        }
    }
}