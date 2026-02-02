Class {
	#name : 'UmeStringMutator',
	#superclass : 'UmeMutator',
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
UmeStringMutator >> applyMutation: target [

	self subclassResponsibility 

]

{ #category : 'accessing' }
UmeStringMutator >> mutate: string [
	
	| target |
	
	target := string class = UmeRegex ifTrue: [ string regexString ] ifFalse: [ string ].
		
	^ self applyMutation: target
]
