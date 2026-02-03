Class {
	#name : 'UmeCaseFeedback',
	#superclass : 'UmeFeedback',
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
UmeCaseFeedback >> absoluteImprovement [
	
	^ self values values sum
]

{ #category : 'as yet unclassified' }
UmeCaseFeedback >> argumentFeedbackCase: index [
	
	^ UmeFeedback from: (case arguments at: index) improvement: improvement values: values
]

{ #category : 'as yet unclassified' }
UmeCaseFeedback >> receiverFeedback [

	^ UmeFeedback from: case receiver improvement: improvement values: values
]
