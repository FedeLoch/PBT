Extension { #name : 'GncRule' }

{ #category : '*PBT' }
GncRule >> backPropagate: bla [

	"TODO: delete me"
]

{ #category : '*PBT' }
GncRule >> backPropagate: newReward level: level [

	rewards at: level ifAbsentPut: [ 0 ].
	
	rewards at: level update: [ :v | (v + newReward) max: 1 ]
]

{ #category : '*PBT' }
GncRule >> initialize [

	fragments := OrderedCollection new.
	weight := 1 asWeight.
	minHeight := Float infinity.
	minSize := Float infinity.
	visits := Dictionary new.
	rewards := Dictionary new.
]

{ #category : '*PBT' }
GncRule >> reward [

	"DELETE ME"
]

{ #category : '*PBT' }
GncRule >> rewardBy: level [
	
	rewards at: level ifAbsent: [ ^0 ].
	
	^ rewards at: level
]

{ #category : '*PBT' }
GncRule >> utc: totalVisits by: c [

	"DELETE ME"
]

{ #category : '*PBT' }
GncRule >> utc: totalVisits by: c level: level [
	 
	"UCT = (reward(rule) / visits(rule)) + C * sqrt(log(total_visits) / visits(rule)))"
	| levelReward levelVisits |
	
	levelReward := self rewardBy: level.
	levelVisits := self visitsBy: level.
	
	levelReward = 0 ifTrue: [1 halt.].
	levelVisits = 0 ifTrue: [1 halt.].
	^ (levelReward / levelVisits) + (c * ((totalVisits log / levelVisits) sqrt))
]

{ #category : '*PBT' }
GncRule >> visit [

	"TODO: delete me"
]

{ #category : '*PBT' }
GncRule >> visit: visitor level: level [

	^ visitor visitRule: self level: level
]

{ #category : '*PBT' }
GncRule >> visitIn: level [

	visits at: level ifAbsentPut: [ 0 ].
	
	visits at: level update: [ :visit | visit + 1 ]
]

{ #category : '*PBT' }
GncRule >> visited [

	"todo: delete me"
]

{ #category : '*PBT' }
GncRule >> visitedIn: level [

	visits at: level ifPresent: [ ^ true ].
	
	^ false
]

{ #category : '*PBT' }
GncRule >> visits [

	"todo: delete me"
]

{ #category : '*PBT' }
GncRule >> visitsBy: level [
	
	visits at: level ifAbsent: [ ^0 ].
	
	^ visits at: level
]
