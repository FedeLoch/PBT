Class {
	#name : 'PBTGrammarTreeGeneratorTest',
	#superclass : 'TestCase',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject01 [

	| node |

	node := PBTGrammarTreeGenerator parse: '4' from: JSONGrammar new.
	
	self assert: node generate equals: '4'
]

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject02 [

	| node |

	node := PBTGrammarTreeGenerator parse: '{}' from: JSONGrammar new.
	
	self assert: node generate equals: '{}' 
]

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject03 [

	| node |

	node := PBTGrammarTreeGenerator parse: '[]' from: JSONGrammar new.
	
	self assert: node generate equals: '[]'
]

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject04 [

	| node |

	node := PBTGrammarTreeGenerator parse: 'true' from: JSONGrammar new.
	
	self assert: node generate equals: 'true'
]

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject05 [

	| node |

	node := PBTGrammarTreeGenerator parse: '[42,true]' from: JSONGrammar new.
	
	self assert: node generate equals: '[42,true]'
]

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject06 [

	| node json |

	json := '{"n":true,"n":true,"x":6}'.
	node := PBTGrammarTreeGenerator parse: json from: JSONGrammar new.
	
	self assert: node generate equals: json
]
