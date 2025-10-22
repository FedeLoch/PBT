Class {
	#name : 'GrammarBasePathologicalBugExperiment',
	#superclass : 'Object',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
GrammarBasePathologicalBugExperiment class >> run [

	^ self new run
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> experimentTime [

	^ 10 seconds
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> mutationsPerIterations [

	^ { 3 . 100 }
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> mutatorVariants [

	^ {
		[ { PBTAddByteMutator new. PBTByteFlipMutator new. PBTDelByteMutator new } ].
		[ { PBTGrammarMutator from: self newGrammar } ].
		[ { PBTTreeGrammarMutator from: self newGrammar } ]
	}
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> name [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> newGrammar [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> run [

	self seeds do: [ :seed |
		self mutatorVariants do: [ :mutatorsBlock | | mutators |
			mutators := mutatorsBlock value.
			self mutationsPerIterations do: [ :times |
				self run: seed mutators: mutators mutationsPerIteration: times
			 ]
		]
	]
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> run: seed mutators: mutators mutationsPerIteration: n [

	| schema runner result fileName |
	
	schema := self schema: seed mutators: mutators mutationsPerIteration: n.
	
	runner := PBTRunner test: self targetMethod from: schema for: self experimentTime.
	
	"Guided by methods called"
	runner guidedByMethodsCalls.
	
	result := runner run.
	
	fileName := self name, '-seed:', seed, '-mutators:' join: (mutators collect: #className), '-mutationPerIteration: ', n asString, '.ston'.
	
	result writeToFile: fileName.
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> schema: seed mutators: mutators mutationsPerIteration: n [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> seeds [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> targetMethod [

	self subclassResponsibility 
]
