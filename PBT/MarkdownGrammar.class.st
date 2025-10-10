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
		'ntDigit'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
MarkdownGrammar >> defineGrammar [

	ntStatements --> ntElement | ntElement, ntStatements.

	ntElement --> ntHeader | ntBold | ntItalic | ntBlockQuote
		| ntOrderedList | ntUnorderedList | ntCode | ntHorizontalRule
		| ntLink | ntImage.
		
	ntHeader --> ('#' | '##' | '###'), ntSpace, ntString.
	
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
	
	ntString --> ($a - $z), ntString | ($a - $z).
	
	ntDigit --> ($0 - $9).
	
	ntDecimal --> ntDigit, ntDigit.

	^ ntStatements
]
