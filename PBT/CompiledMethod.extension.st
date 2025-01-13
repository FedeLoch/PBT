Extension { #name : 'CompiledMethod' }

{ #category : '*PBT' }
CompiledMethod >> selfReachableMethods [
	
	^ self selfReachableMethods: Set new
]

{ #category : '*PBT' }
CompiledMethod >> selfReachableMethods: seen [

	(seen includes: self) ifTrue: [ ^seen ].
	
	^ seen, self selfMessages inject: { self } asSet into: [ :set :symbol | | class |
		class := self methodClass.
		class methodDict at: symbol ifPresent: [
			set, ((class compiledMethodAt: symbol) selfReachableMethods: set) ] ifAbsent: [ set ]
	]
]
