Extension { #name : 'GncInnerNode' }

{ #category : '*Ume' }
GncInnerNode >> asClassInstanceObject [

	| objectClass |

	objectClass := self objectClass.

	^ (1 to: children size by: 2) inject: objectClass basicNew into: [ :inst :index | | value |
		value := (children at: index + 1) asPharoObject.
		inst instVarNamed: (children at: index) varName put: value.
		inst
	]
]

{ #category : '*Ume' }
GncInnerNode >> asPharoObject [

	^ self isClassObject
		  ifTrue: [ self asClassInstanceObject ]
		  ifFalse: [ self asPrimitiveObject ]
]

{ #category : '*Ume' }
GncInnerNode >> backPropagateToChildren: reward [

	self children do: [ :child | child backPropagateRecursive: reward ]
]

{ #category : '*Ume' }
GncInnerNode >> backPropagateToChildren: reward level: level [

	self children do: [ :child | child backPropagateRecursive: reward level: level ]
]

{ #category : '*Ume' }
GncInnerNode >> indexOf: aNode [

	^ children indexOf: aNode
]

{ #category : '*Ume' }
GncInnerNode >> isClassObject [

	^ children first isTypeVariable
]

{ #category : '*Ume' }
GncInnerNode >> objectClass [

	^ tag asClassInEnvironment: self class environment
]

{ #category : '*Ume' }
GncInnerNode >> removeChildAt: index [ 

	children removeAt: index.
]

{ #category : '*Ume' }
GncInnerNode >> replaceChildAt: index with: newNode [

	children at: index put: newNode.
	newNode parent: self.
]

{ #category : '*Ume' }
GncInnerNode >> updateWeightToChildren: reward [ 

	self children do: [ :child | child updateWeightRecursive: reward ]
]
