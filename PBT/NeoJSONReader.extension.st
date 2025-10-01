Extension { #name : 'NeoJSONReader' }

{ #category : '*PBT' }
NeoJSONReader class >> mutate: input with: anotherInput [

	| json |

	json := self fromString: input.
	json ifNil: [ ^ anotherInput ].
	
	^ NeoJSONWriter toString: (json mutateJson: (self fromString: anotherInput)).

]
