Class {
	#name : 'PBTRegex',
	#superclass : 'Object',
	#instVars : [
		'regexString',
		'regex'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'instance creation' }
PBTRegex class >> fromString: aString [

	^ self new
		  regexString: aString;
		  yourself
]

{ #category : 'instance creation' }
PBTRegex class >> stonAllInstVarNames [ 

	^ super stonAllInstVarNames copyWithout: #regex
]

{ #category : 'compiling' }
PBTRegex >> compileRegex [

	^ regexString asRegex
]

{ #category : 'compiling' }
PBTRegex >> matches: aString [ 
	
	^ self regex matches: aString
]

{ #category : 'compiling' }
PBTRegex >> regex [

	^ regex ifNil: [ regex := regexString asRegex ]
]

{ #category : 'compiling' }
PBTRegex >> regexString [

	^ regexString
]

{ #category : 'compiling' }
PBTRegex >> regexString: anObject [

	regexString := anObject
]
