Class {
	#name : #BaselineOfBytecodeFrequenceAnalysis,
	#superclass : #BaselineOf,
	#category : #BaselineOfBytecodeFrequenceAnalysis
}

{ #category : #baselines }
BaselineOfBytecodeFrequenceAnalysis >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec 
				package: 'BytecodeFrequenceAnalysis';
				package: 'BytecodeFrequenceAnalysis-Tests'	with: [ spec requires: #(BytecodeFrequenceAnalysis) ].
					
		    spec
				baseline: 'AIPharo'
				with: [ spec repository: 'github://pharo-ai/ai/src' ].

			spec 
				group: 'Core' 						with: #('BytecodeFrequenceAnalysis' 'AIPharo');
				group: 'Tests' 						with: #('BytecodeFrequenceAnalysis' 'BytecodeFrequenceAnalysis-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
