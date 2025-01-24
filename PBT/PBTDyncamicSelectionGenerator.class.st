Class {
	#name : 'PBTDyncamicSelectionGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'probabilityGenerators',
		'lastChosen'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTDyncamicSelectionGenerator >> gen: myConstraint [

	^ self gen: myConstraint by: true 
]

{ #category : 'as yet unclassified' }
PBTDyncamicSelectionGenerator >> gen: myConstraint by: previousFeedback [

	"P(x) = \frac{\text{weight}(x)}{\text{sum of all weights}}"
	self updateWeight: previousFeedback.
	lastChosen := self selectOne.
	^ lastChosen gen: myConstraint
	
]

{ #category : 'accessing' }
PBTDyncamicSelectionGenerator >> generators: gens [

	probabilityGenerators := gens collect: [ :gen | PBTGenProbabilityWrapper from: gen ]
]

{ #category : 'accessing' }
PBTDyncamicSelectionGenerator >> probabilityGenerators [

	^ probabilityGenerators 
]

{ #category : 'as yet unclassified' }
PBTDyncamicSelectionGenerator >> selectOne [

	| totalWeights weights indexes random |

	totalWeights := (probabilityGenerators collect: #weight) sum.
	weights := OrderedCollection new.
	
	indexes := probabilityGenerators collect: [ :wrapper | | current |
		current := (weights isEmpty ifTrue: [0] ifFalse: [ weights last ]).
		weights add: (current + wrapper weight).
		probabilityGenerators indexOf: wrapper
	].
	
	random := (1 to: totalWeights) atRandom.
	
	^ probabilityGenerators at: (indexes detect: [ :index | random <= (weights at: index) ])
]

{ #category : 'as yet unclassified' }
PBTDyncamicSelectionGenerator >> updateWeight: previousFeedback [

	lastChosen ifNil: [ ^nil ].

	previousFeedback ifTrue: [ lastChosen increaseWeight ] ifFalse: [ lastChosen decreaseWeight ]
]
