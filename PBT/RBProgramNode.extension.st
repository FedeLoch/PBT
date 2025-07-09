Extension { #name : 'RBProgramNode' }

{ #category : '*PBT' }
RBProgramNode >> childAtPath: path [

	path ifEmpty: [  ^ self ].
	
	path first = 0 ifTrue: [ ^ self ].
	
	^ (self children at: path first) childAtPath: path allButFirst
]

{ #category : '*PBT' }
RBProgramNode >> indexInParent [

	^ self parent children indexOf: self
]

{ #category : '*PBT' }
RBProgramNode >> isRoot [

	^ parent isNil
]

{ #category : '*PBT' }
RBProgramNode >> path [

	self isRoot ifTrue: [ ^ #(  ) ].

	^ self parent path , { self indexInParent }
]
