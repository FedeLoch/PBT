Class {
	#name : 'StringGrammarWithoutRanges',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntChar',
		'ntString'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
StringGrammarWithoutRanges >> defineGrammar [

	ntChar --> 'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'ñ'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z'.
	ntString --> ntChar, ntString | ntChar.
	
	^ ntString 
]
