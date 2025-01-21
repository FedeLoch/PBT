Extension { #name : 'C2CoverageResult' }

{ #category : '*PBT' }
C2CoverageResult >> hasAllNodesCovered: aMethod [

	aMethod ast nodesDo: [ :node |
		node isSequence ifTrue: [ node hasBeenExecuted ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : '*PBT' }
C2CoverageResult >> partiallyCoveredMethods [

	^ self methods select: [ :meth | (self hasAllNodesCovered: meth) not ]
]

{ #category : '*PBT' }
C2CoverageResult >> showPreview [

    | dr result notExecuted methodsSize |
    dr := DrTests open.
    dr currentPlugin: DTTestCoveragePlugin new.
    result := DTTestCoverageResult new.
    notExecuted := self uncoveredMethods.
    methodsSize := self methods size + self uncoveredMethods size.

    nodes do: [ :markedNode | | theGoodNode |
        theGoodNode := (markedNode methodNode compiledMethod ast childAtPath:
             markedNode path).
        theGoodNode tagExecuted ].

    result
        percent: 1s2 - (notExecuted size / methodsSize asScaledDecimal: 2);
        methodList: notExecuted;
        partiallyCoveredMethods: self partiallyCoveredMethods.

    dr pluginResult: result.
    dr updateWithPluginResult: result
    "result inspect."
]
