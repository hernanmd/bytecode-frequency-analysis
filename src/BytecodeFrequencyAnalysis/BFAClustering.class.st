Class {
	#name : #BFAClustering,
	#superclass : #BFAMethodCollector,
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #private }
BFAClustering >> kMeans [

	| kMeans |
	kMeans := AIKMeans numberOfClusters: 12.
	kMeans fit: self dataFrame
]
