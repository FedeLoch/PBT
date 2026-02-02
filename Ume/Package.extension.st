Extension { #name : 'Package' }

{ #category : '*Ume' }
Package >> allMethodsWith: selector [
	
	^ self methods select: [ :method | selector match: method selector ]
]
