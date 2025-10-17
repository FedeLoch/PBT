Class {
	#name : 'PBTMicrodownTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTMicrodownTest >> markdownGenerator [

	self subclassResponsibility 
]

{ #category : 'accessing' }
PBTMicrodownTest >> seed [

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
PBTMicrodownTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.

	schema := PBTSchema new
		          receiverConstraint: (PBTObjectConstraint new generator: (PBTConstantGenerator new value: Microdown));
		          argumentConstraints: { PBTObjectConstraint new objectClass: String; generator: self markdownGenerator };
		          score: [ :re :inputs :res | 1 ];
		          assert: [ :regex :input :result | true ].
]
