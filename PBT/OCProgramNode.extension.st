Extension { #name : 'OCProgramNode' }

{ #category : '*PBT' }
OCProgramNode >> childAtPath: path [

	path ifEmpty: [  ^ self ].
	
	path first = 0 ifTrue: [ ^self ].
	
	^ (self children at: path first) childAtPath: path allButFirst
]

{ #category : '*PBT' }
OCProgramNode >> indexInParent [

	^ self parent children indexOf: self
]

{ #category : '*PBT' }
OCProgramNode >> isRoot [

	^ parent isNil
]

{ #category : '*PBT' }
OCProgramNode >> path [

	self isRoot ifTrue: [ ^ #(  ) ].

	^ self parent path , { self indexInParent }
]

{ #category : '*PBT' }
OCProgramNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties )
]
