Extension { #name : 'GncInnerNode' }

{ #category : '*PBT' }
GncInnerNode >> asClassInstanceObject [

	| objectClass |

	objectClass := self objectClass.

	^ (1 to: children size by: 2) inject: objectClass basicNew into: [ :inst :index | | value |
		value := (children at: index + 1) asPharoObject.
		inst instVarNamed: (children at: index) varName put: value.
		inst
	]
]

{ #category : '*PBT' }
GncInnerNode >> asPharoObject [

	^ self isClassObject
		  ifTrue: [ self asClassInstanceObject ]
		  ifFalse: [ self asPrimitiveObject ]
]

{ #category : '*PBT' }
GncInnerNode >> backPropagateToChildren: reward [

	self children do: [ :child | child backPropagateRecursive: reward ]
]

{ #category : '*PBT' }
GncInnerNode >> backPropagateToChildren: reward level: level [

	self children do: [ :child | child backPropagateRecursive: reward level: level ]
]
