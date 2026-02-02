Class {
	#name : 'PBTAssociationParserGenerator',
	#superclass : 'PBTParserGenerator',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTAssociationParserGenerator >> parse: grammarBasedInput [

	^ grammarBasedInput lines collect: [ :assoc | self parseAssoc: assoc ]
]

{ #category : 'parsing' }
PBTAssociationParserGenerator >> parseAssoc: assoc [

	| splited |
	splited := assoc substrings: '->'.
	^ Association new
		  key: (self parseKey: (splited at: 1));
		  value: (self parseValue: (splited at: 2));
		  yourself
]

{ #category : 'parsing' }
PBTAssociationParserGenerator >> parseKey: key [ 

	^ key = 'nil' ifTrue: [ nil ] ifFalse: [ key ] 
]

{ #category : 'parsing' }
PBTAssociationParserGenerator >> parseValue: stringValue [ 
	  
	| value |
    value := stringValue trim.

    (value isEmpty or: [ value = 'nil' ]) ifTrue: [ ^ nil ].

	[ value := NumberParser parse: value ] on: Error do: [ :e | ].

    ^ value
]
