Extension { #name : 'GncLeaf' }

{ #category : '*Ume' }
GncLeaf >> allChildren [

	^ #(  )
]

{ #category : '*Ume' }
GncLeaf >> asPharoObject [

	^ self asPrimitiveObject 
]

{ #category : '*Ume' }
GncLeaf >> backPropagateToChildren: reward [

	"Do nothing, it's a leaf"
]

{ #category : '*Ume' }
GncLeaf >> backPropagateToChildren: reward level: level [

	"Do nothing, it's a leaf"
]

{ #category : '*Ume' }
GncLeaf >> isTypeVariable [

	^ token class = ByteString and: [ token last = $: ]
]

{ #category : '*Ume' }
GncLeaf >> varName [

	^ token allButLast
]
