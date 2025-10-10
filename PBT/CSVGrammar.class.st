Class {
	#name : 'CSVGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntCellValue',
		'ntPrivimite',
		'ntString',
		'ntInteger',
		'ntDigit',
		'ntDecimal',
		'ntCsv',
		'ntQuote',
		'ntEmptyString',
		'ntRow'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
CSVGrammar >> defineGrammar [

	ntCsv --> ntRow | ntRow, Character cr asString, ntCsv.
	
	ntRow --> ntCellValue | ntCellValue, ',', ntRow.

	ntCellValue --> ntEmptyString | ntPrivimite | ntString | ntInteger.
	
	ntEmptyString --> ''.

	ntPrivimite --> 'true' | 'false' | 'null'.
	
	ntString --> ntQuote, ($a - $z), ntString, ntQuote | ntQuote, ($a - $z), ntQuote.
	
	ntQuote --> '"'.
	
	ntDigit --> ($0 - $9).
	
	ntDecimal --> ntDigit, ntDigit.
	
	ntInteger --> ntDigit | ntDigit, ntInteger.
	
	^ ntCsv
]
