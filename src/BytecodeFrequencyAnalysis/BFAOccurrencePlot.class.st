"
Uses a `RSCoOccurrenceMatrixBuilder` to build a matrix of occurrences:

  - Rows represent methods.
  - Columns represent bytecode sequences found in methods.
  - Each dot represents the presence of the bytecode sequence at the column in the method at a row.

See class side examples for usage.

"
Class {
	#name : #BFAOccurrencePlot,
	#superclass : #BFAPlot,
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFAOccurrencePlot class >> example [

	self 
		plotFromCSV: 'STON-compiled-methods.csv'  
		title: 'Bytecode Analysis for STON'
]

{ #category : #examples }
BFAOccurrencePlot class >> exampleMultiple [

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
BFAOccurrencePlot class >> exampleMultipleSave [

	| basePath |

	basePath := '/Users/mvs/git_projects/WORK/INRIA/images/superinstructions/pharo-11/final/'.
	#(
		'FileSystem-Sorted-by-class.csv' 'FileSystem'
		'NECompletion-Sorted-by-class.csv' 'NECompletion'
		'Collection-Sorted-by-class.csv' 'Collection'
		'Math-Sorted-by-class.csv' 'Math'
		'Morphic-Sorted-by-class.csv' 'Morphic'
		'PolyMath-Sorted-by-class.csv' 'PolyMath'
			)	
		pairsDo: [ : fileName : title  | 
			BFAOccurrencePlot 
				savePlotFromCSV: basePath , fileName 
				title: 'Occurrence Analysis of ' , title ]


]

{ #category : #examples }
BFAOccurrencePlot class >> exampleSave [

	self 
		savePlotFromCSV: 'STON-compiled-methods.csv'  
		title: 'Bytecode Analysis for STON'
]

{ #category : #'instance creation' }
BFAOccurrencePlot class >> plotFromCSV: aFileReference title: aString [
	" Open a plot window using aFileReference describing CSV results from bytecode frequency analysis "
	
	self new
		dataSource: aFileReference asFileReference;
		build;
		title: aString;
		plot.
]

{ #category : #'instance creation' }
BFAOccurrencePlot class >> savePlotFromCSV: aFileReference title: aString [
	" Open a plot window using aFileReference describing CSV results from bytecode frequency analysis "
	
	self new
		dataSource: aFileReference asFileReference;
		build;
		title: aString;
		savePlot.
]

{ #category : #building }
BFAOccurrencePlot >> build [

	self 
		buildDataFrame

]

{ #category : #'public - plots' }
BFAOccurrencePlot >> buildDataFrame [

	super buildDataFrame.
	self dataFrame replaceNilsWithZero
]

{ #category : #'public - plots' }
BFAOccurrencePlot >> plot [

	RSCoOccurrenceMatrixBuilder new
		dataSource: self dataFrame;
		open
]

{ #category : #'public - plots' }
BFAOccurrencePlot >> savePlot [

	RSCoOccurrenceMatrixBuilder new
		dataSource: self dataFrame;
		exportToFile: self title , '.pdf'.
]
