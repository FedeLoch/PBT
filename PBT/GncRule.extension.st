Extension { #name : 'GncRule' }

{ #category : '*PBT' }
GncRule >> backPropagate: bla [

	"TODO: delete me"
]

{ #category : '*PBT' }
GncRule >> backPropagate: reward level: level [

	rewards at: level ifAbsentPut: [ 1 ].
	 
	rewards at: level update: [ :v | (v + reward) max: 1 ]
]

{ #category : '*PBT' }
GncRule >> minimumTree [

	^ fragments collect: [ :fragment | | node |
		node := fragment minimumTree grammarRule: self.
		node 
	]

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
GncRule >> updateWeightWith: reward [

	weight set: ((weight get + reward) max: 1)
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
	
	^ (levelReward / levelVisits) + (c * ((totalVisits log / levelVisits) sqrt))
]

{ #category : '*PBT' }
GncRule >> visit [

	"TODO: delete me"
]

{ #category : '*PBT' }
GncRule >> visit: visitor level: level [

	self visitIn: level. "visit"
	
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

{ #category : '*PBT' }
GncRule >> weightAt: level [
	
	rewards at: level ifAbsent: [ ^ weight get max: 1 ].
	
	^ ((rewards at: level) + weight get) max: 1 
]
