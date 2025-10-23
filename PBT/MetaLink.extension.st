Extension { #name : 'MetaLink' }

{ #category : '*PBT' }
MetaLink >> optionCompileOnLinkInstallation: aBoolean [
	aBoolean
		ifTrue: [ options options add: #optionCompileOnLinkInstallation ]
		ifFalse: [ options options remove: #optionCompileOnLinkInstallation ifAbsent:[] ]
]
