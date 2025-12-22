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

{ #category : '*PBT' }
GncInnerNode >> indexOf: aNode [

	^ children indexOf: aNode
]

{ #category : '*PBT' }
GncInnerNode >> isClassObject [

	^ children first isTypeVariable
]

{ #category : '*PBT' }
GncInnerNode >> objectClass [

	^ tag asClassInEnvironment: self class environment
]

{ #category : '*PBT' }
GncInnerNode >> replaceChildAt: index with: newNode [

	children at: index put: newNode.
	newNode parent: self.
]

{ #category : '*PBT' }
GncInnerNode >> updateWeightToChildren: reward [ 

	self children do: [ :child | child updateWeightRecursive: reward ]
]
