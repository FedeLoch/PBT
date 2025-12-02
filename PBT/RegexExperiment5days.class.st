Class {
	#name : 'RegexExperiment5days',
	#superclass : 'RegexExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'as yet unclassified' }
RegexExperiment5days class >> getResults: sourcePath at: index mutatorIndex: mIndex [

	| pathName instance |
	
"  1 -> { PBTAddByteMutator new maxInputSize: maxSize. PBTByteFlipMutator new. PBTDelByteMutator new }.
	2 -> { (PBTGrammarMutator from: self newGrammar) maxInputSize: maxSize }.
	3 -> { (PBTTreeGrammarMutator from: self newGrammar) maxInputSize: maxSize }"

	instance := self new.
	pathName := (instance mutatorLabel: (instance mutatorVariants at: mIndex)), instance pathName: index.

	^ STON fromStream: (sourcePath, pathName) asFileReference readStream
]

{ #category : 'running' }
RegexExperiment5days class >> run [ 

	^ (1 to: 10) collect: [ :i | self run: i ]
]

{ #category : 'running' }
RegexExperiment5days class >> run: iteration [

	self new run: iteration
]

{ #category : 'running' }
RegexExperiment5days >> mutatorLabel: mutators [

	^ '-mutators=', (mutators collect: #className) asString
]

{ #category : 'as yet unclassified' }
RegexExperiment5days >> pathName: index [

	^ 'RegexCS3MPI5Days-', index asString, '.ston'
]

{ #category : 'running' }
RegexExperiment5days >> run: iteration [

	self mutatorVariants do: [ :mutators |
		Smalltalk garbageCollect.
		self run: iteration seed: (self seeds at: 2) deepCopy mutators: mutators
	]
]

{ #category : 'running' }
RegexExperiment5days >> run: iteration seed: seed mutators: mutators [

	| schema runner result fileName  mpi |
	
	mpi := 3.
		
	fileName := (self mutatorLabel: mutators), (self pathName: iteration).
	
	schema := self schema: seed mutators: mutators mutationsPerIteration: mpi.
	
	runner := PBTRunner test: self targetMethod from: schema for: self experimentTime.
	
	"Guided by methods called"
	runner guidedByMethodsCalls.
	
	result := runner run.
	
	result writeToFile: fileName.
	
	^ result
]
