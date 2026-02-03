Extension { #name : 'NeoJSONReader' }

{ #category : '*Ume' }
NeoJSONReader class >> mutate: input with: anotherInput [

	| json |

	json := self fromString: input.
	json ifNil: [ ^ anotherInput ].

	^ NeoJSONWriter toString: (json mutateJson: (self fromString: anotherInput)).

]

{ #category : '*Ume' }
NeoJSONReader >> parseList [

	self perturbation: 100.
	
	^ self listClass 
		streamContents: [ :stream |
			self parseListElementsDo: [ :each |
				stream nextPut: each ] ]

		
]

{ #category : '*Ume' }
NeoJSONReader >> perturbation: n [

	(n = 0) ifTrue: [ ^ self ].
	(Delay forMilliseconds: 1) wait.
	
	self perturbation: n - 1	
]
