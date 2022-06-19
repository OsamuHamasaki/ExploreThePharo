"
I represent a paper media for Spirograph.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	canvas:		<Object>
	center:		<Object>
	form:		<Object>
	penColor:		<Object>
	previousPenLocation:		<Object>


    Implementation Points
"
Class {
	#name : #SpirographPaper,
	#superclass : #Object,
	#instVars : [
		'form',
		'canvas',
		'penColor',
		'center',
		'previousPenLocation'
	],
	#category : #ExploreThePharo
}

{ #category : #geometry }
SpirographPaper class >> extent: aPoint [

	^ self new
		extent: aPoint;
		yourself
]

{ #category : #accessing }
SpirographPaper >> clear [

	canvas fillColor: Color white.

]

{ #category : #accessing }
SpirographPaper >> drawFormOn: aCanvas at: aPoint [

	aCanvas drawImage: form at: aPoint

]

{ #category : #accessing }
SpirographPaper >> extent: aPoint [

	form := ColorForm extent: aPoint depth: 8.
	canvas := form getCanvas.
	center := aPoint / 2.
]

{ #category : #accessing }
SpirographPaper >> movePenAt: aPoint [
	
	| newPenLocation |
	newPenLocation := aPoint translateBy: center.
	canvas line: previousPenLocation to: newPenLocation color: penColor.
	previousPenLocation := newPenLocation.

]

{ #category : #accessing }
SpirographPaper >> penColor: aColor [

	penColor := aColor
]

{ #category : #accessing }
SpirographPaper >> setPenAt: aPoint [
	
	previousPenLocation := aPoint translateBy: center.
]

{ #category : #accessing }
SpirographPaper >> size: anInteger [

	form := ColorForm extent: anInteger @ anInteger.
	canvas := form getCanvas.
	center := form extent / 2.
]
