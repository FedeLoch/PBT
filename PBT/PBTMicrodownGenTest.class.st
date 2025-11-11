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
			(PBTTreeGrammarMutator from: ExtendedMarkdownGrammar new) maxInputSize: 300
		}
	}
]

{ #category : 'running' }
PBTMicrodownGenTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests: 5 minutes
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
PBTMicrodownGenTest >> test_1011356672 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\t\\\r- [ ]\r>'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_101284096 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['`,``/`![>,,>](->\\,)[>-](  :f)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_1062694144 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\rJ>\r- [x]\t>\r- [x]\r>\r- [x]\t>\\// \r- [x] ,,>>\r- [ ]\r\\\\ /:\r- [ ]\t/’\r- [ ] .\r- [x]\r,:\r- [x]\r>:\r- [x]\t’\r- [ ]\rS’\r- [x]\t’'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_107891712 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['**>**[\\.](/)![//](/)[, \\>](>, ,::)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_108195584 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['8.\r’\\’'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_162477824 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['###\r# ’'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_194171392 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x] \\\r- [x]\r>\r- [x]\r>\r- [x]\r/\\>o\r- [ ]\t\\  \r- [ ]\r>// \\\r- [x]\r >\r- [ ]  \r- [x] . \r- [x] :\r- [x]\rm\r- [x]\t\\/\r- [ ]\r/\r- [ ]\t/-q\r- [ ]\t’g\r- [ ]\r \r- [ ] d\r- [ ]\r:\r- [ ] ,\r- [ ] .\r- [x]\r  \r- [x]\rZ\r- [ ]\r ,,\r- [ ]\r>,\r- [ ]\r,\r- [ ] ,\r- [ ] Z\r- [ ]\rT \r- [x]  \r- [x]\r >>\r- [ ]\t,\r- [ ] \\,\r- [ ]\r\\.\r- [ ] p\r- [ ] i\r- [ ]\ro,#'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_209009920 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\\r- [x]\r>\r- [x]\r>\r- [x]\r/\\\\\r- [ ]\t\\\\/y  \r- [ ]\t>>/\r- [x]\r\\ \r- [ ]\r . \r- [x]   \r- [x]  \r- [x] mt\\\r- [x]\r\\\\\r- [ ]\r/\r- [ ]\r//r\r- [ ]\t--\r- [ ] \\\r- [ ]\ri\r- [ ]\r:\r- [ ]\r:’\r- [ ] ,\r- [x] .’#\r- [x]\r’\r- [ ]\t>,\r- [ ]\rO,\r- [ ]\r,\r- [ ] ,\r- [ ] B\r- [ ] - \r- [ ]\r \r- [x]\r’>,\r- [x]\r>\r- [ ]\t>w#'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_231255040 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['|/|b:-m|\r| -----------| ----------- |\r|>|>|>-\\.>|-|'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_265454848 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['[\\](\\)`\\:>`*/   #**,>/ .*'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_26979072 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['**>**`/`>qs-/#.*h*'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_272127232 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x] \\\r- [x]\r>\r- [x]\r>\r- [x]\r/\\>o\r- [ ]\t\\\\E.\r- [ ]\r>// \\\r- [x]\r >\r- [ ]  \r- [x] . \r- [x] :\r- [x]\rm\r- [x]\t\\/\r- [ ]\r/\r- [ ]\t/-q\r- [ ]\t’g\r- [ ]\r \r- [ ] d\r- [ ]\r:\r- [ ] ,\r- [ ] .\r- [x]\r’rH\r- [x]\rZ\r- [ ]\r ,,\r- [ ]\r,,\r- [ ] #\r- [ ] F\r- [ ]\r/\r- [x]\t-\r- [x]\t,'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_274305792 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\t\\\r- [x]\r>\r- [x]\r/\r- [x]\t \\\\\r- [ ]\r,> .>\r- [ ]\t/>,\r- [x] -/'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_294754816 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['`\\``/`![>>, -](  )[’   ](>-l#)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_322414848 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['@#@![ ](:: />)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_326275328 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['|#|, >>|’#|#|:’|’|\r| -----------| -----------| -----------| -----------| -----------| -----------| -----------| ----------- |\r|>|/|\\ ,m|'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_368278272 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\\r- [ ]\r>\r- [x]\r#\r- [x]\t/> >>\r- [ ]\r\\-\\.\r- [ ]\r> \r- [ ]\r/#\r- [ ]\t/\r- [x]  :\r- [x]\rf\r- [x]\t\\\r- [x]\t//\r- [ ]\t’\r- [x]\t’:  \r- [x] E,\r- [ ] >,\r- [ ]\r’\r- [ ] ,\r- [ ] . \r- [ ]\rU\r- [x]\rf ,\r- [x]\rC\r- [ ]\t.,-\r- [ ] ##-\r- [ ] >\r- [ ] /\r- [x]  \r- [x]\t’>'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_399527424 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['[\\](-)`\\:>`*/   #**:y*'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_415838720 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['-\r’’'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_420927232 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\\\\r- [x]\r’\r- [x]\r>\r- [x]\r  \\/.\r- [ ]\t->>-,\r- [ ]\r#\r- [x]\t->\r- [x]\r,\r- [x]\r’\r- [x]\t’\r- [x]\t/\r- [x]\t’,\r- [x]\r’\r- [ ]\t’\r- [x]\r#C \r- [ ] :c\r- [ ]  \r- [ ] ,\r- [x] ’.\r- [ ] ,\r- [x]\r,hU\r- [ ]\r’’\r- [ ]\tN\r- [ ]\t/#\r- [ ] #\r- [ ] P\r- [ ]\r-\r- [x]  \\'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_4265984 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x] \\\r- [x]\r>\r- [x]\r>\r- [x]\r/\\>o\r- [ ]\t\\\\E.\r- [ ]\r>// \\\r- [x]\r >\r- [ ]  \r- [x] . \r- [x] :\r- [x]\rm\r- [x]\t\\/\r- [ ]\r/\r- [ ]\t/-q\r- [ ]\t’g\r- [ ]\r \r- [ ] d\r- [ ]\r:\r- [ ] ,\r- [ ] .\r- [x]\r’rH\r- [x]\rZ\r- [ ]\r ,,\r- [ ]\r,,\r- [ ] #\r- [ ] F\r- [ ] -\r- [ ]  ’\r- [x]\r,\r- [x]\t>>,\r- [ ]\t,\r- [x]\r\\>\r- [ ] m-\r- [ ]\r.\r- [ ] /'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_476668672 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['```\r\\’\r\r\r\t\r\r\r```'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_532267776 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['**/**`>`'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_5392384 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r>>\r- [x]\r>\r- [x]\r/\r- [x]\t \\\\\r- [ ]\r,> .>\r- [ ]\r/> \r- [ ]\r/\r- [ ] ,\r- [x]\r>’\r- [x]\t:\r- [x]\t/'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_553019904 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['`>>``/:`![ ,>-.](   )[>-](  :f)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_602110976 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\t \r- [x]\r>\r- [x]\r>\r- [x]\r/ /\\ \r- [x]\r,>n,,:\r- [ ]\r,>>\r- [x]\r//\r- [ ] >>>\r- [x]\r.>\r- [x]\r’\r- [x]\t’\r- [ ]\t/#\r- [ ]\t’\r- [x]\r’>:>\r- [ ] .’’'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_683613952 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['`l``\\``’ >>`**,,---**'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_709576960 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['**>**[/](>\\,>)![//](,/)[, \\>](>, ,::)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_733969920 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['\\*:*'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_781902848 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['```\r\r\r\t’’ ```'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_804663552 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['**>**[\\.](/)![>](:)![,>,/](,> ,)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_821428736 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\>\r- [x]\r>\r- [x]\r>\r- [ ]\t/,,>/ :\r- [x]\t \\/\r- [ ]\t,\\,\r- [ ]\r> \r- [ ]\r>\r- [x] >>\r- [x]\r’\r- [x]\t\\\r- [x]\t#’\r- [ ]\r’\r- [x] -: \\'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_843232768 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\>\r- [x]\r>\r- [x]\r>\r- [ ]\t/,,>/ :\r- [x]\t \\/\r- [ ]\t,\\,\r- [ ]\r> \r- [ ]\r>\r- [x] >>\r- [x]\r:\r- [ ]\t>\r- [x]\t-’\r- [x] ’\r- [ ]\t#K-’.\r- [x] BR>,\r- [ ] \\ \r- [ ]\r.\r- [ ] :\r- [ ] e\r- [x]\t/\r- [ ]\r,-,\r- [x]\r \r- [ ]\t.#/\r- [x] -\r- [ ] >-'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_844176896 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x] \\\r- [x]\r>\r- [x]\r-\r- [x]\r  >-,\r- [x]\r#\\\r- [x]\r  l \r- [ ] >.\r- [x]\r>\r- [ ] >#\r- [x] .\r- [x]\t:P\\\r- [x]\r’/\r- [x]\r’\r- [x]\r/# ,\r- [x]\r’Y \r- [ ] o’\r- [ ] >'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_876326912 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\\r- [ ]\r>\r- [x]\r#\r- [x]\t/> >>\r- [ ]\r\\-\\.\r- [ ]\r> \r- [ ]\r/#\r- [ ]\t/\r- [x]  :\r- [x]\rf\r- [x]\t\\\r- [x]\t//\r- [ ]\t’\r- [x]\t’:  \r- [ ]\r,v\r- [ ] >,\r- [ ]\r’\r- [ ] ,\r- [ ] . \r- [ ]\rU\r- [x]\rf ,\r- [x]\rC\r- [ ]\t.,-\r- [ ] ##-\r- [ ] >\r- [ ] /\r- [x]  \r- [x]\t’>'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_888955136 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\t \r- [x]\r>\r- [x]\r>\r- [x]\r/ /\\ \r- [x]\r,>n,,:\r- [ ]\r,>>\r- [x]\r//\r- [ ] >>>\r- [x]\r.>\r- [x]\r’\r- [x]\t’\r- [x]\t/#\r- [x]\r’\r- [x]\r’Q :\r- [x] #,.\r- [ ]   \r- [ ]\r,\r- [ ] .\r- [ ]\t \r- [ ]\rB'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_933862656 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['~~->~~'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_953382912 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['**\\**`>`'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_955901440 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['![/](/)`##:>\\`'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_967509760 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['- [x]\r\\>\r- [x]\r>\r- [x]\r>\r- [ ]\t/,,>/ :\r- [x]\t \\/\r- [ ]\t,\\,\r- [ ]\r> \r- [ ]\r>\r- [x] >>\r- [x]\r:\r- [ ]\t>\r- [x]\t-’\r- [x] ’\r- [ ]\t#K>#\r- [x]\t -.\r- [ ]\r,,\r- [x] j'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_981786624 [
	
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: 'Class[#Microdown]'.
		arguments := STON fromString: ['`\\``/`![>>-,r.](  -.)[,> ](/:-)'] asString.
		
		targetSelector := (Microdown class>>#parse:) selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	
]
