Class {
	#name : 'DemaGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntProg',
		'ntProgHeader',
		'ntNewLine',
		'ntBlocks',
		'ntInitialBlock',
		'ntVariable',
		'ntInstrList',
		'ntConditional',
		'ntB1',
		'ntB2',
		'ntB3',
		'ntB_end'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
DemaGrammar >> defineGrammar [

	ntProg --> ntProgHeader, ntNewLine, ntBlocks , ntNewLine , ntInitialBlock.

	ntProgHeader --> '[[b0]]'.

	ntNewLine --> String cr.

	ntBlocks --> ntB1 , ntNewLine , ntB2 , ntNewLine , ntB3 , ntNewLine , ntB_end.

	ntVariable --> 'x' | 'y' | 'z'.

	ntInstrList --> ''.

	ntConditional --> 'GreaterThan' | 'LessThan' | 'GreaterOrEquals' | 'EqualsThan'.

	ntB1 --> 'b_if1:' , ntNewLine , ntInstrList ,
		'_ := If(' , ntConditional, ', ' , ntVariable , ', ' , ntVariable , '; b_if2, b_end)'.

	ntB2 --> 'b_if2:' , ntNewLine , ntInstrList ,
		'_ := If(' , ntConditional, ', ' , ntVariable , ', ' , ntVariable , '; b_if3, b_end)'.

	ntB3 --> 'b_if3:' , ntNewLine , ntInstrList ,
		'_ := If(' , ntConditional, ', ' , ntVariable , ', ' , ntVariable , '; b_end, b_end)'.

	ntB_end --> 'b_end: _ := Store(8, 2, 777)'.

	ntInitialBlock --> 'b0:
    x := LoadFramePointer()
    y := LoadFramePointer()
    z := LoadFramePointer()
    _ := Jump(b_if1)'.

	^ ntProg
]
