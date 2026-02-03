Class {
	#name : 'GrammarBasePathologicalBugMutatorPaperExperiment',
	#superclass : 'Object',
	#instVars : [
		'experimentTime',
		'times',
		'schemas'
	],
	#category : 'Ume-Paper Experimentation',
	#package : 'Ume',
	#tag : 'Paper Experimentation'
}

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorPaperExperiment class >> getResults [

	"TODO"

	^ self new allPathNames collect: [ :file | STON fromStream: file asFileReference readStream ]
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorPaperExperiment class >> getResults: sourcePath [

	"TODO"

	^ self new allPathNames collect: [ :file | STON fromStream: (sourcePath, file) asFileReference readStream ]
]

{ #category : 'as yet unclassified' }
GrammarBasePathologicalBugMutatorPaperExperiment class >> getResults: sourcePath at: position [

	"TODO"

	^ STON fromStream: (sourcePath, (self new allPathNames at: position)) asFileReference readStream
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment class >> run: confName [

	^ self new runConf: confName
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> combinedGrammarMutatorsSchema [

	^ self schemaCorpusWith: (self grammarLiteralMutators, self grammarDerivationMutators)
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> csvFileName: config iteration: iteration [

	^ self name, '-', config, '-', iteration asString, '.csv'
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> experimentTime [

	^ experimentTime
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> experimentTime: aDuration [

	experimentTime := aDuration 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> grammarDerivationMutators [

	^ { (UmeGrammarDerivationMutator from: self newGrammar) maxInputSize: self maxInputSize }
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> grammarDerivationsSchema [

	^ self schemaCorpusWith: self grammarDerivationMutators
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> grammarLiteralMutators [

	^ { (UmeGrammarLiteralsMutator from: self newGrammar) maxInputSize: self maxInputSize }
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> grammarLiteralsSchema [

	^ self schemaCorpusWith: self grammarLiteralMutators
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> initialize [ 

	super initialize.
	experimentTime := 4 hours.
	times := 10.
	schemas := {
		'weighted-grammar-base' -> self weightedGrammarSchema.
		'stochastic-base' -> self stochasticSchema.
		'grammar-literals' -> self grammarLiteralsSchema.
		'grammar-derivations' -> self grammarDerivationsSchema.
		'combined-grammar-mutators' -> self combinedGrammarMutatorsSchema
	} asDictionary.
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> maxInputSize [

	^ SmallInteger maxVal 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> mpi [

	^ 3
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> name [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> newGrammar [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> run: config iteration: i [

	| schema runner result fileName |
	
	fileName := self csvFileName: config iteration: i.

	schema := self schema: config.
	
	runner := UmeRunner test: self targetMethod from: schema for: self experimentTime.
	
	"Guided by methods called"
	runner guidedByMethodsCalls.
	
	result := runner run.
	
	"We export the result as csv"
	result exportAsCSV: fileName.
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> runConf: confName [

	(1 to: times) do: [ :i |
		Smalltalk garbageCollect. "We perform a garbageCollect before each execution"
		self run: confName iteration: i
	]
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> schema: config [

	^ schemas at: config
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> schemaCorpusWith: mutators [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> seeds [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> stochasticMutators [

	^ { (UmeAddByteMutator new maxInputSize: self maxInputSize).
		  UmeByteFlipMutator new.
		  UmeDelByteMutator new }
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> stochasticSchema [

	^ self schemaCorpusWith: self stochasticMutators
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> targetMethod [

	self subclassResponsibility 
]

{ #category : 'running' }
GrammarBasePathologicalBugMutatorPaperExperiment >> weightedGrammarSchema [

	self subclassResponsibility 
]
