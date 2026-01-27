Class {
	#name : 'PBTCaseFeedback',
	#superclass : 'PBTFeedback',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTCaseFeedback >> absoluteImprovement [
	
	^ self values values sum
]

{ #category : 'as yet unclassified' }
PBTCaseFeedback >> argumentFeedbackCase: index [
	
	^ PBTFeedback from: (case arguments at: index) improvement: improvement values: values
]

{ #category : 'as yet unclassified' }
PBTCaseFeedback >> receiverFeedback [

	^ PBTFeedback from: case receiver improvement: improvement values: values
]
