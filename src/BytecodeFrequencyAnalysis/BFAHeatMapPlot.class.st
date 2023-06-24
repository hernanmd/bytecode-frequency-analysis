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
	heatMap setShouldFeedY.
	heatMap dependency: [ : e | (dataFrame row: e) value  ].
	heatMap shape popup.
	^ heatMap
]

{ #category : #building }
BFAHeatMapPlot >> buildLegendBelow [

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
