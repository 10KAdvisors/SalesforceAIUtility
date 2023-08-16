<a href="https://githubsfdeploy.herokuapp.com?owner=10KAdvisors&repo=SalesforceOpenAIUtility&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

# Salesforce Open AI Utility

## Getting Started

We've created a lightweight utility that makes it a breeze to get started with OpenAI and ChatGPT from within Salesforce. A few quick steps to get going:

1. First, be sure to register your own account with OpenAI, and get an API key (https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key)
2. Install the utility with the Deploy to Salesforce
3. Update your API Key within the 'OpenAI AI Setting' custom metadata type records

After that, you'll be able to use the 'Generate Release Notes' and 'Generate Test Plan' actions on the included Story custom object. We included these as examples to show how the function works end to end.

## Make It Your Own

Once you get the included functions working, leveraging the underlying utility in your own ways is easy. There are two main classes you'll want to use, depending on what you're doing.

- **AI_OpenAIAPIUtility.cls** - If you're working in Apex, you can call the AI_OpenAIAPIUtility.processGPTChat() method directly
  - You'll need to pass in a few parameters:
    - **systemRole** - The role you want the AI to assume for this particular request. If you don't pass anything it will default to the standard GPT persona.
    - **userContent** - The content you want to feed into the AI.
    - **endpoint** - Which OpenAI API endpoint you want to use, e.g. https://api.openai.com/v1/chat/completions
    - **bearerToken** - Your OpenAI API key
    - **model** - Which OpenAI API model you want to utilize, e.g. gpt-3.5-turbo-16k or gpt-4-32k
  - Currently we're storing most of these items in the OpenAI API Setting custom metadata type records, and then reading those in depending on which function is being used. Check the AI_StoryTestPlanGenerator.cls or AI_StoryReleaseNotesGenerator.cls classes for examples.
 
- **AI_OpenAIFlowUtility.cls** - Utilize this class if you want to work with the OpenAI API from Flow.
  - We don't have an example of this included at the moment (stay tuned!), but there are two core inputs:
    - **systemRole** - The role you want the AI to assume for this particular request. If you don't pass anything it will default to the standard GPT persona.
    - **userContent** - The content you want to feed into the AI.
   
Enjoy!
