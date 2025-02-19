Extension { #name : 'GncAST' }

{ #category : '*PBT' }
GncAST >> backPropagateIteration: reward [

	grammarRule visit.
	grammarRule newReward: reward.
	self children do: [ :child | child backPropagateIteration: reward ]
]

{ #category : '*PBT' }
GncAST >> grammarRule: gncRule [

	grammarRule := gncRule.
]
