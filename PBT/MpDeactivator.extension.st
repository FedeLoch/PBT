Extension { #name : 'MpDeactivator' }

{ #category : '*PBT' }
MpDeactivator class >> initialize [

	WasMetaTempVariableIndex := (MpMethodProxy class >> #prototypeTrap) temporaryVariables detectIndex: [ :tempVar |
		                            tempVar name = #wasMeta ].
	CompleteTempVariableIndex := (MpMethodProxy class >> #prototypeTrap) temporaryVariables detectIndex: [ :tempVar |
		                             tempVar name = #complete ]
]
