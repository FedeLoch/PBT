Class {
	#name : 'PBTGrammarParserTest',
	#superclass : 'TestCase',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'tests' }
PBTGrammarParserTest >> testParseCsv01 [

	| node input |

	input := 'id,first_name,last_name,email,gender,n
1,Jeannine,Sutehall,jsutehall@lulu.com,Female,250
2,Lynnette,Pashbee,lpashbee@blogger.com,Female,380
3,Garrick,Fontell,gfontell@sitemeter.com,Male,412
4,Osbert,O''Henecan,oohenecan@senate.gov,Male,242
5,Doug,Vieyra,dvieyra@chronoengine.com,Genderfluid,525'.
	node := PBTGrammarParser parse: input from: CSVGrammar new.
	
	self assert: node generate equals: input
]

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
PBTGrammarParserTest >> testParseMarkdown04 [

	| node input |

	input := '# Header
** This is a line comment **'.
	node := PBTGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseMarkdown05 [

	| node input |

	input := '# Header
	** This is a line comment **
	
	```
	code
	```
   
   	![Pharo is cool](http://pharo.org)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’`

  	References: @ref@'.
	node := PBTGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseMarkdown06 [

	| node input |

	input := '```  ```'.
	node := PBTGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseRegex01 [

	| node input |

	input := 'b?ab?b?b?(ac?ab?(aca((ac))?|b)?a|c)?c?'.
	node := PBTGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
PBTGrammarParserTest >> testParseRegex02 [

	| node input |

	input := '(b?c*b+c+|()|a?)b?b'.
	node := PBTGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]
