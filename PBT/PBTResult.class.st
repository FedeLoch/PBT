Class {
	#name : 'PBTResult',
	#superclass : 'Object',
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'as yet unclassified' }
PBTResult class >> resultFrom: tests since: time [

	^ self new computeResult: tests since: time; yourself
]

{ #category : 'as yet unclassified' }
PBTResult >> computeResult: tests since: time [
	
	| totalTime |
	totalTime := Time millisecondsSince: time.

	" TODO: Implement me"
]
