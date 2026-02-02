Extension { #name : 'OCProgramNode' }

{ #category : '*Ume' }
OCProgramNode >> childAtPath: path [

	path ifEmpty: [  ^ self ].
	
	path first = 0 ifTrue: [ ^self ].
	
	^ (self children at: path first) childAtPath: path allButFirst
]

{ #category : '*Ume' }
OCProgramNode >> indexInParent [

	^ self parent children indexOf: self
]

{ #category : '*Ume' }
OCProgramNode >> isRoot [

	^ parent isNil
]

{ #category : '*Ume' }
OCProgramNode >> path [

	self isRoot ifTrue: [ ^ #(  ) ].

	^ self parent path , { self indexInParent }
]

{ #category : '*Ume' }
OCProgramNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties )
]
