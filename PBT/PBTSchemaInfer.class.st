Class {
	#name : 'PBTSchemaInfer',
	#superclass : 'Object',
	#instVars : [
		'target'
	],
	#category : 'PBT-Property Specifcation',
	#package : 'PBT',
	#tag : 'Property Specifcation'
}

{ #category : 'as yet unclassified' }
PBTSchemaInfer class >> enrich: schema for: targetMethod [

	^ PBTSchemaInfer new target: targetMethod; enrichSchema: schema
]

{ #category : 'as yet unclassified' }
PBTSchemaInfer >> enrichSchema: schema [

	"TODO: implement me "
	^ schema
]

{ #category : 'as yet unclassified' }
PBTSchemaInfer >> target: targetMethod [

	target := targetMethod
]
