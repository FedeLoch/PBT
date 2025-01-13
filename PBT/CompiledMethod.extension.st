Extension { #name : 'CompiledMethod' }

{ #category : '*PBT' }
CompiledMethod >> selfMethodAffected [
	
	^ self selfMethodAffected: Set new
]

{ #category : '*PBT' }
CompiledMethod >> selfMethodAffected: seen [

	(seen includes: self) ifTrue: [ ^seen ].
	
	^ seen, self selfMessages inject: { self } asSet into: [ :set :symbol | | class |
		class := self methodClass.
		class methodDict at: symbol ifPresent: [
			set, ((class compiledMethodAt: symbol) selfMethodAffected: set) ] ifAbsent: [ set ]
	]
]
