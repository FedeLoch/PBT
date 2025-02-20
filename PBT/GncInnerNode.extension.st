Extension { #name : 'GncInnerNode' }

{ #category : '*PBT' }
GncInnerNode >> backPropagateToChildren: reward [

	self children do: [ :child | child backPropagateIteration: reward ]
]
