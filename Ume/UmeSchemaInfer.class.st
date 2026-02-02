Class {
	#name : 'UmeSchemaInfer',
	#superclass : 'Object',
	#category : 'Ume-Property Schema',
	#package : 'Ume',
	#tag : 'Property Schema'
}

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> argumentConstraintsFor: method [

	^ method ast arguments  collect: [ :argNode | self receiverConstraintForVariable: argNode on: method ].
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> assertFor: method [

	| expectedType |
	
	expectedType := TypeInferencer inferExpectedResultType: method.
	
	"ex: [ :n :args :result | args first + n = result ]"
	"TODO: A naive approach for assert Results"
	^ [ :instance :args :result | (TypeInferencer typeOf: result) = expectedType ]
	
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> enrich: schema for: targetMethod [

	^ schema merge: (self schemaFor: targetMethod)

]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> isPrimitiveClass: class [

	"TODO"
	^ false
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> primitiveConstraint: class [

	"TODO"
	1 halt.
	^ false
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> receiverConstraint: class calling: methods [

	| propConstraints |
	
	"If the class is a primitive like SmallInteger or Boolean, create a predefined generator for that class"
	(self isPrimitiveClass: class) ifTrue: [ ^ self primitiveConstraint: class ].
	
	"Common case, complex object"
	
	"TODO: continue"
	"If it's not possible to get the class, build an stubObject which know how to respond to all the methods"
	
   "agrupar, por cada instancia, todas las llamads a sus metodos
	{
		class -> [ method ]
	},
	llamar recursivamente y mergear esas constraints
	"
"   propConstraints := class instanceVariables flatCollect: [ :ivar |
            ""Add constraints based on instance variables, e.g., their class types""
            ""constraints add: (PBTSchemaConstraint forVariable: ivar class: (eachClass classPool at: ivar ifAbsent: [ Object ]))""
   ]."

   "^ PBTObjectConstraint new objectClass: methodClass; props: propConstraints; gen: (PBTGenerator genBy: methodClass from: propConstraints)"
	^ nil
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> receiverConstraintForVariable: argNode on: method [

	"Take all their calls and return "
	| class methods variableName |
	
	variableName := 'TODO'.
	methods := {}.
	class := TypeInferencer inferTypeFrom: methods withName: variableName.
	
	^ self receiverConstraint: class calling: methods
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> schemaFor: method [

	| objectConstraints inputConstraints assert |
	
	objectConstraints := self selfReceiverConstraintOn: method.
	inputConstraints := self argumentConstraintsFor: method.
	assert := self assertFor: method.
	
	^ UmeSchema new receiverConstraint: objectConstraints; argumentConstraints: inputConstraints; assert: assert.
]

{ #category : 'as yet unclassified' }
UmeSchemaInfer class >> selfReceiverConstraintOn: method [

	^ self receiverConstraint: (method methodClass) calling: { method } 
]
