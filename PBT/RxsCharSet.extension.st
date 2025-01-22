Extension { #name : 'RxsCharSet' }

{ #category : '*PBT' }
RxsCharSet >> minimalString [

	^ '''' join: (elements collect: [ :node | node minimalString ])
]
