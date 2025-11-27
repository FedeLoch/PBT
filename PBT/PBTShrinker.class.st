Class {
	#name : 'PBTShrinker',
	#superclass : 'Object',
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'as yet unclassified' }
PBTShrinker >> shrink: test [

	^ test
		receiver: (self shrinkReceiver: test receiver from: test);
		arguments: (self shrinkArguments: test arguments from: test)
]

{ #category : 'as yet unclassified' }
PBTShrinker >> shrinkArguments: arguments from: test [

	| candidates |
	candidates := OrderedCollection new.
	
	arguments doWithIndex: [ :arg :index |
		(self shrinkObject: arg) do: [ :shrunkArg |
			| newArgs |
			newArgs := arguments copy.
			newArgs at: index put: shrunkArg.
			candidates add: newArgs
		]
	].

	^ candidates
]

{ #category : 'as yet unclassified' }
PBTShrinker >> shrinkReceiver: receiver from: test [
]
