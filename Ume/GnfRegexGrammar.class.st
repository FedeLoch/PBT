Class {
	#name : 'GnfRegexGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntRegex',
		'ntConcatTail',
		'ntModifier',
		'ntNonEmptyRegex',
		'ntNonEmptyPure',
		'ntNonEmptyConcatTail'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
GnfRegexGrammar >> defineGrammar [

	ntRegex --> 'a', ntConcatTail
  					| 'b', ntConcatTail
  					| 'c', ntConcatTail
  					| '.', ntConcatTail
  					| '(', ntRegex, ')', ntConcatTail
  					| 'a', ntConcatTail, '|' ,ntRegex
  					| 'b', ntConcatTail, '|' ,ntRegex
  					| 'c', ntConcatTail, '|' ,ntRegex
  					| '.', ntConcatTail, '|', ntRegex
  					| '(', ntRegex, ')', ntConcatTail, '|', ntRegex.

	ntConcatTail --> 'a', ntConcatTail
  						| 'b', ntConcatTail
  						| 'c', ntConcatTail
 					 	| '.', ntConcatTail
  						| '(', ntRegex, ')', ntConcatTail
  						| ''.

	ntModifier --> 'a'
						| 'b'
						| 'c'
						| '.'
						| '(', ntRegex, ')'
  						| 'a', '?'
  						| 'b', '?'
  						| 'c', '?'
    					| '(', ntNonEmptyRegex, ')', '?'
    					| 'a', '*'
    					| 'b', '*'
    					| 'c', '*'
      					| '(', ntNonEmptyRegex, ')', '*'
      					| 'a', '+'
      					| 'b', '+'
      					| 'c', '+'
      					| '(', ntNonEmptyRegex, ')', '+'.

	ntNonEmptyPure --> 'a' | 'b' | 'c' | '(', ntNonEmptyRegex, ')'.

	ntNonEmptyRegex --> 'a', ntNonEmptyConcatTail
  							| 'b' ,ntNonEmptyConcatTail
  							| 'c' ,ntNonEmptyConcatTail
  							| '(' ,ntNonEmptyRegex, ')', ntNonEmptyConcatTail
  							| 'a' ,ntNonEmptyConcatTail, '|', ntNonEmptyRegex
  							| 'b' ,ntNonEmptyConcatTail, '|', ntNonEmptyRegex
  							| 'c' ,ntNonEmptyConcatTail, '|', ntNonEmptyRegex
 	 						| '(' ,ntNonEmptyRegex, ')', ntNonEmptyConcatTail, '|' ,ntNonEmptyRegex.

	ntNonEmptyConcatTail --> 'a', ntConcatTail
  									| 'b', ntConcatTail
  									| 'c', ntConcatTail
  									| '(', ntNonEmptyRegex, ')', ntConcatTail
									| 'a', ntNonEmptyConcatTail
									| 'b', ntNonEmptyConcatTail
									| 'c', ntNonEmptyConcatTail
									| '(', ntRegex, ')', ntNonEmptyConcatTail.
									
	^ ntRegex
]
