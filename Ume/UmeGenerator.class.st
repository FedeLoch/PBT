Class {
	#name : 'UmeGenerator',
	#superclass : 'Object',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeGenerator class >> always: aValue [

	^ UmeConstantGenerator new value: aValue.
]

{ #category : 'as yet unclassified' }
UmeGenerator class >> base: baseBlock mutating: mutationBlock [

	^ UmeHillClimbingGenerator new genBase: baseBlock; mutate: mutationBlock 
]

{ #category : 'as yet unclassified' }
UmeGenerator class >> do: aBlock [

	^ UmeGenericGenerator new do: aBlock.
]

{ #category : 'as yet unclassified' }
UmeGenerator class >> onceInstance: aBlock [

	^ UmeObjectGenerator new then: aBlock 
]

{ #category : 'as yet unclassified' }
UmeGenerator class >> onceInstance: aBlock of: aClass [

	^ UmeObjectGenerator new then: aBlock; objectClass: aClass
]

{ #category : 'as yet unclassified' }
UmeGenerator class >> oneOf: options [

	^ UmeOptionsGenerator new from: options.
]

{ #category : 'as yet unclassified' }
UmeGenerator >> feed: feedback [
	
	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
UmeGenerator >> gen: instance [
	
	self subclassResponsibility 
]
