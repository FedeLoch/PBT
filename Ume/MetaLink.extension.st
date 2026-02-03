Extension { #name : 'MetaLink' }

{ #category : '*Ume' }
MetaLink >> optionCompileOnLinkInstallation: aBoolean [
	aBoolean
		ifTrue: [ options options add: #optionCompileOnLinkInstallation ]
		ifFalse: [ options options remove: #optionCompileOnLinkInstallation ifAbsent:[] ]
]
