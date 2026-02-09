Class {
	#name : 'BaselineOfUme',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfUme',
	#package : 'BaselineOfUme'
}

{ #category : 'baselines' }
BaselineOfUme >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'Phuzzer' with: [ spec repository: 'github://Alamvic/phuzzer:main' ].
		"spec baseline: 'BlocBenchs' with: [ spec repository: 'github://pharo-graphics/BlocBenchs:master/src' ]."
		"spec baseline: 'Roassal' with: [ spec repository: 'github://pharo-graphics/Roassal/src' ]."
		spec baseline: 'PBA' with: [ spec repository: 'github://FedeLoch/PBA:main' ].
		spec baseline: 'Gnocco' with: [ spec repository: 'github://Alamvic/gnocco:release/src' ].
		spec baseline: 'MuTalk' with: [ spec repository: 'github://pharo-contributions/mutalk:v2.6.0/src' ].
		spec baseline: 'Microdown' with: [ spec repository: 'github://pillar-markup/Microdown:dev' ].
		spec baseline: 'OSSubprocess' with: [ spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ].
		spec baseline: 'Mate' with: [ spec repository: 'github://FedeLoch/Mate:main' ].
		
		spec package: 'Ume' with: [ spec requires: #( 'Coverage2' 'Phuzzer' "'BlocBenchs'" "'Roassal'" 'OSSubprocess' 'PBA' 'Gnocco' 'Microdown' 'Mate' ) ].
		spec package: 'Coverage2'
	]
]
