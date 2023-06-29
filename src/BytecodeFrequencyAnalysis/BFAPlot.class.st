"
Abstract class to specific bytecode frequence analysis plots.

"
Class {
	#name : #BFAPlot,
	#superclass : #BFAObject,
	#instVars : [
		'title',
		'threshold'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #'public - plots' }
BFAPlot >> compiledMethodsCount [

	^ String streamContents: [ : stream | 
		stream 
			space;
			<< '(';
			<< self dataFrame size asString;
			<< ' compiled methods)' ]
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
