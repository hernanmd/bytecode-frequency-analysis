"
Given a data source and a combination in the form of a `Collection` of bytecode `Number`, group by class.
"
Class {
	#name : #BFACombinationGrouper,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'dataFrame',
		'targetBytecodeCombination'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFACombinationGrouper class >> example [

	BFACombinationGrouper new
		targetBytecodeCombination: #();
		group
]

{ #category : #accessing }
BFACombinationGrouper >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
BFACombinationGrouper >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #accessing }
BFACombinationGrouper >> dataSource [

	^ dataSource
]

{ #category : #accessing }
BFACombinationGrouper >> dataSource: anObject [

	dataSource := anObject
]

{ #category : #'public - plots' }
BFACombinationGrouper >> group [
	"Answer a new <DataFrame> grouped the source data frame by class at the targetBytecodeCombination column "

	dataFrame :=  DataFrame readFromCsvWithRowNames: self dataSource.
	^ self groupAndAggregateByClass: (dataFrame column: self targetBytecodeCombination)
	

]

{ #category : #'public - plots' }
BFACombinationGrouper >> groupAndAggregateByClass: columnPosition [

	| classNames |

	classNames := dataFrame rowNames collect: [ : rowName | rowName copyUpToSubstring: '>>' ].
	dataFrame 
		addColumn: classNames 
		named: 'Classes'.
	^ dataFrame
		groupBy: 'Classes' 
		aggregate: { (dataFrame columnNames at: columnPosition) using: #sum }.

]

{ #category : #accessing }
BFACombinationGrouper >> targetBytecodeCombination [

	^ targetBytecodeCombination
]

{ #category : #accessing }
BFACombinationGrouper >> targetBytecodeCombination: anObject [

	targetBytecodeCombination := anObject
]
