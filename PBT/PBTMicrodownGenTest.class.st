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
PBTMicrodownGenTest >> test_1051104256 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r.#-.\r- [x]\r..\r- [x] L#\r- [x] #’\r- [x]\t:\r- [x]\t.bk-\r- [ ]\t’zz:\r- [x]\t’\r- [ ]\rx-\r- [ ]\tp\r- [ ]\t#::\r- [x]\r::'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_1065587456 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['**’pZ-****W.. >**[#](:)@ @`#,upT>`![-.dR:](xQWV)**###,**[q:H](Y)*q:*[O](::>)/** ’##:**'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_136354304 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['`,#.`@ @**.**`’`'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_193782528 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r-\r- [x]\r,.S.\r- [ ]\r #’\r- [ ] -\r- [x]\t--\r- [x]\t \r- [x] >.’\r- [ ]\tl #B##:\r- [ ]\tZ’\r- [ ]\ri\r- [ ]\tV\r- [ ]\t:::\r- [ ]\r: \r- [ ]\r-\r- [ ] >\r- [x] ’\r- [x]\r,.\r- [ ]\r>\r- [ ]\t,\r- [ ]\r,\r- [x]\t/#'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_228035328 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r:#H \r- [ ]\r.’-\r- [x]\r.-\r- [x]\t’\r- [x]\t.\r- [x]\t>V’IT\r- [ ] D-\r- [ ]\rxbq\r- [ ]\t>:\r- [x]\rK:  #\r- [x]\r/: -'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_230656 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [x]\r#R\\\r- [ ]\r..’\r- [x]\t \r- [x]\t-\r- [x]\t’>,:C#:-\r- [ ]\t>oV\\\r- [ ]\rsa:\r- [ ]\r,’>\r- [ ]\t:\r- [ ]\t\\ -\\\r- [x]\r: \r- [x] ’\r- [ ]\r\\\r- [ ]\r\\\r- [x]\r#,\r- [x]\r,\r- [x]\r.\r- [ ]\t-\r- [ ]\r--\r- [ ]\r \r- [x]\r \r- [x]\r-H\r- [ ]\t \r- [ ]\r ,\r- [ ]\t’#n,'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_236902656 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [x]\r#R\\\r- [ ]\r..’\r- [x]\t \r- [x]\t-\r- [x]\t’>,:C#:-\r- [ ]\t>oV\\\r- [ ]\rsa:\r- [ ]\r,’>\r- [ ]\t:\r- [ ]\t\\ -\\\r- [x]\r: \r- [x] ’\r- [ ]\r’\r- [ ]\r#\r- [x]\r,.\r- [x]\r,\r- [ ]\t.\r- [ ]\t-\r- [ ]\r- \r- [x]\t#\r- [ ]\rm'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_2604032 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r..#\r- [ ]\t#’.\r- [x]\r.-\r- [x] ’\r- [x]\t.\r- [x] >’mDY\r- [ ]\rmjc:\r- [ ]\taM#'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_278477312 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['|:-W| |\r| ----------- |\r|##-.W|L#.| |,CQ|#:\\: ’#|#|-|'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_292121600 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [x]\r#R\\\r- [ ]\r..’\r- [x]\t \r- [x]\t-\r- [x]\t’>,:C#:-\r- [ ]\t>oV\\\r- [ ]\rsa:\r- [ ]\r,’>\r- [ ]\t:\r- [ ]\t\\ -\\\r- [x]\r: \r- [x] ’\r- [ ]\r’\r- [ ]\r’\r- [ ]\r:,\r- [x]\r,\r- [ ] .\r- [ ]\r-\r- [ ]\r--'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_345921024 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [x]\r#R\\\r- [ ]\r..’\r- [x]\t \r- [x]\t-\r- [x]\t’>,:C#:-\r- [ ]\t>oV\\\r- [ ]\rsa:\r- [ ]\tA>\r- [ ]\tV   \r- [x]\t:\r- [x]\r/’-\r- [x]  \r- [ ]\r#\r- [ ] #\r- [x]\r,,\r- [x]\r.\r- [ ]\t>\r- [ ]\r#\r- [x]\t, '].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_372356864 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [ ]\r.#\r- [x]\r/#-\r- [x]\r-.\r- [ ]\t-\r- [ ]\r#\r- [x]\t’uvH:\r- [x]\t.beh\\: \r- [ ]\tnd#\r- [ ]\tZ’\r- [ ]\tN\r- [x] : \r- [x]\tI-\r- [x]  #'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_375983872 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [x]\r#R\\\r- [ ]\r..’\r- [x]\t \r- [x]\t-\r- [x]\t’>,:C#:-\r- [ ]\t>oV\\\r- [ ]\rsa:\r- [ ]\r,’>\r- [ ]\t:\r- [ ]\t\\ -\\\r- [x]\r: \r- [x] ’\r- [ ]\r’\r- [ ]\r’\r- [ ]\r:,\r- [ ]\rP\r- [x]\rd\r- [ ]\t:\r- [ ]\r--\r- [x]\r-\r- [ ]\tv\r- [ ]\t, '].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_407132160 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [ ]\r#-’\r- [x]\r#/\r- [x]\t-\r- [x]\t’-o.uR\r- [x]\t’ArU.\r- [x]\t,n:N\r- [ ]\r’g:\r- [ ]\r#y\r- [ ]\tS:: \\\r- [ ]\t>:>\r- [x]\t ’\r- [x]\r:’#\r- [x]\r-#\r- [ ]\r\\,W\r- [ ]\r#,.\r- [x]\r.\r- [x]\r,\r- [ ]\t#\r- [ ]\r--\r- [ ]\r \r- [ ]\tf'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_416220928 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['```\r\r:--I ```'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_419323648 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r..#\r- [ ]\t#’.\r- [x]\r.-\r- [x] ’\r- [x]\t.\r- [ ]\t/’MP:\r- [ ] ,zzZ\r- [ ]\rpW:\r- [x] yP\r- [x]\t>'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_423536640 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['```\r\r\r \r```'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_471543040 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r.\\..\r- [x]\r D\r- [x] ##\r- [x] -\r- [x]\t.\r- [ ]\t.mY#>\r- [ ]\t’’\r- [ ]\rpZJ\r- [ ]\tc:\r- [ ]\tP#  -\r- [ ]\r::>\r- [ ]\r:-\r- [ ] -\r- [x] #\r- [x] ,\r- [ ] >T\r- [x]\r>,>#'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_510673920 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['[. ](.X)'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_530867968 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['`:F’K`**#-#**[Y]( )@i@'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_550824448 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r.\\..\r- [x]\r D\r- [x] ##\r- [x] -\r- [x]\t.\r- [ ]\t.mY#>\r- [x]\t’/pi\r- [ ]\rpZJ\r- [ ]\tc:\r- [ ]\tP#  -\r- [ ]\r::>\r- [ ]\r:-\r- [x] ’#\r- [x]  '].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_550834688 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r:#H \r- [ ]\r.’-\r- [x]\r.-\r- [x]\t’\r- [x]\t.\r- [x]\t>V’IT\r- [ ] ’\r- [ ]\rmt#\r- [ ]\t::'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_556664320 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['**,DI-****A#.**[.#]( )@.@`--.#HN`![--.\\G](#)-,![#BK](..)'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_58994176 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['4. :'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_723428864 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.:#.#\r- [x]  ’’’>\r- [ ]\r.-\r- [x] B \r- [x]\t.\r- [ ]\rB'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_746031360 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['**..’’***-#/->,qPK*[X-](:)@.@`:-fn’q`![>’G](..iK)**jcEZ**[qi](X>)[kF](V)[Y](/ .##::#:/)@G >>#:@X'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_769009920 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.’’\r- [x]   #\r- [ ]\r/-F\r- [ ]\r. :.\\l/>\r- [x] ’\r- [x]\t  :,c:'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_779910656 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r:#H \r- [ ]\r.’-\r- [x]\r.-\r- [x]\t’\r- [x]\t.\r- [x]\t>V’IT\r- [x]\r-#\r- [ ]\rxbq\r- [ ]\t>:\r- [x]\rK:  #\r- [x]\r/: -'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_782356480 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['~.~'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_79090944 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['~~:~~'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_797326080 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x] #,\r- [x]\r..\r- [x]\r##\r- [x]\t’\r- [x]\tE.-n\r- [x]\t>’L/:\r- [ ]\t#’tP\r- [x]\rvX:\r- [ ]\twP\r- [ ]\tdG :\r- [x]\t::’#\r- [ ]\r> \r- [x]\r-\r- [x] -\r- [ ]\r#'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_799421184 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.:#.#\r- [x]  ’’’>\r- [ ]\r.-\r- [x] B \r- [x]\t.\r- [x]\t-’vxK:'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_804054016 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['>#s#.c{#.}:'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_847851776 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['`. .F`'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_85950464 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r-\r- [x]\r,.S.\r- [ ]\r #’\r- [ ] -\r- [x]\t--\r- [x]\t \r- [x] >.’\r- [ ]\tl #B##:\r- [ ]\tZ’\r- [ ]\ri\r- [ ]\tV\r- [ ]\t:::\r- [ ]\r: \r- [ ]\r-\r- [ ] >\r- [x] ’\r- [x]\r,.\r- [x] ->V,\r- [ ]\rL’M'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_869694720 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['|:-W|>\\|\r| ----------- |\r|##-.W|L#.| |,CQ|#:\\: ’#|#|-|'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_913300736 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['![aG’I](#.#)** ..**[#](:)@:@'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_915980800 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [ ]\r#,.#-\r- [x]\r:>-\r- [x]\r#R\\\r- [ ]\r..’\r- [x]\t \r- [x]\t-\r- [x]\t’>,:C#:-\r- [ ]\t>oV\\\r- [ ]\rsa:\r- [ ]\r,’>\r- [ ]\t:\r- [ ]\t\\ -\\\r- [x]\r: \r- [x] ’\r- [ ]\r\\\r- [ ]\r\\\r- [x]\r#,\r- [x]\r,\r- [x]\r.\r- [ ]\t-\r- [ ]\r- \r- [x]\t’\r- [ ]\r-\r- [ ]\rO '].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_950874112 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['**  ’#****W.. >**[#](:)@ @`#,upT>`**-,’Y#***u#\\W*'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTMicrodownGenTest >> test_960004352 [
	
		self doTest: {
			'method' -> (Microdown class>>#parse:) selector.
			'receiver' -> 'Class[#Microdown]'.
			'arguments' -> ['- [x]\r.\r- [x]\r.#-.\r- [x]\r..\r- [x] L#\r- [x] #’\r- [x]\t:\r- [x]\t.bk-\r- [ ]\t’zz:\r- [ ]\rMHJ\r- [ ]\tf#:: \r- [ ]\t:\r- [x]\r: -#\r- [x] :-'].
		} asDictionary
	
]
