Extension { #name : 'Package' }

{ #category : '*PBT' }
Package >> allMethodsWith: selector [
	
	^ self methods select: [ :method | selector match: method selector ]
]
