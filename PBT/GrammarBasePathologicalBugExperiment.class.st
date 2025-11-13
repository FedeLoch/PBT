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

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugExperiment class >> getResults [

	^ self new allPathNames collect: [ :file | STON fromStream: file asFileReference readStream ]
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugExperiment class >> getResults: sourcePath [

	^ self new allPathNames collect: [ :file | STON fromStream: (sourcePath, file) asFileReference readStream ]
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugExperiment class >> getResults: sourcePath at: position [

	^ STON fromStream: (sourcePath, (self new allPathNames at: position)) asFileReference readStream
]

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
	mutatorsLabel := '-mutators=', (mutators collect: #className) asString.

	^ self name, '-seed=', seed hash asString, mutatorsLabel, '-mutationPerIteration=', times asString, '.ston'.
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> initialize [ 

	super initialize.
	experimentTime := 4 hours.
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
				"We are copying the seed because some mutators mutate the string itself"
				self run: seed deepCopy mutators: mutators mutationsPerIteration: times
			 ]
		]
	]
]

{ #category : 'running' }
GrammarBasePathologicalBugExperiment >> run: seed mutators: mutators mutationsPerIteration: n [

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
