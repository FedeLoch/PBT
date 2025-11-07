Extension { #name : 'DataFrameTypeDetector' }

{ #category : '*PBT' }
DataFrameTypeDetector >> convertToBoolean: anArray [

	self perturbation: 100.
	^ anArray collect: [ :each | each ifNotNil: [ each asLowercase = 'true' ] ]
]

{ #category : '*PBT' }
DataFrameTypeDetector >> perturbation: n [

	(n = 0) ifTrue: [ ^ self ].
	(Delay forMilliseconds: 1) wait.
	
	self perturbation: n - 1	
]
