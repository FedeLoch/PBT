Class {
	#name : 'JSONGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntJSON',
		'ntValue',
		'ntObject',
		'ntArray',
		'ntPrivimite',
		'ntQuote',
		'ntKeyValues',
		'ntKeyValue',
		'ntOpenBracket',
		'ntCloseBracket',
		'ntOpenBlock',
		'ntElements',
		'ntCloseBlock',
		'ntKey',
		'ntString',
		'ntInteger',
		'ntDigit',
		'ntDecimal'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
JSONGrammar >> defineGrammar [

	ntJSON --> ntValue.
	
	ntValue --> ntQuote, ntString, ntQuote | ntInteger | ntObject | ntArray | ntPrivimite.
	
	ntObject --> ntOpenBracket, ntKeyValues, ntCloseBracket.
	
	ntKeyValues --> '' | ntKeyValue | ntKeyValue, ',', ntKeyValues.
	
	ntKeyValue --> ntKey, ntValue.
	
	ntKey --> ntQuote, ntString, ntQuote, ':'.
	
	ntArray --> ntOpenBlock, ntElements, ntCloseBlock.
	
	ntElements --> ''| ntValue | ntValue, ',', ntElements.
	
	ntOpenBlock --> '['.
		
	ntCloseBlock --> ']'.
	
	ntOpenBracket --> '{'.
	
	ntCloseBracket --> '}'.

	ntQuote --> '"'.
	
	ntPrivimite --> 'true' | 'false' | 'null'.
	
	ntString --> ($a - $z), ntString | ($a - $z) | ''.
	
	ntDigit --> ($0 - $9).
	
	ntDecimal --> ntDigit, ntDigit.
	
	ntInteger --> ntDigit | ntDigit, ntInteger.
	
	^ ntJSON 
]
