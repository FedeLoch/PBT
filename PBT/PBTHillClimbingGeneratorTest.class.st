Class {
	#name : 'PBTHillClimbingGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTHillClimbingGeneratorTest >> testGenerateARandomStringInputGuidedByMutationBaseCase [

	| generator |
	
	generator := PBTGenerator base: [ 'asdef' ] mutating: [ :value :constraint :feedback |
		             value
			             copyReplaceFrom: 5
			             to: 5
			             with: (value at: 5) asUppercase asString ].

	self assert: (generator gen: nil by: false) equals: 'asdeF'
]

{ #category : 'tests' }
PBTHillClimbingGeneratorTest >> testGenerateARandomStringInputGuidedByMutationWithNegativeFeedback [

	| generator |
	
	generator := PBTGenerator base: [ 'asdef' ] mutating: [ :value :constraint :feedback |
						| where |
						where := value last isUppercase ifTrue: [ 1 ] ifFalse: [ value size ].
		             value
			             copyReplaceFrom: where
			             to: where
			             with: (value at: where) asUppercase asString ].
		
	generator gen: nil by: false.

	self assert: (generator gen: nil by: false) equals: 'asdeF'
]

{ #category : 'tests' }
PBTHillClimbingGeneratorTest >> testGenerateARandomStringInputGuidedByMutationWithPositiveFeedback [

	| generator |
	
	generator := PBTGenerator base: [ 'asdef' ] mutating: [ :value :constraint :feedback |
						| where |
						where := value last isUppercase ifTrue: [ 1 ] ifFalse: [ value size ].
		             value
			             copyReplaceFrom: where
			             to: where
			             with: (value at: where) asUppercase asString ].
		
	generator gen: nil by: true.

	self assert: (generator gen: nil by: true) equals: 'AsdeF'
]
