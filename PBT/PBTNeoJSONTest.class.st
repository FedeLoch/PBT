Class {
	#name : 'PBTNeoJSONTest',
	#superclass : 'PBTUnitTest',
	#category : 'PBT-Unit Testing Integration',
	#package : 'PBT',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
PBTNeoJSONTest >> argumentGenerators [

	^ {
		self corpusGenFrom: '{"n":true,"n":[],"x":6}' mpi: 3 mutators: {
			(PBTTreeGrammarMutator from: JSONGrammar new) maxInputSize: 100
		}
	}
]

{ #category : 'running' }
PBTNeoJSONTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests
]

{ #category : 'running' }
PBTNeoJSONTest >> receiverGenerator [ 

	^ self constantGen: NeoJSONReader
]

{ #category : 'running' }
PBTNeoJSONTest >> targetMethod [

	^ NeoJSONReader class >> #fromString:
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_1014990080 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[94],"x":6}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_1019548672 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[[{"":"b"}]],"l":{"vaxu":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_378488832 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"k":{"pa":{"jl":[""],"":false,"":[]},"x":[]},"n":[[{"j":1537,"d":7},true]],"l":{"vaxhc":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_676077312 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[[7]],"l":{"vaxu":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_745961728 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[[{"j":1537,"d":7},"dzc"]],"l":{"vaxu":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_833000192 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"k":{"pa":{},"x":[]},"n":[[{"j":1537,"d":7},true]],"l":{"vaxhc":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_86940160 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[],"l":{"vaxu":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_893509632 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[],"x":6}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_959270400 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[[{"j":1537,"d":7},"dzc"]],"l":{"vaxhc":true}}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]
