Extension { #name : 'GncNonTerminal' }

{ #category : '*PBT' }
GncNonTerminal >> generateMCTSDerivation: totalGenerations maxSize: maxLen explorationConstant: c [

	| notVisited rule |
	
	notVisited := self rules reject: #visited.
	
	rule := notVisited ifEmpty: [ self ruleWithMoreUTC: totalGenerations constant: c ] ifNotEmpty: [ notVisited first ].
	"Ya se que rule tengo que tomar"
	"Deberia crear un node de ast, guardar la referencia a su rule y que siga agrandando el ast "
	1 halt.
	self shouldBeImplemented.
]

{ #category : '*PBT' }
GncNonTerminal >> ruleWithMoreUTC: totalGenerations constant: c [

	^ (rules sort: [
		:r :r2 | (r utc: totalGenerations by: c) >= r2 utc: totalGenerations by: c
	]) first
]
