Extension { #name : 'GncLeaf' }

{ #category : '*PBT' }
GncLeaf >> allChildren [

	^ #(  )
]

{ #category : '*PBT' }
GncLeaf >> asPharoObject [

	^ self asPrimitiveObject 
]

{ #category : '*PBT' }
GncLeaf >> backPropagateToChildren: reward [

	"Do nothing, it's a leaf"
]

{ #category : '*PBT' }
GncLeaf >> backPropagateToChildren: reward level: level [

	"Do nothing, it's a leaf"
]

{ #category : '*PBT' }
GncLeaf >> isTypeVariable [

	^ token class = ByteString and: [ token last = $: ]
]

{ #category : '*PBT' }
GncLeaf >> varName [

	^ token allButLast
]
