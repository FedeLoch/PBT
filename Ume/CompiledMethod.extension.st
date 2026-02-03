Extension { #name : 'CompiledMethod' }

{ #category : '*Ume' }
CompiledMethod >> selfReachableMethods [
	
	^ self selfReachableMethods: Set new
]

{ #category : '*Ume' }
CompiledMethod >> selfReachableMethods: seen [

	(seen includes: self) ifTrue: [ ^ seen ].
	seen add: self.

	self selfMessages do: [ :symbol |
		| class |
		class := self methodClass.
		class methodDict
			at: symbol
			ifPresent: [
			(class compiledMethodAt: symbol) selfReachableMethods: seen ] ].

	^ seen
]

{ #category : '*Ume' }
CompiledMethod >> sendReachableMethods [

	^ self sendReachableMethods: Set new
]

{ #category : '*Ume' }
CompiledMethod >> sendReachableMethods: seen [

	(seen includes: self) ifTrue: [ ^ seen ].

	seen add: self.

	self sendNodes do: [ :sendNode |
		(self package allMethodsWith: sendNode selector) do: [ :method |
			method sendReachableMethods: seen ] ].

	^ seen
]
