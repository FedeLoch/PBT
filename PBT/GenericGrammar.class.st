Class {
	#name : 'GenericGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntInteger',
		'ntString',
		'ntRoot',
		'ntBoolean',
		'ntDate',
		'ntDigit',
		'ntYear',
		'ntMonth',
		'ntDay',
		'ntDecimal',
		'ntPoint'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
GenericGrammar >> defineGrammar [

	ntString --> ($a - $z), ntString | ($a - $z).
	
	ntDigit --> ($0 - $9).
	
	ntDecimal --> ntDigit, ntDigit.
	
	ntInteger --> ntDecimal.
	
	ntBoolean --> 'false' | 'true'.
	
	ntDay --> ntDigit | '1', ntDigit | '2', ntDigit | '30' | '31'.
	
	ntMonth --> ntDigit | '11' | '10' | '12'.
	
	ntYear --> ntDigit, ntDigit, ntDigit, ntDigit.
	
	"TODO: I need other kind of constructor declaration"
	ntDate --> 'year:', ntYear, 'month:', ntMonth, 'day of week:', ntDay.
	
	ntPoint --> ntDecimal, '@', ntDecimal.
	
	^ ntRoot 
]
