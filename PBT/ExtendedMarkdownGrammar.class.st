Class {
	#name : 'ExtendedMarkdownGrammar',
	#superclass : 'MarkdownGrammar',
	#instVars : [
		'ntExtendedStatements',
		'ntExtendedStatement',
		'ntExtendedElement',
		'ntTable',
		'ntCodeBlock',
		'ntFootnote',
		'ntHeadingID',
		'ntStrikethrough',
		'ntTaskList',
		'ntEmoji',
		'ntSubscript',
		'ntTableTitles',
		'ntTableSeparators',
		'ntTableRows',
		'ntTableCell',
		'ntProgrammingCode',
		'ntTaskItem',
		'ntItemCheckbox',
		'ntEmotionLabel'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
ExtendedMarkdownGrammar >> defineGrammar [

	super defineGrammar.

	ntExtendedStatements --> ntExtendedStatement | ntExtendedStatement, ntExtendedStatements.

	ntExtendedStatement --> ntElement | ntExtendedElement.

	ntExtendedElement --> ntTable | ntCodeBlock | ntFootnote
		| ntHeadingID | ntStrikethrough | ntTaskList | ntEmoji
		| ntSubscript.
		
	ntTable --> ntTableTitles, '\n', ntTableSeparators, '\n', ntTableRows.
	
	ntTableTitles --> ntTableRows.
	
	ntTableSeparators --> '| ----------- |' | '| -----------', ntTableSeparators.
	
	ntTableRows --> ntTableCell | '|', ntString, ntTableTitles.
	
	ntTableCell --> '|', ntString, '|'.
	
	ntCodeBlock --> '```', ntProgrammingCode, '\n', '```'.

	ntProgrammingCode --> ntString.
	
	ntFootnote --> '[^', ntDecimal, ']: ', ntString.
	
	ntHeadingID --> ntString, '{#', ntString, '}', ntString.
	
	ntStrikethrough --> '~~', ntString, '~~'.
	
	ntTaskList --> ntTaskItem |  ntTaskItem, Character cr asString, ntTaskList.
	
	ntTaskItem --> '- ', ntItemCheckbox, ntSpace, ntString.
	
	ntItemCheckbox --> '[ ]' | '[x]'.
	
	ntEmoji --> ':', ntEmotionLabel, ':'.
	
	ntEmotionLabel --> ntString.
	
	ntSubscript --> '~', ntString, '~'.

	^ ntExtendedStatements
]
