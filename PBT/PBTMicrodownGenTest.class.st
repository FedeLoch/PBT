Class {
	#name : 'PBTMicrodownGenTest',
	#superclass : 'PBTUnitTest',
	#category : 'PBT-Unit Testing Integration',
	#package : 'PBT',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
PBTMicrodownGenTest >> argumentGenerators [

	^ {
		self corpusGenFrom: 'a' mpi: 3 mutators: {
			(PBTGrammarDerivationMutator from: ExtendedMarkdownGrammar new) maxInputSize: 300
		}
	}
]

{ #category : 'running' }
PBTMicrodownGenTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests: 10 minutes
]

{ #category : 'running' }
PBTMicrodownGenTest >> receiverGenerator [ 

	^ self constantGen: Microdown
]

{ #category : 'running' }
PBTMicrodownGenTest >> targetMethod [

	^ Microdown class >> #parse:
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_102246656 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t.\r- [x]\t/\r- [x]\t,#\r- [x]\t>,\\\r- [x]\t\\.\r- [x]\t/##\r- [x]\t>>##\r- [x]\t,\r- [x]\t>>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>’#\r- [x]\t#>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>##’’\r- [x]\t>>\r- [x]\t,\r- [x]\t##\r- [x]\t>’’\r- [x]\t##\r- [x]\t>’’\r- [x]\t##\r- [x]\t>’’\r- [x]\t##\r- [x]\t>##\r- [x]\t>\r- [x]\t>>\r- [x]\t,>\r- [x]\t,\r- [x]\t##\r- [ ]\r\\>/'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_1055700736 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''` ``,`'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_123604736 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''![ ](,E\\/)[/,](#)'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_265502976 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''###\r>>'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_285262592 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''![ ]( >\\-/>)[. ’-\\-](>)[,-](Y)![\\#->## #z#-#](/)'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_310533888 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t..\r- [ ]\t.\r- [x]\t/-\r- [x]\t>\r- [x]\t’.\r- [x]\r\\\r- [x]\r,# -\r- [x]\r>\r- [x]\t#>\r- [x]\t>\r- [x]\t>># \r- [x]\t#\r- [x]\t--\r- [x]\t#.>-\r- [x]\r#’\r- [ ]\t \r- [x]\t# \r- [ ]\r#--\r- [x]\t# \r- [x]\t> -\r- [x] ’ ’>\r- [x]\t.\r- [x]\t#’\r- [x]\r#\r- [x]\t ##’\r- [x]\t-\r- [x]\t-#>-\r- [x]\t- \r- [x]\tA>\r- [x]\r,\r- [x]\t-#\r- [x]\tR  '']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_350809344 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t.\r- [x]\t/\r- [x]\t,#\r- [x]\t>,\\\r- [x]\t\\.\r- [x]\t/##\r- [x]\t>>##\r- [x]\t,\r- [x]\t>>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>’#\r- [x]\t#>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>##’’\r- [x]\t>>\r- [x]\t,\r- [x]\t##\r- [ ]\r,\r- [ ]\r>,'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_39187200 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''```\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r \r  \r\r\r\r\r\r\r\r\r\r \t\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t’ ```'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_428228352 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t.\r- [x]\t/\r- [x]\t,#\r- [x]\t>,\\\r- [x]\t\\.\r- [x]\t/##\r- [x]\t>>##\r- [x]\t,\r- [x]\t>>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>’#\r- [x]\t#>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>##’’\r- [x]\t>>\r- [x]\t,\r- [x]\t##\r- [x]\t>’’\r- [x]\t##\r- [x]\t>’’\r- [x]\t##\r- [x]\t>’’\r- [x]\t##\r- [x]\t>##\r- [x]\t>\r- [x]\t>>\r- [x]\t,>\r- [x]\t,\r- [x]\t##\r- [x]\t>’’'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_532077312 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t..\r- [ ]\t.\r- [x]\t/-\r- [x]\t>\r- [x]\t’.\r- [x]\r\\\r- [x]\r,# -\r- [x]\r>\r- [x]\t#>\r- [x]\t>\r- [x]\t\\>##\r- [x]\t#\r- [x]\t’ \r- [x]\r>\r- [x]\t’#\r- [x]\t>\r- [x]\t>,\r- [x]\t#’#\r- [x]\r\\’\r- [x]\r-#’\r- [x]\t>>>’\r- [x]\t#\r- [x]\r’#/#\r- [x]\t \r- [x]\r/’#\r- [x]\t \r- [x]\r>\\\r- [x]\r #\r- [x]\r>>\r- [x]\r>\r- [x]\r>-M \r- [x]\t#\r- [x]\t ,\r- [ ]\t’\r- [x]\r’'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_539532544 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''~~  ~~'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_558823680 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''![ ]( /)[-]( ’  -)'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_612167936 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''![ ](,E\\/)` `'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_647628544 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''>\r .'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_656077568 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t.\r- [x]\t/\r- [x]\t,#\r- [x]\t>,\\\r- [x]\t\\.\r- [x]\t/##\r- [x]\t>>##\r- [x]\t,\r- [x]\t>>’’\r- [x]\t,\r- [x]\t##\r- [x]\t>’#\r- [x]\t#>’’\r- [x]\t,\r- [x]\t##\r- [ ]\r\\\r- [x]\t>>\r- [x]\t,\r- [x]\t##\r- [ ]\r,\r- [ ]\r>,'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_764877056 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t’\r- [x]\t.\r- [x]\r >\r- [x]\r-\r- [x]\t\\/\r- [x]\t\\\r- [ ]\r:-\r- [x]\t,>>\r- [ ]\t# :’\r- [x] #\r- [ ]\t,>\r- [x]\t#-’##\r- [x]\t>’\r- [x]\t>\r- [x]\r,’\r- [x]\t-\r- [x]\t>-'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_766194944 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''8.\t -'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_776948480 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t -\r- [x]\t#\r- [ ]\t , .\\-\r- [x]\t/\r- [x]\t’,\r- [x]\t\\\r- [x]\t ,\r- [x]\t#V\r- [x]\t>>##\r- [x]\r-\r- [x]\t ’>\r- [ ]\t>\r- [x]\r#\r- [x]\r##-’#’\\\r- [x]\t- \r- [x]\r#\r- [x]\t#\r- [x]\t,\r- [x]\t>,\r- [x]\r’\r- [x]\t> #’\r- [x]\t#\r- [ ]\t>#\r- [x]\t-’\r- [x]\r#-\r- [x]\r#\r- [x]\r>>\r- [x]\r-.,\r- [x]\t>\r- [ ]\r>\r- [x]\r>U- \r- [x]\t#'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_784017152 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t./\r- [x]\t \r- [x]\t/’\r- [x]\t-\r- [x]\r#\\\r- [x]\r.\r- [x]\r#>>>\r- [x]\t#\r- [x]\t--\r- [x]\t \r- [x]\t>\r- [x]\t##,\r- [x]\t #\r- [x]\t’>- #\r- [x]\t #\r- [x]\rz\r- [x]\r’>\r- [x]\t-\r- [x]\t>#\r- [x]\t:\r- [x]\t#’ -'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_806208768 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t..\r- [ ]\t.\r- [x]\t/-\r- [x]\t>\r- [x]\t’.\r- [x]\r\\\r- [x]\r,# -\r- [x]\r>\r- [x]\t#>\r- [x]\t>\r- [x]\t\\>##\r- [x]\t#\r- [x]\t’ \r- [x]\t,\\-#>\r- [x]\t’#\r- [x]\t>\r- [x]\t>,\r- [x]\t#’#\r- [x]\r\\’\r- [x]\r-#’\r- [x]\t>>>’\r- [x]\t#\r- [x]\r’#/#\r- [x]\t \r- [x]\r/’#\r- [x]\t \r- [x]\r>\\\r- [x]\r #\r- [x]\r>>\r- [x]\r>\r- [x]\r>-M \r- [x]\t#\r- [x]\t ,\r- [ ]\t’\r- [x]\r’'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_85236992 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''![ ]( >\\-/>)[f#]( # >#)[,,/#>](\\\\-#>)@,,  @'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_875335936 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t..\r- [ ]\t.\r- [x]\t/-\r- [x]\t>\r- [x]\t’.\r- [x]\r\\\r- [x]\r,# -\r- [x]\r>\r- [x]\t#>\r- [x]\t>\r- [x]\t\\>##\r- [x]\t#\r- [x]\t’ \r- [x]\t,\\-#>\r- [x]\t’#\r- [x]\t>\r- [x]\t>,\r- [x]\t#’#\r- [x]\r\\’\r- [x]\r-#’\r- [x]\t>>>’\r- [x]\t#\r- [x]\r’#/#\r- [x]\t \r- [x]\r/’#\r- [x]\t \r- [x]\r>\\\r- [x]\r #\r- [x]\r>>\r- [x]\r>\r- [x]\t C-’\r- [x]\t#\r- [x] # \r- [x]\t-z\r- [x]\r--'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_883755776 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|’|-|-|-|-|-|-|-|-|’|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|\r| -----------| ----------- |\r| |'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_947127552 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''- [x]\t..\r- [ ]\t.\r- [x]\t/-\r- [x]\t>\r- [x]\t’.\r- [x]\r\\\r- [x]\r,# -\r- [x]\r>\r- [x]\t#>\r- [x]\t>\r- [x]\t\\>##\r- [x]\t#\r- [x]\t’ \r- [x]\r>\r- [x]\t’#\r- [ ]\r-\r- [x]\t>,\r- [x]\t#’#\r- [x]\r\\’\r- [x]\r-#’\r- [x]\t#’ >\r- [x]\t>\r- [x]\t##/##\r- [x]\t’\r- [x]\r- \r- [x]\t-\r- [x]\r> #, #\r- [x]\r>\r- [x]\r->\r- [x]\r>\r- [ ]\r- \r- [x]\r##’\r- [x]\t-.\r- [x] H’-'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_975084288 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|’|-|-|-|-|-|-|-|-|’|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|’|-|\r| -----------| ----------- |\r|’#|'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_975574272 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> '[''![                                                                 --](-)'']'.
		} asDictionary
	
]
