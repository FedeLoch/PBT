Class {
	#name : 'GrammarBasePathologicalBugExperiment',
	#superclass : 'Object',
	#instVars : [
		'experimentTime'
	],
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
GrammarBasePathologicalBugExperiment class >> run [

	^ self new run
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugExperiment >> allPathNames [

	| fileNames |
	
	fileNames := OrderedCollection new.
	self seeds do: [ :seed |
		self mutationsPerIterations do: [ :times | 
			self mutatorVariants do: [ :mutators |
				fileNames add: (self fileNameSeed: seed mutators: mutators mutationsPerIteration: times)
			 ]
		]
	].

	^ fileNames
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> experimentTime [

	^ experimentTime
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> experimentTime: aDuration [

	experimentTime := aDuration 
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugExperiment >> fileNameSeed: seed mutators: mutators mutationsPerIteration: times [

	| mutatorsLabel |
	mutatorsLabel := '-mutators:', (mutators collect: #className) asString.
	
	^ self name, '-seed:', seed, mutatorsLabel, '-mutationPerIteration: ', times asString, '.ston'.
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> initialize [ 

	super initialize.
	experimentTime := 5 seconds
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> maxInputSize [

	^ SmallInteger maxVal 
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> mutationsPerIterations [

	^ { 3 . 100 }
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> mutatorVariants [

	| maxSize |
	
	maxSize := self maxInputSize.

	^ {
		{ PBTAddByteMutator new maxInputSize: maxSize. PBTByteFlipMutator new. PBTDelByteMutator new }.
		{ (PBTGrammarMutator from: self newGrammar) maxInputSize: maxSize }.
		{ (PBTTreeGrammarMutator from: self newGrammar) maxInputSize: maxSize }
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
		self mutationsPerIterations do: [ :times |
			self mutatorVariants do: [ :mutators |
				Smalltalk garbageCollect. "We perform a garbageCollect before each execution"
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
	
	fileName := self fileNameSeed: seed mutators: mutators mutationsPerIteration: n.
	
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
