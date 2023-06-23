Class {
	#name : #BFAPlot,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'dataFrame',
		'title',
		'threshold'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #'public - plots' }
BFAPlot >> buildDataFrame [

	dataFrame :=  DataFrame readFromCsvWithRowNames: self dataSource
]

{ #category : #'public - plots' }
BFAPlot >> compiledMethodsCount [

	^ String streamContents: [ : stream | 
		stream 
			space;
			<< '(';
			<< self dataFrame size asString;
			<< ' compiled methods)' ]
]

{ #category : #'public - plots' }
BFAPlot >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
BFAPlot >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #accessing }
BFAPlot >> dataSource [

	^ dataSource
]

{ #category : #accessing }
BFAPlot >> dataSource: anObject [

	dataSource := anObject
]

{ #category : #accessing }
BFAPlot >> threshold [

	^ threshold
		ifNil: [ threshold := 20 ]
]

{ #category : #accessing }
BFAPlot >> threshold: anObject [

	threshold := anObject
]

{ #category : #accessing }
BFAPlot >> title [

	^ title
]

{ #category : #accessing }
BFAPlot >> title: anObject [

	title := anObject
]
