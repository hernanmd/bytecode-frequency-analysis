Class {
	#name : #BaselineOfBytecodeFrequencyAnalysis,
	#superclass : #BaselineOf,
	#category : #BaselineOfBytecodeFrequencyAnalysis
}

{ #category : #baselines }
BaselineOfBytecodeFrequencyAnalysis >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec 
				package: 'BytecodeFrequencyAnalysis';
				package: 'BytecodeFrequencyAnalysis-Tests'	with: [ spec requires: #(BytecodeFrequencyAnalysis) ].
					
			spec
				baseline: 'Roassal3Exporters'
				with: [ spec  repository: 'github://ObjectProfile/Roassal3Exporters' ];
				baseline: 'AIPharo'
				with: [ spec repository: 'github://pharo-ai/ai/src' ].

			spec 
				group: 'Core' 						with: #('BytecodeFrequencyAnalysis' 'AIPharo' 'Roassal3Exporters');
				group: 'Tests' 						with: #('BytecodeFrequencyAnalysis' 'BytecodeFrequencyAnalysis-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
