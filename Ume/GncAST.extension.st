Extension { #name : 'GncAST' }

{ #category : '*Ume' }
GncAST >> allChildren [

	self subclassResponsibility
]

{ #category : '*Ume' }
GncAST >> asInput [

	^ self asStringInput
]

{ #category : '*Ume' }
GncAST >> asPharoObject [

	self subclassResponsibility 
]

{ #category : '*Ume' }
GncAST >> asPrimitiveObject [

	^ [ Object readFrom: self asStringInput ]
		  on: Error
		  do: [ :ex | self asStringInput ]
]

{ #category : '*Ume' }
GncAST >> asStringInput [

	^ String streamContents: [ :stream | self generateInto: stream ]
]

{ #category : '*Ume' }
GncAST >> backPropagate: reward [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward ].
]

{ #category : '*Ume' }
GncAST >> backPropagateRecursive: reward [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward ].
	self backPropagateToChildren: reward.
]

{ #category : '*Ume' }
GncAST >> backPropagateRecursive: reward level: level [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward level: level. "grammarRule visitIn: level" ].

	self backPropagateToChildren: reward level: level + 1.
]

{ #category : '*Ume' }
GncAST >> backPropagateToChildren: reward [

	self subclassResponsibility 
]

{ #category : '*Ume' }
GncAST >> backPropagateToChildren: reward level: level [

	self subclassResponsibility 
]

{ #category : '*Ume' }
GncAST >> canReplace: aNode [

	"Return true if I can replace aNode in the AST. 
	 Basic rule: same grammar type/tag."
	
	^ self grammarRule = aNode grammarRule
]

{ #category : '*Ume' }
GncAST >> emptyTree [

	^ GncInnerNode new tag: self tag; grammarRule: grammarRule; children: {}.
]

{ #category : '*Ume' }
GncAST >> isTypeVariable [

	^ false
]

{ #category : '*Ume' }
GncAST >> minimumTree [

	^ GncInnerNode new tag: self tag; grammarRule: grammarRule; children: grammarRule minimumTree.
]

{ #category : '*Ume' }
GncAST >> tag [

	^ nil
]

{ #category : '*Ume' }
GncAST >> visited [
	
	^ false 
]
