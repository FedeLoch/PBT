Extension { #name : 'RxsCharSet' }

{ #category : '*Ume' }
RxsCharSet >> minimalString [

	^ '''' join: (elements collect: [ :node | node minimalString ])
]
