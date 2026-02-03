Extension { #name : 'RxsBranch' }

{ #category : '*Ume' }
RxsBranch >> minimalString [

	^ piece minimalString, (branch ifNil: [ '' ] ifNotNil: [ branch minimalString ])
]
