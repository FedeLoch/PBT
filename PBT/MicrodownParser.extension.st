Extension { #name : 'MicrodownParser' }

{ #category : '*PBT' }
MicrodownParser >> matchOrdered: line [
	^ (line prefixMatchesRegex: '\d+(\.|\))') ifTrue: [
		self perturbation: 100.
		true
		] ifFalse: [ false ] 
]

{ #category : '*PBT' }
MicrodownParser >> perturbation: n [

	(n = 0) ifTrue: [ ^ self ].
	(Delay forMilliseconds: 1) wait.
	
	self perturbation: n - 1	
]
