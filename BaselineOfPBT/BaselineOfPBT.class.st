Class {
	#name : 'BaselineOfPBT',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPBT',
	#package : 'BaselineOfPBT'
}

{ #category : 'baselines' }
BaselineOfPBT >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'Phuzzer' with: [ spec repository: 'https://github.com/Alamvic/phuzzer' ].
		spec package: 'PBT' with: [ spec requires: #( 'Phuzzer' ) ]
	]
]
