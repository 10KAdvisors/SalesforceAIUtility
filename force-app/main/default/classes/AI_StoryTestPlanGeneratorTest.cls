@IsTest
private with sharing class AI_StoryTestPlanGeneratorTest {
        
    @testSetup public static void setupData() {
        //Create a Story
        List<Story__c> storyList = new List<Story__c>();
        storyList.add(new Story__c(Name = 'This is a test story', Description__c = 'This is a description of the test story'));
        insert storyList;
    }
    
    @isTest
    static void testCreateTestPlan() {
       
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new AI_MockHttpResponseGenerator());
            List<Story__c> storyList = [SELECT Id, Assistant_Generated_Release_Notes__c FROM Story__c];        
            
            //Generate the release notes
            AI_StoryTestPlanGenerator.createTestPlan(storyList[0].Id);
        Test.stopTest();
        
        // Query the updated story record
        Story__c updatedStory = [SELECT Id, Assistant_Generated_Test_Plan__c FROM Story__c WHERE Id =: storyList[0].Id];
        
        // Verify that the Assistant_Generated_Release_Notes__c field has been updated
        Assert.areNotEqual(null, updatedStory.Assistant_Generated_Test_Plan__c);        
    }
}