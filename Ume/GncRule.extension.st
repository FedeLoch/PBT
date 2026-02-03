Extension { #name : 'GncRule' }

{ #category : '*Ume' }
GncRule >> backPropagate: bla [

	"TODO: delete me"
]

{ #category : '*Ume' }
GncRule >> backPropagate: reward level: level [

	rewards at: level ifAbsentPut: [ 1 ].
	 
	rewards at: level update: [ :v | (v + reward) max: 1 ]
]

{ #category : '*Ume' }
GncRule >> minimumTree [

	^ fragments collect: [ :fragment | | node |
		node := fragment minimumTree grammarRule: self.
		node 
	]

]

{ #category : '*Ume' }
GncRule >> reward [

	"DELETE ME"
]

{ #category : '*Ume' }
GncRule >> rewardBy: level [
	
	rewards at: level ifAbsent: [ ^0 ].
	
	^ rewards at: level
]

{ #category : '*Ume' }
GncRule >> updateWeightWith: reward [

	weight set: ((weight get + reward) max: 1)
]

{ #category : '*Ume' }
GncRule >> utc: totalVisits by: c [

	"DELETE ME"
]

{ #category : '*Ume' }
GncRule >> utc: totalVisits by: c level: level [
	 
	"UCT = (reward(rule) / visits(rule)) + C * sqrt(log(total_visits) / visits(rule)))"
	| levelReward levelVisits |
	
	levelReward := self rewardBy: level.
	levelVisits := self visitsBy: level.
	
	^ (levelReward / levelVisits) + (c * ((totalVisits log / levelVisits) sqrt))
]

{ #category : '*Ume' }
GncRule >> visit [

	"TODO: delete me"
]

{ #category : '*Ume' }
GncRule >> visit: visitor level: level [

	self visitIn: level. "visit"
	
	^ visitor visitRule: self level: level
]

{ #category : '*Ume' }
GncRule >> visitIn: level [

	visits at: level ifAbsentPut: [ 0 ].
	
	visits at: level update: [ :visit | visit + 1 ]
]

{ #category : '*Ume' }
GncRule >> visited [

	"todo: delete me"
]

{ #category : '*Ume' }
GncRule >> visitedIn: level [

	visits at: level ifPresent: [ ^ true ].
	
	^ false
]

{ #category : '*Ume' }
GncRule >> visits [

	"todo: delete me"
]

{ #category : '*Ume' }
GncRule >> visitsBy: level [
	
	visits at: level ifAbsent: [ ^0 ].
	
	^ visits at: level
]

{ #category : '*Ume' }
GncRule >> weightAt: level [
	
	rewards at: level ifAbsent: [ ^ weight get max: 1 ].
	
	^ ((rewards at: level) + weight get) max: 1 
]
