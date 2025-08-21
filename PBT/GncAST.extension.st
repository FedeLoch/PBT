Extension { #name : 'GncAST' }

{ #category : '*PBT' }
GncAST >> allChildren [

	self subclassResponsibility
]

{ #category : '*PBT' }
GncAST >> asPharoObject [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncAST >> asPrimitiveObject [

	^ [ Object readFrom: self asStringInput ]
		  on: Error
		  do: [ :ex | self asStringInput ]
]

{ #category : '*PBT' }
GncAST >> asStringInput [

	^ String streamContents: [ :stream | self generateInto: stream ]
]

{ #category : '*PBT' }
GncAST >> backPropagate: reward [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward ].
]

{ #category : '*PBT' }
GncAST >> backPropagateRecursive: reward [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward ].
	self backPropagateToChildren: reward.
]

{ #category : '*PBT' }
GncAST >> backPropagateRecursive: reward level: level [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward level: level. "grammarRule visitIn: level" ].

	self backPropagateToChildren: reward level: level + 1.
]

{ #category : '*PBT' }
GncAST >> backPropagateToChildren: reward [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncAST >> backPropagateToChildren: reward level: level [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncAST >> grammarRule [

	^ grammarRule
]

{ #category : '*PBT' }
GncAST >> grammarRule: gncRule [

	grammarRule := gncRule.
]

{ #category : '*PBT' }
GncAST >> visited [
	
	^ false 
]
