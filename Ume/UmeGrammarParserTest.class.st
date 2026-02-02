Class {
	#name : 'UmeGrammarParserTest',
	#superclass : 'TestCase',
	#category : 'Ume-Grammar Parser',
	#package : 'Ume',
	#tag : 'Grammar Parser'
}

{ #category : 'tests' }
UmeGrammarParserTest >> testParseCsv01 [

	| node input |

	input := 'id,first_name,last_name,email,gender,n
1,Jeannine,Sutehall,jsutehall@lulu.com,Female,250
2,Lynnette,Pashbee,lpashbee@blogger.com,Female,380
3,Garrick,Fontell,gfontell@sitemeter.com,Male,412
4,Osbert,O''Henecan,oohenecan@senate.gov,Male,242
5,Doug,Vieyra,dvieyra@chronoengine.com,Genderfluid,525'.
	node := UmeGrammarParser parse: input from: CSVGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseJsonObject01 [

	| node |

	node := UmeGrammarParser parse: '4' from: JSONGrammar new.
	
	self assert: node generate equals: '4'
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseJsonObject02 [

	| node |

	node := UmeGrammarParser parse: '{}' from: JSONGrammar new.
	
	self assert: node generate equals: '{}' 
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseJsonObject03 [

	| node |

	node := UmeGrammarParser parse: '[]' from: JSONGrammar new.
	
	self assert: node generate equals: '[]'
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseJsonObject04 [

	| node |

	node := UmeGrammarParser parse: 'true' from: JSONGrammar new.
	
	self assert: node generate equals: 'true'
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseJsonObject05 [

	| node |

	node := UmeGrammarParser parse: '[42,true]' from: JSONGrammar new.
	
	self assert: node generate equals: '[42,true]'
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseJsonObject06 [

	| node json |

	json := '{"n":true,"n":true,"x":6}'.
	node := UmeGrammarParser parse: json from: JSONGrammar new.
	
	self assert: node generate equals: json
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseMarkdown01 [

	| node input |

	input := '# Header'.
	node := UmeGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseMarkdown02 [

	| node input |

	input := '# Header', Character cr asString, '# This is a line comment'.
	node := UmeGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseMarkdown03 [

	| node input |

	input := '# Header
** This is a line comment **'.
	node := UmeGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseMarkdown04 [

	| node input |

	input := '# Header
** This is a line comment **'.
	node := UmeGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseMarkdown05 [

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
	node := UmeGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseMarkdown06 [

	| node input |

	input := '```  ```'.
	node := UmeGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseRegex01 [

	| node input |

	input := 'b?ab?b?b?(ac?ab?(aca((ac))?|b)?a|c)?c?'.
	node := UmeGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseRegex02 [

	| node input |

	input := 'aa*a*..*.+(.+.?(.?.*((.b.b.aab)a|)a*))+a'.
	node := UmeGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseRegex03 [

	| node input |

	input := '(a|a|a|a|a|a|c)+a?a+.(a)+(a+a+a+(a)+a)b'.
	node := UmeGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseRegex04 [

	| node input |

	input := 'a+(a+a.?(a*.*a?a*a*b?.*aa?a+|a)+a.a)....a'.
	node := UmeGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
UmeGrammarParserTest >> testParseRegexN [

	| inputs |
	inputs := { 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'.
	          'ac?ab?ab|.b?aa.?aaab?c?a(ca)?ac?aaab?a?a'.
	          'ac?ab?ab?b?aa.?aaab?c?a(c)?abc?aa*ab?a?a'.
	          'ac?ab?ab?ab?aa.?aaa*b?c?a(c)?ac?aacb?a?a'.
	          'ac?ab?ab?ab?aa.?aaa*b?c?a(c)?cc?aacb?a?a'.
	          'ac?aa?ab?ab?aa.?aaa*b?c?a(c)?ac?aaca+a?a'.
	          'ac?aa?ab?ab?aa.?aaa*a?c?a(c)?ac?aaca?a?a'.
	          'ac?aa+ab?ab?aa.?aaa*a?c?a(c).accaaca?a?a'.
	          'ac?aa?ab?ab?aa.?aaa*a?a?a(c)?aa?aa+a?a?a'.
	          'ac.aa?ab?ab?aa.?aaa*a?c?a(c)?ac+aaca?a?a'.
	          'ac?aa?aa?.b?aa.?aaa*a?a?a(c)?aa?aa+a?a?a'.
	          'ac?aa?aa?.b?aa.?aaa*a?a?b(.)?aa?aa+a?a?a'.
	          'a.?aa?aa|.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?a'.
	          'ac?aaaab?ab?aa.?aaa*a?c?a(c)?a.+aaca?a?a'.
	          'a.?aa?aa|.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?b'.
	          'ac?aaaaa?.c?aa.?aaa*a?a?a(c)?aa?aa+aaa?a'.
	          'a.?aabaa|.b?aa.?aaa*a?aba(c)?aa?|a+a?a?a'.
	          'ac?aaaaa?.c?aa.?aaa*a?a?a(c)*aa?ab+aaa?a'.
	          'ac?aaaaa?.c?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaaaa?.a?aa.?caa*a?a+a(c)aaa?aa+aaa?a'.
	          'ac?aaa+a?.c?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?c*a+a?.c?aa.?aaa*a?a+a(c)?aa?aa+aaaba'.
	          'aa?aaa+a?.c+aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa+aa.c?aa.?aaa*a?a+a(c)?aa?aa+aca?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?a'.
	          'ac?aaa+a?.c?aa.?aca*a?a|a(c)?aa?aa+aaa?a'.
	          'ac?aaa+a?.c?aa.caaa*a?a.a(c)?aaaaa+aaa?a'.
	          'ac?aaa?a?.c?aa.?aaa.a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa+a?.c?aa.?aaa*a?a+c(c).aa?aa+aaa|a'.
	          'ac?aaa+a?.c?aa.?aaa*a?a+a(c)?aa?ac+aba?a'.
	          'ac?aaa+a?.c?aa.?aaaaa?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa+a?.c?aaa?aaa*a?a?a(c)?aa?aa?aaa?a'.
	          'ac?aaa+a|.c?aa.?aaa*a?a+a(c)?aa?aaaaaa?a'.
	          'ac?aaa+a?.c?aa.?aab*aaa+a(c)?aa?aa+aaa?a'.
	          'a.?aa.aaa.b?aa.?aac*a?a?a(c)?aa?|a+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?a*c|a+a?a|a'.
	          'ac?aa.+a?ac?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa?a?.c?aa.?aaa*a?a+a(c)?aa?aa+aba?a'.
	          'ac?aaaaa|bc?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaacac.c?aa.?aaa*a?a+a(c)?aa?aacaaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a|a?a(c)?aa?|a*a|a?a'.
	          'ac?aaa+a?.c?aa.aaaaca?a+a(c)?aabaa+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?.?a(c)?aa?|aaa?aaa'.
	          'ac?aaa+a?.c*aa.?aaaaa?a+|(c)?aa?aa+aaa?a'.
	          'ac?aaaba?bc?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac*aaa+a?.c?aa.?aaa*a?aca(c)?aaaaa+aaa?a'.
	          'ac.aaa+a?.c?aa.?a+a*a?a+a(c)?aa.aa+aaa?a'.
	          'ac.aaa+a?.c?aa.?a+a*a?a+a(c)?aaaaa+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?aa?|a+c?a?a'.
	          'ac.aaa+a?.c?aa.?a+a*a?a+a(c)?aa.aa+a+a?a'.
	          'a(.aaa+a?.c?a|.?a+a*a?a+a(c)?aa.aa+aaa)a'.
	          'ac.aaa+a?.c?aa.?a+a(a?a)a(c)?aa.aa+aaa?a'.
	          'ac.a+a+a?.c?aa.?.+a*a?a+a(c)?aa.aa+aaa?a'.
	          'ab.a+a+a?.c?aa.?.+a*a?a+a(c)?aa.aa+caa?a'.
	          'ac.a+a.a?.c?aa.?.+a*a?a+a(c)?aa.|a+a*a?a'.
	          'ac.a+b+a?.c?aa.?.+a*a?a+a(a)?aa.?a+aaa?a'.
	          'ac.a+a+a?.c?aa.?.+a*a?a+a(c)*aa.aa+aaa?a'.
	          'a.?aa?aa+.b?aa.?aaa*a?a?a(c)+ab?|a+a?a?a'.
	          'ac.a+.+a?.c?aa...+a*a?a+a(c)baa.aa+aaa?a'.
	          'ac.a+a+a?.c?aa.?.ba*a?a+a(a)?aa.aa+baa?a'.
	          'ac.aca+a?.c?aa.?.+a*aac+a(c)?aa.aa+aaa?a'.
	          'ac.a+a+a..c?aa.?.+a*a?a+a(c)?aa.aa+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?aa?|a+a?.aa'.
	          'a.?aa?aaa.c?aa.?aaa+a?a?a(c)?aa?|a+a?a?a'.
	          'ab.a+a+a?.c+aa.?.+a*a?a+a(c)?aa.aa+aaa?a'.
	          'ac?aa?aaa.b?aa.?aaa+a?a?a(c)?aa?|a+a?a?a'.
	          'a.?aa?baa.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?a'.
	          'ac.a+a+a?.c?aa.?.+a*a?a+a(c)?aa.aa+a|a?|'.
	          'aa.a+a+a?.c?a+.?.ca*a?a+a(c)?aa.aa+aaa?a'.
	          'ac.a+a+c?.c?aa.?.+a*.?a+a(c)?aa.aa+aaa?a'.
	          'ac.a(a+a?.c?a|.?.+a*a?)+a(c)?aa.aa+aaa?a'.
	          'ac.a(a+aa.c?a|a?.+a*a?)+a(c)?aa.aa+aaa?a' }.

	inputs do: [ :input |
			| node |
			node := UmeGrammarParser parse: input from: GncRegexGrammar new.
			self assert: node generate equals: input ]
]
