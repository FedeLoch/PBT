Class {
	#name : 'GrammarBasePathologicalBugMutatorExperiment',
	#superclass : 'Object',
	#instVars : [
		'experimentTime'
	],
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorExperiment class >> getResults [

	^ self new allPathNames collect: [ :file | STON fromStream: file asFileReference readStream ]
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorExperiment class >> getResults: sourcePath [

	^ self new allPathNames collect: [ :file | STON fromStream: (sourcePath, file) asFileReference readStream ]
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorExperiment class >> getResults: sourcePath at: position [

	^ STON fromStream: (sourcePath, (self new allPathNames at: position)) asFileReference readStream
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment class >> run [

	^ self new run
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorExperiment >> allPathNames [

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
GrammarBasePathologicalBugMutatorExperiment >> experimentTime [

	^ experimentTime
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> experimentTime: aDuration [

	experimentTime := aDuration 
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorExperiment >> fileNameSeed: seed mutators: mutators mutationsPerIteration: times [

	| mutatorsLabel |
	mutatorsLabel := '-mutators=', (mutators collect: #className) asString.

	^ self name, '-seed=', seed hash asString, mutatorsLabel, '-mutationPerIteration=', times asString, '.ston'.
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> initialize [ 

	super initialize.
	experimentTime := 4 hours.
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> maxInputSize [

	^ SmallInteger maxVal 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> mutationsPerIterations [

	^ { 3 . 100 }
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> mutatorVariants [

	| maxSize |
	
	maxSize := self maxInputSize.

	^ {
		{ PBTAddByteMutator new maxInputSize: maxSize. PBTByteFlipMutator new. PBTDelByteMutator new }.
		{ (PBTGrammarMutator from: self newGrammar) maxInputSize: maxSize }.
		{ (PBTTreeGrammarMutator from: self newGrammar) maxInputSize: maxSize }
	}
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> name [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> newGrammar [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> run [

	self seeds do: [ :seed |
		self mutationsPerIterations do: [ :times |
			self mutatorVariants do: [ :mutators |
				Smalltalk garbageCollect. "We perform a garbageCollect before each execution"
				"We are copying the seed because some mutators mutate the string itself"
				self run: seed deepCopy mutators: mutators mutationsPerIteration: times
			 ]
		]
	]
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> run: seed mutators: mutators mutationsPerIteration: n [

	| schema runner result fileName |
	
	fileName := self fileNameSeed: seed mutators: mutators mutationsPerIteration: n.
	
	schema := self schema: seed mutators: mutators mutationsPerIteration: n.
	
	runner := PBTRunner test: self targetMethod from: schema for: self experimentTime.
	
	"Guided by methods called"
	runner guidedByMethodsCalls.
	
	result := runner run.
	
	result writeToFile: fileName.
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> schema: seed mutators: mutators mutationsPerIteration: n [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> seeds [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorExperiment >> targetMethod [

	self subclassResponsibility 
]
