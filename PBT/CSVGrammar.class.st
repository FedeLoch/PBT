Class {
	#name : 'CSVGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntCellValue',
		'ntPrivimite',
		'ntString',
		'ntInteger',
		'ntDigit',
		'ntCsv',
		'ntEmptyString',
		'ntRow',
		'ntLetter'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
CSVGrammar >> defineGrammar [

	ntCsv --> ntRow, Character cr asString, ntCsv | ntRow.
	
	ntRow --> ntCellValue, ',', ntRow | ntCellValue.

	ntCellValue --> ntEmptyString | ntInteger | ntPrivimite | ntString.
	
	ntEmptyString --> ''.

	ntPrivimite --> 'true' | 'false' | 'null'.
	
	ntString --> ntLetter , ntString | ntLetter.

	ntLetter --> ($a - $z) | ($A - $Z) | ':' | '/' | '.'  | '\' | '>' | $' asString | '#' | '’' |  '_' | '-' | '@' | ' '.
	
	ntInteger --> ntDigit, ntInteger | ntDigit.
	
	ntDigit --> ($0 - $9).
	
	^ ntCsv
]
