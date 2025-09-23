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
		spec baseline: 'Gnocco' with: [ spec repository: 'github://FedeLoch/gnocco:release/src' ].
		spec baseline: 'MuTalk' with: [ spec repository: 'github://pharo-contributions/mutalk:v2.6.0/src' ].
		spec baseline: 'PBA' with: [ spec repository: 'github://FedeLoch/PBA:main' ].
		spec baseline: 'OSSubprocess' with: [ spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ].
		
		spec package: 'PBT' with: [ spec requires: #( 'Coverage2' 'Phuzzer' 'BlocBenchs' 'Roassal' 'OSSubprocess' 'Gnocco' 'PBA' ) ].
		spec package: 'Coverage2'
	]
]
