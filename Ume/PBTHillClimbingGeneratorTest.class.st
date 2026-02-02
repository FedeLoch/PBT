Class {
	#name : 'PBTHillClimbingGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTHillClimbingGeneratorTest >> testGenerateARandomStringInputGuidedByMutationBaseCase [

	| generator |
	
	generator := UmeGenerator base: [ 'asdef' ] mutating: [ :value :constraint :feedback |
		             value
			             copyReplaceFrom: 5
			             to: 5
			             with: (value at: 5) asUppercase asString ].

	self assert: (generator gen: nil) equals: 'asdeF'
]

{ #category : 'tests' }
PBTHillClimbingGeneratorTest >> testGenerateARandomStringInputGuidedByMutationWithNegativeFeedback [

	| generator |
	
	generator := UmeGenerator base: [ 'asdef' ] mutating: [ :value :constraint :feedback |
						| where |
						where := value last isUppercase ifTrue: [ 1 ] ifFalse: [ value size ].
		             value
			             copyReplaceFrom: where
			             to: where
			             with: (value at: where) asUppercase asString ].
		
	generator gen: nil.
	generator feed: (self feedback: false).

	self assert: (generator gen: nil) equals: 'asdeF'
]

{ #category : 'tests' }
PBTHillClimbingGeneratorTest >> testGenerateARandomStringInputGuidedByMutationWithPositiveFeedback [

	| generator |
	
	generator := UmeGenerator base: [ 'asdef' ] mutating: [ :value :constraint :feedback |
						| where |
						where := value last isUppercase ifTrue: [ 1 ] ifFalse: [ value size ].
		             value
			             copyReplaceFrom: where
			             to: where
			             with: (value at: where) asUppercase asString ].
		
	generator gen: nil.
	generator feed: (self feedback: true).

	self assert: (generator gen: nil) equals: 'AsdeF'
]
