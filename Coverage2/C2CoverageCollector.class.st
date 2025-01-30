"
I represent a code coverage session.

My instances can track the execution of methods and nodes and collects which are covered by execution and which are not.

Currently, compiled methods and sequences of statements (bodies of methods and block) can be tracked.
This is a compromise between efficency and precision that is good enough precition to track covered paths.

Here is a quick usage:

```
| collector coverage |
collector := CoverageCollector new. ""Instantiate""
collector methods: Point methods, Rectangle methods.  ""Configure with the methods to watch.""
coverage := collector runOn: [ (1@1 corner: 2@2) center ].  ""Setup, execute and teardown.""
(coverage methods includes: Point>>#x) >>> true.  ""Inspect the results""
(coverage nodes size > 10) >>> true. ""Covered paths are also available""
```

The `CoverageCollector>>#runOn:` methods is a high level method.
It calls the following fine grained methods in order:

* `CoverageCollector>>#install` to instrument the preselected methods
* `CoverageCollector>>#installOn:` to instrument the preselected methods ensuring `uninstall` is performed.
* `CoverageCollector>>#basicRun:` to watch the execution of a block.
* `CoverageCollector>>#uninstall` to remove the instrumentation on methods.
* `CoverageCollector>>#collectResult` to build and return a `CoverageResult` instance.
* `CoverageCollector>>#reset` to clear the annotation on executed methods.

Note: if `uninstall` is not called, some instrumentation may leaks.
You can use the global `CoverageCollector class>>#uninstallAll` to remove all instrumentation if needed.

Warning: because of the instrumentation, new instances of `CompiledMethod` can be created to replace existing one during the coverage computation. This means that the identity of method objects returned by expression like `Point>>#x` could be not reliable and that `=` and related methods may not behave as you expect if you use lower level methods.
"
Class {
	#name : 'C2CoverageCollector',
	#superclass : 'Object',
	#instVars : [
		'methods',
		'nodes',
		'edges',
		'coveredNodes',
		'result',
		'links'
	],
	#category : 'Coverage2',
	#package : 'Coverage2'
}

{ #category : 'installation' }
C2CoverageCollector class >> uninstalAll [

	"If for some reason metalinks are not removed, force a full image cleaning"

	<script>
	MetaLink allInstancesDo: [ :each | 
		(each selector == #tagExecuted and: [ each metaObject == #node ]) 
			ifTrue: [ each uninstall ] ]
]

{ #category : 'basic' }
C2CoverageCollector >> basicCollectResult [

	"Collect the results but does not reset the annotations."

	| res |
	res := C2CoverageResult new.
	res collector: self.
	res methods: (methods select: [ :m | m ast hasBeenExecuted ]).
	res nodes: IdentitySet new.
	nodes do: [ :node | 
			node hasBeenExecuted ifTrue: [ res nodes add: node ] ].

	^ res
]

{ #category : 'basic' }
C2CoverageCollector >> basicRun: aBlock [

	"Just run the block. We consider that the correct setup is done and that a teardown will be performed."

	^ aBlock value
]

{ #category : 'callgraph' }
C2CoverageCollector >> callgraph [

	"Compute and return directed `edges` that connect nodes together.
	
	 The vertices of this static call graph are the sequence nodes (the main sequence of each methods + nested syntactic blocks) and the edges are direct block nesting and message sends:
	 * a sequence is connected to each of its (directly) nested sequences;
	 * a sequence with a message send is connected to the main sequence of all methods with the same selector.

	 Note that only the `nodes` from the `methods`	are considered, so the resulting graph may not be connected.

	 The result is a collection of pairs (arrays of 2 elements). The first element is the *source* node, the second element is the *destination* node.
	 This representation is therefore usable with algorithms of `AI-Algorithms-Graph` for instance."

	| visitor |
	visitor := C2SequenceGraphVisitor new.
	visitor collector: self.
	
	nodes ifNil: [ self initializeNodes ].

	nodes do: [ :node | node acceptVisitor: visitor ].

	^ edges := visitor edges.
]

{ #category : 'basic' }
C2CoverageCollector >> collectResult [

	| collectionResult |
	
	self remapMethods.
	collectionResult := result collectResult: self.
	self resetResult.
	^ collectionResult 
]

{ #category : 'accessing' }
C2CoverageCollector >> edges [
	^ edges
]

{ #category : 'initialization' }
C2CoverageCollector >> initialize [

	methods := IdentitySet new.
	result := C2IncrementalResult new.
	links := OrderedCollection new.
]

{ #category : 'initialization' }
C2CoverageCollector >> initializeNodes [

	"Visit methods and collect their sequence nodes"

	nodes := IdentitySet new.
	methods do: [ :meth | 
		meth ast nodesDo: [ :node | 
			node isSequence ifTrue: [ 
				nodes add: node ] ] ].
	^ nodes.
]

{ #category : 'basic' }
C2CoverageCollector >> install [

	| metalink |
	"Prepare the metalink. This can be slow.
	
	Sequence nodes are also prepared. This enable a basic path coverage."

	nodes ifNil: [ self initializeNodes ].
	nodes do: [ :node | 
		self assert: node isSequence.
			metalink := MetaLink new
		            selector: #tagExecuted:inMethod:;
		            metaObject: self;
						arguments: { RBLiteralValueNode value: node path . RBLiteralValueNode value: node methodNode compiledMethod name };
						optionCompileOnLinkInstallation: true.
		links add: metalink.
		node link: metalink.
	].
]

{ #category : 'running' }
C2CoverageCollector >> installOn: aBlock [

	"just run a block, with installation and uninstallation."

	self install.
	aBlock ensure: [ self uninstall ].
]

{ #category : 'accessing' }
C2CoverageCollector >> methods [

	^ methods
]

{ #category : 'accessing' }
C2CoverageCollector >> methods: anObject [

	methods := anObject
]

{ #category : 'callgraph' }
C2CoverageCollector >> nodeDistances: aNodeOrMethod isBackward: isBackward [

	"Simple BFS to discover the distance of reachble nodes from a staring node.
	 Edges can be followed forward or backward."

	| aNode todo result todoLater depth |
	
	aNode := (aNodeOrMethod isCompiledMethod or: [aNodeOrMethod class = ReflectiveMethod])
		ifTrue: [ aNodeOrMethod ast body ]
		ifFalse: [ aNodeOrMethod ].
	
	self assert: (nodes includes: aNode).
	result := IdentityDictionary new.
	todo := OrderedCollection new.
	todoLater := OrderedCollection new.
	todo add: aNode.
	result at: aNode put: 0.
	depth := 1.
	[ todo isNotEmpty ] whileTrue: [
		| tmp |
		todo do: [ :n |
			edges do:  [ :e |
				| n1 n2 |
				isBackward
					ifTrue: [
						n1 := e second.
						n2 := e first. ]
					ifFalse: [ 
						n1 := e first.
						n2 := e second. ].
					
				((n1 ~~ n) or: [result includesKey: n2]) ifFalse: [ 
					todoLater add: n2.
					result at: n2 put: depth.
				 ]
			 ]
		 ].
		depth := depth + 1.
		tmp := todo.
		todo := todoLater.
		todoLater := tmp.
		todoLater removeAll.
	].
	^ result.
]

{ #category : 'callgraph' }
C2CoverageCollector >> nodeDistancesFrom: aNodeOrMethod [

	"Compute the distance of each node that is reached by `aNodeOrMethod` (according to `callgraph`).
	 Returns a dictionary Node->integer.
	 Only nodes with a finite distance from `aNodeOrMethod` are present in the dictionary (including `aNode` itself with a distance of 0)."

	^ self nodeDistances: aNodeOrMethod isBackward: false
]

{ #category : 'callgraph' }
C2CoverageCollector >> nodeDistancesTo: aNodeOrMethod [

	"Compute the distance of each node that can reach `aNodeOrMethod` (according to `callgraph`).
	 Returns a dictionary Node->integer.
	 Only nodes with a finite distance to `aNodeOrMethod` are present in the dictionary (including `aNode` itself with a distance of 0)."

	^ self nodeDistances: aNodeOrMethod isBackward: true
]

{ #category : 'accessing' }
C2CoverageCollector >> nodes [

	^ nodes
]

{ #category : 'printing' }
C2CoverageCollector >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' methods: ';
		print: methods size;
		nextPutAll: ' nodes: ';
		print: nodes size
]

{ #category : 'private' }
C2CoverageCollector >> remapMethods [

	"Because of metalinks, CompiledMethods can by recompiled, so this method is called to updates the list of methods with the 'current' list of methods."
	^ methods := methods collect: [ :m | m classBinding value >> m selector ]
]

{ #category : 'initialization' }
C2CoverageCollector >> resetResult [

	result := C2IncrementalResult new
]

{ #category : 'running' }
C2CoverageCollector >> runOn: aBlock [

	"Fully run self, with installation, execution and uninstallation.
	
	Returns a CoverageResult."

	self installOn: [
		self basicRun: aBlock ].
	^ self collectResult
]

{ #category : 'callgraph' }
C2CoverageCollector >> tagExecuted: aNodePath inMethod: aMethodName [

	| process |
	process := Processor activeProcess.
	process isMeta ifTrue: [ ^ self ].

	"Move to the meta level and call the before hook"
	process shiftLevelUp.

	result coverNode: aNodePath inMethod: aMethodName.
	
	process shiftLevelDown
]

{ #category : 'basic' }
C2CoverageCollector >> uninstall [

	"Remove the instrumentation.
	
	Use `runOn:` or `installOn:` that automatically ensures that `uninstall` is called."

	links do: #uninstall
]
