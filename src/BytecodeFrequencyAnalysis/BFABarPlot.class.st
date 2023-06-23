Class {
	#name : #BFABarPlot,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'chart',
		'title',
		'occurrences',
		'columnNames',
		'dataFrame',
		'threshold'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFABarPlot class >> example [

	self 
		plotFromCSV: 'STON-compiled-methods.csv'  
		title: 'Bytecode Analysis for STON'
]

{ #category : #'instance creation' }
BFABarPlot class >> plotFromCSV: aFileReference title: aString [
	" Open a plot window using aFileReference describing CSV results from bytecode frequency analysis "
	
	self new
		dataSource: aFileReference asFileReference;
		build;
		title: aString;
		plot.
]

{ #category : #'public - plots' }
BFABarPlot >> build [

	self 
		buildDataFrame
		buildFilter;
		buildChart.

]

{ #category : #'public - plots' }
BFABarPlot >> buildChart [

	chart := RSChart new.
	chart barHeights: self occurrences.
	chart horizontalTick 
		doNotUseNiceLabel;
		fromNames: self columnNames;
		fontSize: 3;
		useDiagonalLabel.
	chart verticalTick integer.
]

{ #category : #'public - plots' }
BFABarPlot >> buildDataFrame [

	dataFrame :=  DataFrame readFromCsvWithRowNames: self dataSource
]

{ #category : #'public - plots' }
BFABarPlot >> buildFilter [
	"Private - Calculate the sum of each row and column to get an idea of the total occurrences of bytecode combinations across functions (column sum) and the presence or absence of bytecode combinations within each function (row sum)."

	| columns |
	columns := self dataFrame columns select: [ : bytecodeCombinationColumn | bytecodeCombinationColumn sum >= self threshold ].
	self columnNames: (columns collect: [ : bcs | bcs name asString ]).
	self occurrences: (columns collect: #sum).

]

{ #category : #building }
BFABarPlot >> buildLegendBelow [

	| lb |
	lb := RSLegend new.
	lb layout horizontal.
	lb text: 'Bytecode Sequence' withBoxColor: self chart plots first computeColor.
	lb container: self chart canvas.
	lb location bottom; right; offset: 80.
	lb build.
]

{ #category : #accessing }
BFABarPlot >> chart [

	^ chart
]

{ #category : #accessing }
BFABarPlot >> chart: anObject [

	chart := anObject
]

{ #category : #accessing }
BFABarPlot >> columnNames [

	^ columnNames
]

{ #category : #accessing }
BFABarPlot >> columnNames: anObject [

	columnNames := anObject
]

{ #category : #'public - plots' }
BFABarPlot >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
BFABarPlot >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #accessing }
BFABarPlot >> dataSource [

	^ dataSource
]

{ #category : #accessing }
BFABarPlot >> dataSource: anObject [

	dataSource := anObject
]

{ #category : #accessing }
BFABarPlot >> occurrences [

	^ occurrences
]

{ #category : #accessing }
BFABarPlot >> occurrences: anObject [

	occurrences := anObject
]

{ #category : #'public - plots' }
BFABarPlot >> plot [

	self chart
		title: self title;
		ylabel: 'Occurrences';
		open
]

{ #category : #accessing }
BFABarPlot >> threshold [

	^ threshold
		ifNil: [ threshold := 20 ]
]

{ #category : #accessing }
BFABarPlot >> threshold: anObject [

	threshold := anObject
]

{ #category : #accessing }
BFABarPlot >> title [

	^ title
]

{ #category : #accessing }
BFABarPlot >> title: anObject [

	title := anObject
]
