Class {
	#name : 'UmeOGGrammarDerivationMutatorTest',
	#superclass : 'TestCase',
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'tests' }
UmeOGGrammarDerivationMutatorTest >> doMutateTest: description times: n [

 | grammar object mutator |

	grammar := description asDictionary at: 'grammar'.
	object := description asDictionary at: 'object'.
	
	mutator := UmeOGGrammarDerivationMutator new grammar: grammar.
	n timesRepeat: [
		object := mutator mutate: object.
		grammar parse: object
	].

	^ object

]

{ #category : 'tests' }
UmeOGGrammarDerivationMutatorTest >> setUp [ 

	super setUp.
	self timeLimit: 1 minute.
]

{ #category : 'tests' }
UmeOGGrammarDerivationMutatorTest >> testMutateABlocElementAndTheNewStructureParseCorrectly [

	| object grammar |
	grammar := MateBlocGrammarByLang new.

	object := BlElement new background: Color blue; extent: 1000@1000.

	self doMutateTest: { 'grammar' -> grammar . 'object' -> object } times: 10
]

{ #category : 'tests' }
UmeOGGrammarDerivationMutatorTest >> testMutateAPlayerAndTheNewStructureParseCorrectly [

	| player grammar |
	grammar := MatePlayerGrammarByLang new.

	player := Player new
		          name: 'fede';
		          characterClass: Rogue new;
		          level: 1;
		          missingExperienceForNextLevel: 0.

	self doMutateTest: { 'grammar' -> grammar . 'object' -> player } times: 1000
]
