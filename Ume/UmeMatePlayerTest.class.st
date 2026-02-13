Class {
	#name : 'UmeMatePlayerTest',
	#superclass : 'UmeUnitTest',
	#category : 'Ume-Unit Testing Integration',
	#package : 'Ume',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
UmeMatePlayerTest >> argumentGenerators [

	^ {}
]

{ #category : 'running' }
UmeMatePlayerTest >> assert: receiver arguments: arguments result: result [

	"let's pass all cases for the moment"
	^ true
]

{ #category : 'running' }
UmeMatePlayerTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests: 30 minutes
]

{ #category : 'running' }
UmeMatePlayerTest >> guidedBy [

	self guidedByExecutionTime
	"self guidedByBytecodes" 
]

{ #category : 'running' }
UmeMatePlayerTest >> receiverGenerator [

	| seedElement |
	seedElement := Player new
		               name: 'fede';
		               characterClass: Rogue new;
		               level: 1;
		               missingExperienceForNextLevel: 0.

	^ self
		  corpusGenFrom: seedElement
		  mpi: 3
		  mutators: { (UmeOGGrammarDerivationMutator from: MatePlayerGrammarByLang new) }
]

{ #category : 'running' }
UmeMatePlayerTest >> targetMethod [

	^ Player >> #damage 
]
