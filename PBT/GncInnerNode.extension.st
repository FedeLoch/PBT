Extension { #name : 'GncInnerNode' }

{ #category : '*PBT' }
GncInnerNode >> backPropagateToChildren: reward [

	self children do: [ :child | child backPropagateRecursive: reward ]
]

{ #category : '*PBT' }
GncInnerNode >> backPropagateToChildren: reward level: level [

	self children do: [ :child | child backPropagateRecursive: reward level: level ]
]
