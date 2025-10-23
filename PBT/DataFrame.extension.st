Extension { #name : 'DataFrame' }

{ #category : '*PBT' }
DataFrame >> addRow: anArray named: aString atPosition: aNumber [
	"Add a new row at the given position"
"	(self rowNames includes: aString)
		ifTrue: [ Error signal: 'A row with that name already exists' ]."

	contents addRow: anArray atPosition: aNumber.
	rowNames add: aString afterIndex: aNumber - 1
]
