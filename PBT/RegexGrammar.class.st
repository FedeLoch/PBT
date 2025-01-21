Class {
	#name : 'RegexGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntRegex',
		'ntConcat',
		'ntModifier',
		'ntAtom',
		'ntNonEmptyAtom',
		'ntNonEmptyRegex',
		'ntNonEmptyConcat'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'initialization' }
RegexGrammar >> defineGrammar [
	
	super defineGrammar.
	ntRegex --> ntConcat | ntConcat, '|', ntRegex.
	ntConcat --> ntModifier | ntModifier, ntConcat.
	ntModifier --> ntAtom
					| ntNonEmptyAtom, '?'
					| ntNonEmptyAtom, '*'
					| ntNonEmptyAtom, '+'.
					
	ntAtom --> 'a' | 'b' | 'c' | '.' | '(', ntRegex, ')'.
	ntNonEmptyAtom --> 'a' | 'b' | 'c' | '(', ntNonEmptyRegex, ')'.
	ntNonEmptyRegex --> ntNonEmptyConcat
							| ntNonEmptyConcat, '|', ntNonEmptyRegex.
	ntNonEmptyConcat --> ntNonEmptyAtom
							| ntNonEmptyAtom, ntConcat
							| ntModifier, ntNonEmptyConcat.
	^ ntRegex
]
