Extension { #name : 'OrderedDictionary' }

{ #category : '*Ume' }
OrderedDictionary >> at: aKey put: aValue [

	<noInstrumentation>
	^ self
		  value: [ dictionary at: aKey put: aValue ]
		  registeringAtOrderedKeys: aKey
]
