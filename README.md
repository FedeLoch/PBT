# PBT - Property-Based Testing Framework for Pharo

## Getting started

To install the framework you must execute this Metacello script in your playground or add the project as a dependency

```Smalltalk
Metacello new
    baseline: 'PBT';
    repository: 'github://FedeLoch/PBT/tree/main/src';
    load
```

## How does PBT work ?

PBT works with Object generators ( for the moment ) provided by hand, automatically generating receiver objects and call arguments.

A PBT execution looks like the following:

```Smalltalk
PBTRunner test: SmallInteger >> #+ from: schema
```

What we are saying to the framework

"Test this method ( **SmallInteger >> #+** ) using the following schema"

But for the framework to be able to test the method we need to create a schema with the following information:

- **ReceiverConstraint**: An object constraint specification on how to generate the message's receiver.
- **ArgumentConstraints:**: An array of Object Constraint specifications for generating each message's argument.
- **Assert**: A block that will validate whether a result is accomplished with your properties or not.

Following the previous usage, to be able to test the addition method of the class SmallInteger we are going to provide the next schema:

```Smalltalk
range := SmallInteger minVal to: SmallInteger maxVal.
receiverConstraint := PBTObjectConstraint new generator: (PBTGenerator oneOf: range).

argumentConstraints := {
    (PBTObjectConstraint new generator: (PBTGenerator oneOf: range))
}.

assert := [ :n :args :result | args first + n = result ]. "<- Note that the assert block receives the object receiver, the arguments used for the call and the method's call result"

schema := PBTSchema new
                receiverConstraint: receiverConstraint;
                argumentConstraints: argumentConstraints;
                assert: assert
```

#### Observation: We use predefined **PBTGenerator** to generate dynamically SmallInteger providing a range of possible values. The built-in generators will be explained later.

### PBT Result

As a result, PBT Provides a **PBTResult** which has the following information:
- **Tests**: The set of every PBT test, representing every test instance, with its own generated receiver, arguments, results, coverage and time consumed.
- **Segmented tests**: The set of tests segmented by his result ( Success, Fail or Error ).
- **Total time**: The total time it takes to perform the whole PBT Execution.
- **Total Coverage**: An incremental coverage result with the union of all test executions.
- **Performance Result**: A performance result with information about test times.

## PBT parameters

### Stop criteria

PBT can be executed by calling it with different methods, the default is just calling as above, which means that the framework will execute only 1000 test cases.

```Smalltalk
PBTRunner test: targetMethod from: schema
```

In case you want to specify the amount of time you want the framework to generate test cases, you can use the following method:

```Smalltalk
PBTRunner test: targetMethod from: schema for: time
```

In case you want to specify the number of generated tests:

```Smalltalk
PBTRunner test: targetMethod from: schema times: times
```

If you want to set out that you want the framework to execute until you get 100% of coverage or define a bound of tolerance for not improving coverage tests:

```Smalltalk
PBTRunner test: targetMethod from: schema withCoverageTolerance: numberOfTolerance
```

## Generators

We provide several built-in generators that must be enough to define generators for every object. However, you can define your generators to reduce code duplication. These built-in generators are:

- **PBTConstantGenerator**: Always returns the same value.
- **PBTDyncamicSelectionGenerator**: Receives a list of generators and, based on feedback, balances the weight of every option to give more chance to the generator that got good solutions probabilistically.
- **PBTGrammarGenerator**: Receives a grammar and generates a random valid value accepted for that grammar.
- **PBTObjectGenerator**: Given a block, fill the instance object.
- **PBTOptionsGenerator**: Returns a random value from a series of options.
- **PBTPointGenerator**: Returns a random point.
- **PBTGenericGenerator**: Receives a block and executes that block every time it is called, delegating the responsibility of how to create the object to the user.
- **PBTHillClimbingGenerator**: Implements a hill Climbing Algorithm, where mutating the last better solution based on feedback.

## Performance result

The performance result provides complete information about running times, the maximum time taken by a case test, the minimum and the average time.
Also, we are segmenting the test cases by execution time to provide a better feedback visualization.

## Coverage result

The coverage result is an incremental coverage result with the union of all test executions, representing the union of every ran method and node executed by all test cases.

## Score

The schema is able to receives a scoring block, which represents a custom metric that the user wants to have to receive a score-based ranking as part of the result. To do this is enough to provide a block that receives the object, the inputs and the PBTResult.

```Smalltalk
	score := [ :re :inputs :res | | coreScore gnoccoScore anotherRegex |
		coreScore := res time asMilliSeconds.
		anotherRegex := inputs first asRegex.
		gnoccoScore := [ anotherRegex matches: inputs first ] millisecondsToRun.
		coreScore / (gnoccoScore max: 1)
	].

	PBTSchema new ...; score: score;
```

## Shared properties

PBT provides support to shared properties between schema constraints.
To do this, we can define an instance of **InternalConstraintProperties** as follows:

```Smalltalk
	sharedProperties := InternalConstraintProperties from:
		{ ('grammar' -> self regexConstraint) } asDictionary.
```

Then, inside each schema constraint, you can share this instance, which will be propagated between all the schema constraints. This entity is stateful and supports some common methods, such as `at:` and `at:put:`.

## Feedback

PBT provides some generations that depend on previous exploration, which facilitates their ability to guide exploration. For that reason, we introduced the idea of a Feedback validator, who will be in charge of feed generation with feedback ( a boolean ).

The feedback evaluator always will provide feedback based on specific criteria.

## Feedback-oriented exploration

To implement Feedback on your input exploration, you just have to tell the scheme what the feedback criteria are, calling it a method.

The schema supports four methods:

- **guidedByAllocatedMemory**
- **guidedByCoverage**
- **guidedByExecutionTime**
- **guidedByScore**

Note that the score is a custom user metric, you can use it to guide your exploration, guiding the runner to generate object that maximize this value.

If you want to guide the exploration based on another metric, you can call the method **guidedBy:** which receives a block that receives a pbt test case and return a value ( This is the criteria ).

## Low-cost API

The common PBT API is based on have a huge coverage of all the code in which impact our target method. This means that we are instrumenting a lot of code in our executions, even if we have incremental coverage and we are avoiding to reinstrument code more than once, instrument a whole package is expensive. 
This means that have a great code coverage impact directly on the performance and the time consumed to find outliers.

For this reason, we are providing a "low cost" API, which sacrifices complete coverage instrumentation to earn more computational cost, being able to generate x40 more cases.

The PBT Low-Cost API is the same, but adding "WithLowCost" to the prefix.

- **testWithLowCost: targetMethod from: schema**
- **testWithLowCost: targetMethod from: schema for: time**
- **testWithLowCost: targetMethod from: schema times: times**
- **testWithLowCost: targetMethod from: schema withCoverageTolerance: tolerance**

## Charts to identify outlier

As part of the PBT result, we can create charts that facilitate the preview of outliers, here are some examples:

- **plotByAccumulatedCoverage**

![Screenshot 2025-02-03 at 11 51 12](https://github.com/user-attachments/assets/e1fce841-7f38-421a-a51f-d9f30cffa76c)

- **plotByCoverage**

![Screenshot 2025-02-03 at 11 51 37](https://github.com/user-attachments/assets/0881ac91-c5e7-4de0-8438-535af28d161b)
  
- **plotByAllocatedMemory**

![Screenshot 2025-02-03 at 11 47 44](https://github.com/user-attachments/assets/7acb4b94-0ff3-4466-816a-67730c420a58)

- **plotByExecutionTime**

![Screenshot 2025-02-03 at 11 47 19](https://github.com/user-attachments/assets/047f66fb-48af-40b6-bb5a-a462c1143ab8)

- **plotByScore**

![Screenshot 2025-02-03 at 11 45 50](https://github.com/user-attachments/assets/cf8a8090-39cd-468b-873c-914949c7a31b)

- **plotByFeedback**

## Other examples

### Integer#factorial

```Smalltalk
receiverConstraint := PBTObjectConstraint new generator: (PBTGenerator oneOf: (10 to: 100)).

assert := [ :n :args :result | n * (n - 1) factorial = result ].

schema := PBTSchema new receiverConstraint: receiverConstraint; assert: assert

PBTRunner test: Integer >> #factorial from: schema times: 2542 "<- Specifying the number of tests desired"
```

### SequenceableCollection#sort

```Smalltalk
receiverConstraint := PBTObjectConstraint new
		                     objectClass: OrderedCollection;
		                     generator:
			                     (PBTGenerator onceInstance: [ :instance :props |
					                      (Random new nextIntegerBetween: 1 and: 100)
						                      timesRepeat: [
							                      instance add: (props at: 'item') gen ].
					                      instance ]);
		                     props: { ('item' -> (PBTObjectConstraint new
					                       objectClass: SmallInteger;
					                       generator: (PBTGenerator oneOf: (10 to: 100)))) }.

assert := [ :coll :args :result | result = coll sort and: result size = coll size ].
schema := PBTSchema new receiverConstraint: receiverConstraint; assert: assert

PBTRunner test: SequenceableCollection >> #sort from: schema for: 2 seconds "<- Specifying the maximum time"
```

### Rectangle#area

```Smalltalk
generator := PBTGenerator onceInstance: [ :instance :props | instance
                    setPoint: (props at: 'origin') gen
                    point: (props at: 'corner') gen.
                    instance
                ].

receiverConstraint := PBTObjectConstraint new
                            objectClass: Rectangle;
                            generator: generator;
                            props: {
                                    ('origin' -> (PBTObjectConstraint new
                                            objectClass: Point;
                                            generator: PBTPointGenerator new)).
                                    ('corner' -> (PBTObjectConstraint new
                                        objectClass: Point;
                                        generator: PBTPointGenerator new)) }.
argumentConstraints := {}.

assert := [ :rect :args :result | result >= 0 ].
schema := PBTSchema new
                receiverConstraint: receiverConstraint;
                argumentConstraints: argumentConstraints;
                assert: assert

PBTRunner test: Rectangle >> #area from: schema withCoverageTolerance: 100 "<-Specifying the number of tests that don't improve the coverage tolerated before stopping the execution"
```

### DateParser#parse

```Smalltalk
dateConstraint := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: PzDateMDYYYYGrammar new).

receiverConstraint := PBTObjectConstraint new
                            objectClass: DateParser;
                            generator:
                                (PBTGenerator onceInstance: [ :parser :props |
                                        DateParser
                                            readingFrom:
                                                (props at: 'date') gen readStream
                                            pattern: 'm-d-yyyy' ]);
                            props: { ('date' -> dateConstraint) }.

assert := [ :coll :args :result | result class = Date ].
schema := PBTSchema new
                receiverConstraint: receiverConstraint;
                assert: assert

PBTRunner test: DateParser >> #parse from: schema
```
### Complex regex grammar generation

```Smalltalk

	randomGenerator := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100).

	regexGenerator := PBTGenerator base: [ randomGenerator gen ] mutating: [ :regexString | RxMatcher mutate: regexString using: randomGenerator gen ].

	regexConstraint := PBTObjectConstraint new generator: regexGenerator

	sharedProperties := InternalConstraintProperties from:
		                    { ('grammar' -> regexConstraint) }
			                    asDictionary.

	generator := PBTGenerator do: [ :props :feedback |
		             | regex |
		             regex := (props at: 'grammar') genBy: feedback.
		             props at: 'input' put: regex minimalStringMatching.
		             regex asRegex ].

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: RxMatcher;
		                      generator: generator;
		                      props: sharedProperties.

	argumentConstraints := { (PBTObjectConstraint new
		                        objectClass: String;
		                        props: sharedProperties;
		                        generator:
			                        (PBTGenerator do: [ :props :feedback |
					                         props at: 'input' ])) }.

	assert := [ :regex :input :result | result ].
	
	score := [ :re :inputs :res | | coreScore gnoccoScore anotherRegex | "Replicating the score experiment"
		coreScore := res time asMilliSeconds.
		anotherRegex := inputs first asRegex.
		gnoccoScore := [ anotherRegex matches: inputs first ] millisecondsToRun.
		coreScore / (gnoccoScore max: 1) "This allows us to avoid division by zero"
	].

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
			  guidedByScore;
		          assert: assert

	PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes
```
