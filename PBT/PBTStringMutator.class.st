Class {
	#name : 'PBTStringMutator',
	#superclass : 'PBTMutator',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTStringMutator >> applyMutation: target [

	self subclassResponsibility 

]

{ #category : 'accessing' }
PBTStringMutator >> mutate: string [
	
	| target |
	
	target := string class = PBTRegex ifTrue: [ string regexString ] ifFalse: [ string ].
		
	^ self applyMutation: target
]
