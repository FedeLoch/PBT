Class {
	#name : 'PBTStringMutator',
	#superclass : 'PBTMutator',
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
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
