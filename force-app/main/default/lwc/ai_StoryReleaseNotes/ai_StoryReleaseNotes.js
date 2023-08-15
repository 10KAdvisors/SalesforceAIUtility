import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createReleaseNotes from '@salesforce/apex/AI_StoryReleaseNotesGenerator.createReleaseNotes';
import CompletedDateTime from '@salesforce/schema/Task.CompletedDateTime';

export default class AI_StoryReleaseNotes extends LightningElement {
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
                    message: 'Your assistant is writing the release notes. You will receive a notification when the assistant is finished.',
                    variant: 'success'
                })
            );

        createReleaseNotes({
            storyId: this.recordId,
        })
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Your release notes have been created successfully! Please refresh the page.',
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