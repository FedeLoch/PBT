Extension { #name : 'GncRule' }

{ #category : '*PBT' }
GncRule >> initialize [

	fragments := OrderedCollection new.
	weight := 1 asWeight.
	minHeight := Float infinity.
	minSize := Float infinity.
	visits := 0.
	reward := 0.
]

{ #category : '*PBT' }
GncRule >> newReward: newReward [

	reward := reward + newReward.
]

{ #category : '*PBT' }
GncRule >> utc: totalVisits by: c [
	 
	"UCT = (reward(rule) / visits(rule)) + C * sqrt(log(total_visits) / visits(rule)))"
	^ (reward / (visits max: 1)) + (c * ((totalVisits log) / visits) sqrt)
]

{ #category : '*PBT' }
GncRule >> visit [

	visits := visits + 1
]

{ #category : '*PBT' }
GncRule >> visited [

	^ visits > 0
]
