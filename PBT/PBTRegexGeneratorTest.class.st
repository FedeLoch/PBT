Class {
	#name : 'PBTRegexGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTRegexGeneratorTest >> testGenerateAnStringInputByRegex [

	| generator regex |

	regex := '^[a-z]+@[a-z]+\.[a-z]{2,3}$' asRegex.
	generator := PBTRegexGenerator new regex: regex.

	self assert: (regex matches: (generator gen: nil)) equals: true
]
