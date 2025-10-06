Extension { #name : 'RxsPiece' }

{ #category : '*PBT' }
RxsPiece >> minimalString [

	((self isAtomic or: [ self isPlus ]) or: [ self isSingular ])
		ifTrue: [ ^ atom minimalString ].

	(self isOptional or: [ self isStar ]) ifTrue: [ ^ '' ].
	
	^ atom minimalString repeat: min
]
