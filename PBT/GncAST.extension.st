Extension { #name : 'GncAST' }

{ #category : '*PBT' }
GncAST >> allChildren [

	self subclassResponsibility
]

{ #category : '*PBT' }
GncAST >> asInput [

	^ self asStringInput
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
GncAST >> canReplace: aNode [

	"Return true if I can replace aNode in the AST. 
	 Basic rule: same grammar type/tag."
	
	^ self grammarRule = aNode grammarRule
]

{ #category : '*PBT' }
GncAST >> emptyTree [

	^ GncInnerNode new tag: self tag; grammarRule: grammarRule; children: {}.
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
GncAST >> isTypeVariable [

	^ false
]

{ #category : '*PBT' }
GncAST >> minimumTree [

	^ GncInnerNode new tag: self tag; grammarRule: grammarRule; children: grammarRule minimumTree.
]

{ #category : '*PBT' }
GncAST >> tag [

	^ nil
]

{ #category : '*PBT' }
GncAST >> updateWeightRecursive: reward [

	grammarRule ifNotNil: [ grammarRule updateWeightWith: reward ].
	
	self updateWeightToChildren: reward.
]

{ #category : '*PBT' }
GncAST >> updateWeightToChildren: reward [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncAST >> visited [
	
	^ false 
]
