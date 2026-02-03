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
		'ntSpaces',
		'ntSpecialCharater',
		'ntSentence',
		'ntSentenceElement',
		'ntReference'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
MarkdownGrammar >> defineGrammar [

	ntStatements --> ntElement , ntSpaces , ntStatements | ntElement.

	ntElement --> ntHeader | ntBlockQuote | ntOrderedList | ntUnorderedList | ntHorizontalRule | ntSentence.
	
	ntSentence --> ntSentenceElement , ntSentence | ntSentenceElement.
	
	ntSentenceElement --> ntBold | ntItalic | ntCode | ntLink | ntReference | ntImage | ntString.

	ntHeader --> ntHeaderSymbol , ntSpace , ntString.

	ntHeaderSymbol --> '#' | '##' | '###'.

	ntSpaces --> ntSpace , ntSpaces | ntSpace | ''.

	ntSpace --> Character space asString | Character cr asString | Character tab asString.

	ntBold --> '**' , ntString , '**'.
	
	ntReference --> '@', ntString, '@'.

	ntItalic --> '*' , ntString , '*'.

	ntBlockQuote --> '>' , ntSpace , ntString.

	ntOrderedList --> ntDigit , '.' , ntSpace , ntString.

	ntUnorderedList --> '-' , ntSpace , ntString.

	ntCode --> '`' , ntString , '`'.

	ntHorizontalRule --> '---'.

	ntLink --> '[' , ntString , ']' , '(' , ntUrl , ')'.

	ntUrl --> ntString. "TODO: redefine me well"

	ntImage --> '!' , '[' , ntString , ']' , '(' , ntImageRef , ')'.

	ntImageRef --> ntString.

	ntString --> ntLetter , ntString | ntLetter.

	ntLetter --> ($a - $z) | ($A - $Z) | ':' | '/' | '.'  | '\' | ',' | '>' | '#' | '’' | '-' | ' ' "| ntSpecialCharater".

	ntSpecialCharater --> '+' | '-' | '*' | '~' | '<' | '>' | '=' | '@' | ',' | '%' | '|' | '&' | '?' | '!'.

	ntDigit --> ($0 - $9).

	ntDecimal --> ntDigit , ntDigit.

	^ ntStatements
]
