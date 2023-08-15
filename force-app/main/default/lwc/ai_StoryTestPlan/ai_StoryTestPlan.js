import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createTestPlan from '@salesforce/apex/AI_StoryTestPlanGenerator.createTestPlan';
import CompletedDateTime from '@salesforce/schema/Task.CompletedDateTime';

export default class ai_StoryTestPlan extends LightningElement {
    isExecuting = false;
    _recordId;

    @api set recordId(value) {
        this._recordId = value;
    }
    
    get recordId() {
        return this._recordId;
    }

    @api async invoke() {
       if (this.isExecuting) {
            return;
        }
        this.isExecuting = true;

        this.dispatchEvent(
            new ShowToastEvent({
                    title: 'Processing...',
                    message: 'Your assistant is writing the test plan. You will receive a notification when the assistant is finished.',
                    variant: 'success'
                })
            );

        createTestPlan({
            storyId: this.recordId,
        })
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Your test plan have been created successfully! Please refresh the page.',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });

        this.isExecuting = false;
    }
}