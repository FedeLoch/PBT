Class {
	#name : 'JSONGrammar',
	#superclass : 'GenericGrammar',
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
		'ntKey'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
JSONGrammar >> defineGrammar [

	super defineGrammar.
	
	ntRoot --> ntJSON.

	ntJSON --> ntValue.
	
	ntValue --> ntQuote, ntString, ntQuote | ntInteger | ntObject | ntArray | ntPrivimite.
	
	ntObject --> ntOpenBracket, ntKeyValues, ntCloseBracket.
	
	ntKeyValues --> ntKeyValue | ntKeyValue, ',', ntKeyValues.
	
	ntKeyValue --> ntKey, ntValue.
	
	ntKey --> ntQuote, ntString, ntQuote, ':'.
	
	ntArray --> ntOpenBlock, ntElements, ntCloseBlock.
	
	ntElements --> ntValue | ntValue, ',', ntElements.
	
	ntOpenBlock --> '['.
		
	ntCloseBlock --> ']'.
	
	ntOpenBracket --> '{'.
	
	ntCloseBracket --> '}'.

	ntQuote --> '"'.
	
	ntPrivimite --> 'true' | 'false' | 'null'.
	
	^ ntRoot 
]
