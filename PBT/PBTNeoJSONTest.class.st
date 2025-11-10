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
	super generateTests: 10 minutes
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
PBTNeoJSONTest >> test_336650240 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"":[{"":{},"":"","j":null,"":3144}],"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_508865536 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"qp":null,"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_517215232 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"uc":true,"":[{"":{"f":[]},"v":null,"znft":{"g":{"":[[[],"y",true]],"":false}},"":[]}],"w":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_637220608 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[],"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_651972096 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"uc":true,"":[{"":{"":[48,6]},"v":null,"znft":{"g":{"":"","":null,"":"","":""}},"":[]}],"w":2}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_685078784 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"uc":true,"":[{"":{"f":[]},"v":null,"znft":{"g":{"":[[[],"y",true]],"cbk":false}},"":[]}],"w":2}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_71209216 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[{"":{},"z":false,"j":null,"z":false}],"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_735987712 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"uc":true,"":[{"":{"f":[]},"v":null,"lwai":{"g":{"":[[[],{},true,[]]],"cbk":false}},"":[]}],"w":2}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_906356224 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"n":[{"":{},"z":false,"j":null,"gj":[]}],"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_921152256 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"":[{"":{},"z":false,"j":null,"gj":["",null,false]}],"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_923475712 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"":[{"":{"f":[]},"v":null,"znft":{"g":{"":[[7,true]],"":false}},"":[]}],"w":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_933075456 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"":[{"":{"f":[]},"v":null,"znft":{"g":{"":[[7,true]],"":false}},"":null}],"w":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_933597952 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"uc":true,"":[{"":{"":[false,["o"],[8,true]]},"v":null,"znft":{"g":{"":"","":null,"":"","":""}},"":[]}],"w":2}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_966690048 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#NeoJSONReader]'.
		arguments := STON fromString: ['{"n":true,"":[{"":{},"":false,"j":null,"gj":[["m",false]]}],"":3}'] asString.
		
		targetSelector := (NeoJSONReader class>>#fromString:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]
