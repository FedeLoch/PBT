Class {
	#name : 'UmeShrinkerBenchmarkComparison',
	#superclass : 'Object',
	#instVars : [
		'results',
		'summary'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'accessing' }
UmeShrinkerBenchmarkComparison >> results [
	^ results
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkComparison >> results: anObject [
	results := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkComparison >> summary [
	^ summary
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkComparison >> summary: anObject [
	summary := anObject
]

{ #category : 'reporting' }
UmeShrinkerBenchmarkComparison >> printDetailedReport [
	
	| stream |
	stream := String new writeStream.
	
	stream
		nextPutAll: '=== DETAILED SHRINKER COMPARISON ===';
		cr;
		cr.
	
	summary keysAndValuesDo: [ :shrinkerClass :stats |
		stream
			nextPutAll: shrinkerClass name;
			cr;
			nextPutAll: '  Avg Reduction:    ', ((stats at: #avgReduction) round: 2) asString, '%';
			cr;
			nextPutAll: '  Avg Duration:     ', ((stats at: #avgDuration) round: 2) asString, ' ms';
			cr;
			nextPutAll: '  Avg Iterations:  ', ((stats at: #avgIterations) round: 2) asString;
			cr;
			cr ].
	
	^ stream contents
]

{ #category : 'reporting' }
UmeShrinkerBenchmarkComparison >> bestByReduction [
	
	| best |
	best := nil.
	
	summary keysAndValuesDo: [ :shrinkerClass :stats |
		best isNil
			ifTrue: [ best := shrinkerClass -> (stats at: #avgReduction) ]
			ifFalse: [
				(stats at: #avgReduction) > best value ifTrue: [
					best := shrinkerClass -> (stats at: #avgReduction) ] ] ].
	
	^ best
]

{ #category : 'reporting' }
UmeShrinkerBenchmarkComparison >> bestBySpeed [
	
	| best |
	best := nil.
	
	summary keysAndValuesDo: [ :shrinkerClass :stats |
		best isNil
			ifTrue: [ best := shrinkerClass -> (stats at: #avgDuration) ]
			ifFalse: [
				(stats at: #avgDuration) < best value ifTrue: [
					best := shrinkerClass -> (stats at: #avgDuration) ] ] ].
	
	^ best
]

{ #category : 'reporting' }
UmeShrinkerBenchmarkComparison >> bestOverall [
	
	| scores |
	scores := summary collect: [ :stats :shrinkerClass |
		| score |
		score := (stats at: #avgReduction) * 0.6 + ((1000 - (stats at: #avgDuration)) / 10 * 0.2) + ((100 - (stats at: #avgIterations)) * 0.2).
		shrinkerClass -> score ].
	
	^ scores maxValue
]
