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
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
ExtendedMarkdownGrammar >> defineGrammar [

	super defineGrammar.

	ntExtendedStatements --> ntExtendedStatement , ntSpaces , ntExtendedStatements | ntExtendedStatement.

	ntExtendedStatement --> ntElement | ntExtendedElement.

	ntExtendedElement --> ntTable | ntCodeBlock | ntFootnote | ntHeadingID | ntStrikethrough | ntTaskList | ntEmoji | ntSubscript.

	ntTable --> ntTableTitles , Character cr asString , ntTableSeparators , Character cr asString , ntTableRows.

	ntTableTitles --> ntTableRows.

	ntTableSeparators --> '| ----------- |' | '| -----------' , ntTableSeparators.

	ntTableRows --> ntTableCell | '|' , ntString , ntTableTitles.

	ntTableCell --> '|' , ntString , '|'.

	ntCodeBlock --> '```', ntSpaces , ntProgrammingCode , ntSpaces , '```'.

	ntProgrammingCode --> ntString | ''.

	ntFootnote --> '[^' , ntDecimal , ']: ' , ntString.

	ntHeadingID --> ntString , '{#' , ntString , '}' , ntString.

	ntStrikethrough --> '~~' , ntString , '~~'.

	ntTaskList --> ntTaskItem , Character cr asString , ntTaskList | ntTaskItem.

	ntTaskItem --> '- ' , ntItemCheckbox , ntSpace , ntString.

	ntItemCheckbox --> '[ ]' | '[x]'.

	ntEmoji --> ':' , ntEmotionLabel , ':'.

	ntEmotionLabel --> ntString.

	ntSubscript --> '~' , ntString , '~'.

	^ ntExtendedStatements
]
