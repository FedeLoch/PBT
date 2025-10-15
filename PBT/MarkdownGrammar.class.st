Class {
	#name : 'MarkdownGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntElement',
		'ntHeader',
		'ntBold',
		'ntItalic',
		'ntBlockQuote',
		'ntOrderedList',
		'ntUnorderedList',
		'ntCode',
		'ntHorizontalRule',
		'ntLink',
		'ntImage',
		'ntSpace',
		'ntUrl',
		'ntImageRef',
		'ntStatements',
		'ntString',
		'ntDecimal',
		'ntDigit',
		'ntHeaderSymbol',
		'ntLetter',
		'ntSpaces'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
MarkdownGrammar >> defineGrammar [

	ntStatements --> ntElement, Character cr asString, ntSpaces, ntStatements | ntElement.

	ntElement --> ntHeader | ntBold | ntItalic | ntBlockQuote
		| ntOrderedList | ntUnorderedList | ntCode | ntHorizontalRule
		| ntLink | ntImage.
		
	ntHeader --> ntHeaderSymbol, ntSpace, ntString.
	
	ntHeaderSymbol --> '#' | '##' | '###'.
	
	ntSpaces --> ntSpace, ntSpaces | ntSpace | ''.
	
	ntSpace --> ' '.
	
	ntBold --> '**', ntString, '**'.
	
	ntItalic --> '*', ntString, '*'.
	
	ntBlockQuote --> '>', ntSpace, ntString.
	
	ntOrderedList --> ntDecimal, '.', ntSpace, ntString.
	
	ntUnorderedList --> '-', ntSpace, ntString.
	
	ntCode --> '`', ntString, '`'.
	
	ntHorizontalRule --> '---'.
	
	ntLink --> '[', ntString, ']', '(', ntUrl, ')'.
	
	ntUrl --> ntString "TODO: redefine me well".
	
	ntImage --> '!', '[', ntString, ']', '(', ntImageRef, ')'.
	
	ntImageRef --> ntString.
	
	ntString --> ntLetter, ntString | ntLetter.
	
	ntLetter --> ($a - $z) | ($A - $Z) | ntSpace.
	
	ntDigit --> ($0 - $9).
	
	ntDecimal --> ntDigit, ntDigit.

	^ ntStatements
]
