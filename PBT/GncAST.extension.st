Extension { #name : 'GncAST' }

{ #category : '*PBT' }
GncAST >> backPropagateIteration: reward [

	grammarRule ifNotNil: [
		grammarRule backPropagate: reward ].
	self backPropagateToChildren: reward.
]

{ #category : '*PBT' }
GncAST >> backPropagateToChildren: reward [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncAST >> grammarRule: gncRule [

	grammarRule := gncRule.
]
