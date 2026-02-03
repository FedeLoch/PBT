Class {
	#name : 'UmeDataFrameTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'schema'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeDataFrameTest >> csvGenerator [

	self subclassResponsibility 
]

{ #category : 'accessing' }
UmeDataFrameTest >> seed [
	
	^ 'id,first_name,last_name,email,gender,ip_address
1,Jeannine,Sutehall,jsutehall0@lulu.com,Female,250.29.137.240
2,Lynnette,Pashbee,lpashbee1@blogger.com,Female,179.86.141.239
3,Garrick,Fontell,gfontell2@sitemeter.com,Male,4.57.36.151
4,Osbert,O''Henecan,oohenecan3@senate.gov,Male,251.160.81.243
5,Doug,Vieyra,dvieyra4@chronoengine.com,Genderfluid,72.234.190.220'
]

{ #category : 'running' }
UmeDataFrameTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.

	schema := UmeSchema new
		          receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: DataFrame));
		          argumentConstraints: { (UmeObjectConstraint new
				           generator: self csvGenerator;
				           wrap: [ :input | | file |
						       file := FileLocator temp / input hash asString, '.csv'.
						       file ensureDelete.
						       file writeStreamDo: [ :stream | stream nextPutAll: input ].
						       file asFileReference
							  ];
				           unwrap: #contents) };
		          score: [ :re :inputs :res | 1 ];
		          assert: [ :regex :input :result | true ]
]
