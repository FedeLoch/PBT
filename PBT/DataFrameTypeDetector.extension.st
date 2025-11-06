Extension { #name : 'DataFrameTypeDetector' }

{ #category : '*PBT' }
DataFrameTypeDetector >> perturbation: n [

	(n = 0) ifTrue: [ ^ self ].
	(Delay forMilliseconds: 1) wait.
	
	self perturbation: n - 1	
]
