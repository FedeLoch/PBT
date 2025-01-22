Extension { #name : 'RxsBranch' }

{ #category : '*PBT' }
RxsBranch >> minimalString [

	^ piece minimalString, (branch ifNil: [ '' ] ifNotNil: [ branch minimalString ])
]
