Class {
	#name : #BFABarPlot,
	#superclass : #BFAPlot,
	#instVars : [
		'chart',
		'occurrences',
		'columnNames'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFABarPlot class >> example [

	self 
		plotFromCSV: 'STON-compiled-methods.csv'  
		title: 'Bytecode Analysis for STON'
]

{ #category : #examples }
BFABarPlot class >> exampleMultiple [

	| basePath |

	basePath := ''.
	#(
		'STON-compiled-methods.csv' 'STON' 20
		'NECompletion-compiled-methods.csv' 'Completion' 20
		'FileSystem-compiled-methods.csv' 'FileSystem' 40
		'Collection-compiled-methods.csv' 'Collection' 40
		'Math-compiled-methods.csv' 'PolyMath' 40
	)	
		triplesDo: [ : fileName : title : thresholdValue| BFABarPlot 
			plotFromCSV: basePath , fileName 
			title: 'Bytecode Analysis of ' , title
			threshold: thresholdValue ]


]

{ #category : #examples }
BFABarPlot class >> exampleMultipleSave [

	| basePath |

	basePath := ''.
	#(
		'STON-compiled-methods.csv' 'STON' 20
		'NECompletion-compiled-methods.csv' 'Completion' 20
		'FileSystem-compiled-methods.csv' 'FileSystem' 40
		'Collection-compiled-methods.csv' 'Collection' 100
		'Math-compiled-methods.csv' 'PolyMath' 100
	)	
		triplesDo: [ : fileName : title : thresholdValue | 
			BFABarPlot 
				savePlotFromCSV: basePath , fileName 
				title: 'Bytecode Analysis of ' , title
				threshold: thresholdValue ]


]

{ #category : #examples }
BFABarPlot class >> exampleSave [

	self 
		savePlotFromCSV: 'STON-compiled-methods.csv'  
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

{ #category : #'instance creation' }
BFABarPlot class >> plotFromCSV: aFileReference title: aString threshold: anInteger [
	" Open a plot window using aFileReference describing CSV results from bytecode frequency analysis "
	
	self new
		dataSource: aFileReference asFileReference;
		threshold: anInteger;
		build;
		title: aString;
		plot.
]

{ #category : #'instance creation' }
BFABarPlot class >> savePlotFromCSV: aFileReference title: aString [
	" Open a plot window using aFileReference describing CSV results from bytecode frequency analysis "
	
	self new
		dataSource: aFileReference asFileReference;
		build;
		title: aString;
		savePlot.
]

{ #category : #'instance creation' }
BFABarPlot class >> savePlotFromCSV: aFileReference title: aString threshold: anInteger [
	" Open a plot window using aFileReference describing CSV results from bytecode frequency analysis "
	
	self new
		dataSource: aFileReference asFileReference;
		threshold: anInteger;
		build;
		title: aString;
		savePlot.
]

{ #category : #'public - plots' }
BFABarPlot >> build [

	self 
		buildDataFrame
		buildFilter;
		buildChart;
		buildLegendBelow
]

{ #category : #'public - plots' }
BFABarPlot >> buildChart [

	chart := RSChart new.
	chart barHeights: self occurrences.
	chart horizontalTick 
		doNotUseNiceLabel;
		fromNames: self columnNames;
		fontSize: 4;
		useDiagonalLabel.
	chart verticalTick integer.
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
		title: self title , self compiledMethodsCount;
		ylabel: 'Occurrences';
		open
]

{ #category : #'public - plots' }
BFABarPlot >> savePlot [

	self chart
		title: self title , self compiledMethodsCount;
		ylabel: 'Occurrences';
		build.
	self chart canvas @ RSCanvasController.
	RSPDFCairoExporter new
		zoomToShapes;
		canvas: self chart canvas;
		exportToFile: (self title , '.pdf') asFileReference.
]
