Class {
	#name : 'UmeMicrodownTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'schema'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeMicrodownTest >> markdownGenerator [

	self subclassResponsibility 
]

{ #category : 'accessing' }
UmeMicrodownTest >> seed [

	^ '# Header
	** This is a line comment **
	
	```
	code
	```
   
   	![Pharo is cool](http://pharo.org)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’`

  	References: @ref@'
]

{ #category : 'running' }
UmeMicrodownTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.

	schema := UmeSchema new
		          receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: Microdown));
		          argumentConstraints: { UmeObjectConstraint new objectClass: String; generator: self markdownGenerator };
		          score: [ :re :inputs :res | 1 ];
		          assert: [ :regex :input :result | true ].
]
