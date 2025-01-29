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
		spec baseline: 'Phuzzer' with: [ spec repository: 'github://Alamvic/phuzzer:main' ].
		spec baseline: 'BlocBenchs' with: [ spec repository: 'github://pharo-graphics/BlocBenchs:master/src' ].
		spec baseline: 'Roassal' with: [ spec repository: 'github://pharo-graphics/Roassal/src' ].
		spec baseline: 'OSSubprocess' with: [ spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ].
		spec package: 'PBT' with: [ spec requires: #( 'Phuzzer' 'BlocBenchs' 'Roassal' 'OSSubprocess' ) ]
	]
]
