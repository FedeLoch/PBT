Class {
	#name : 'PBTGrammarParserTest',
	#superclass : 'TestCase',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'tests' }
PBTGrammarParserTest >> testParseJsonObject01 [

	| node |

	node := PBTGrammarParser parse: '4' from: JSONGrammar new.
	
	self assert: node generate equals: '4'
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseJsonObject02 [

	| node |

	node := PBTGrammarParser parse: '{}' from: JSONGrammar new.
	
	self assert: node generate equals: '{}' 
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseJsonObject03 [

	| node |

	node := PBTGrammarParser parse: '[]' from: JSONGrammar new.
	
	self assert: node generate equals: '[]'
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseJsonObject04 [

	| node |

	node := PBTGrammarParser parse: 'true' from: JSONGrammar new.
	
	self assert: node generate equals: 'true'
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseJsonObject05 [

	| node |

	node := PBTGrammarParser parse: '[42,true]' from: JSONGrammar new.
	
	self assert: node generate equals: '[42,true]'
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseJsonObject06 [

	| node json |

	json := '{"n":true,"n":true,"x":6}'.
	node := PBTGrammarParser parse: json from: JSONGrammar new.
	
	self assert: node generate equals: json
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseMarkdown01 [

	| node input |

	input := '# Header'.
	node := PBTGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseMarkdown02 [

	| node input |

	input := '# Header', Character cr asString, '# This is a line comment'.
	node := PBTGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseMarkdown03 [

	| node input |

	input := '# Header
** This is a line comment **'.
	node := PBTGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseRegex01 [

	| node input |

	input := 'b?ab?b?b?(ac?ab?(aca((ac))?|b)?a|c)?c?'.
	node := PBTGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]
