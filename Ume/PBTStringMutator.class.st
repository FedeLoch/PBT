Class {
	#name : 'PBTStringMutator',
	#superclass : 'PBTMutator',
	#category : 'Ume-Mutators',
	#package : 'Ume',
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
