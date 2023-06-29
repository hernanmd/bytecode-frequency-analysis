Class {
	#name : #BFAHeatMapPlot,
	#superclass : #BFABarPlot,
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

	| plot |
	chart := RSChart new.
	plot := RSScatterPlot new 
		x: self dataFrame columnNames
		y: self dataFrame rowNames.
	chart addPlot: plot.
	chart padding: 10.
	"plot ellipses with: classes do: [ :e :cls | e model: cls ].
	plot ellipses @ (RSPopup themeText: [:model | model name, String cr, 'LOC: ', model linesOfCode asString])."
	^ chart


]

{ #category : #building }
BFAHeatMapPlot >> buildLegendBelow [

]
