Extension { #name : 'MTMethodMutation' }

{ #category : '*PBT' }
MTMethodMutation >> title [

	^ operator description, ' in ', originalClass printString, '>>', originalMethod  selector printString
]
