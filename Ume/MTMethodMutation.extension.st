Extension { #name : 'MTMethodMutation' }

{ #category : '*Ume' }
MTMethodMutation >> title [

	^ operator description, ' in ', originalClass printString, '>>', originalMethod  selector printString
]
