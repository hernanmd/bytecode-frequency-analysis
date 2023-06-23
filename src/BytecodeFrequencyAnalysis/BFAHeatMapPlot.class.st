Class {
	#name : #BFAHeatMapPlot,
	#superclass : #BFABarPlot,
	#instVars : [
		'heatMap'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFAHeatMapPlot class >> example [

	BFAHeatMapPlot 
		plotFromCSV: '../final/STON-compiled-methods.csv'  
		title: 'Bytecode Analysis for STON'
]

{ #category : #building }
BFAHeatMapPlot >> buildChart [

	heatMap := RSDSM new.
	heatMap objectsX: self dataFrame columnNames.
	heatMap objectsY: self dataFrame rowNames.
	heatMap dependency: #size.
	heatMap shape popup.
	^ heatMap
]

{ #category : #'public - plots' }
BFAHeatMapPlot >> buildDataFrame [

	dataFrame :=  DataFrame readFromCsvWithRowNames: self dataSource.
	dataFrame := self groupAndAggregateByClass: 1.
	

]

{ #category : #building }
BFAHeatMapPlot >> buildLegendBelow [

]

{ #category : #'public - plots' }
BFAHeatMapPlot >> groupAndAggregateByClass: columnPosition [

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
BFAHeatMapPlot >> heatMap [

	^ heatMap
]

{ #category : #accessing }
BFAHeatMapPlot >> heatMap: anObject [

	heatMap := anObject
]

{ #category : #'public - plots' }
BFAHeatMapPlot >> plot [

	self heatMap open
]
