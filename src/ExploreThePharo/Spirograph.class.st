Class {
	#name : #Spirograph,
	#superclass : #Morph,
	#instVars : [
		'paper',
		'showCircles',
		'roter'
	],
	#category : #ExploreThePharo
}

{ #category : #'instance creation' }
Spirograph class >> open [
	"Spirograph open"
	| aMorph |
	aMorph := self new
		openInWindow;
		stop;
		yourself.
	^aMorph
	
]

{ #category : #initialization }
Spirograph >> clear [
	
	paper clear.
	self changed



]

{ #category : #drawing }
Spirograph >> drawCirclesOn: aCanvas [

	| rect centerOfRoter penPointOfRoter center |
	center := self bounds center.
	
	rect := roter encompassingRectangleForOuterCircle translateBy: center.
	aCanvas fillOval: self bounds color: Color transparent borderWidth: 1 borderColor: Color black.
	
	rect := roter encompassingRectangle translateBy: center.
	aCanvas fillOval: rect color: Color transparent borderWidth: 1 borderColor: Color black.
	
	centerOfRoter := roter center translateBy: center.
	penPointOfRoter := roter penPoint translateBy: center.
	aCanvas line: centerOfRoter  to: penPointOfRoter color: Color green.

]

{ #category : #drawing }
Spirograph >> drawOn: aCanvas [
	
	self drawPaperOn: aCanvas.
	showCircles ifTrue: [ self drawCirclesOn: aCanvas ].

]

{ #category : #drawing }
Spirograph >> drawPaperOn: aCanvas [
	
	paper drawFormOn: aCanvas at: self bounds origin.

]

{ #category : #initialization }
Spirograph >> hideCircles [
	
	showCircles := false.
	self changed.


]

{ #category : #initialization }
Spirograph >> initialize [
	
	super initialize.
	self stopStepping.
	self showCircles.
	self size: 600.
	roter := SpirographRoter new
		stopBlock: [ self stop ];
		yourself.
	self radius: 35 penOffset: 25 penColor: Color red.

]

{ #category : #accessing }
Spirograph >> radius: anInteger1 penOffset: anInteger2 penColor: aColor [
	
	roter raius: anInteger1 offset: self extent x / 2 - anInteger1 penOffset: anInteger2 revolutionAngle: 1.
	paper penColor: aColor.
	self reset.


]

{ #category : #initialization }
Spirograph >> reset [
	
	roter reset.
	paper setPenAt: roter penPoint.
	self changed.
]

{ #category : #initialization }
Spirograph >> showCircles [
	
	showCircles := true.
	self changed.


]

{ #category : #accessing }
Spirograph >> size: anInteger [
	
	self extent: anInteger @ anInteger.
	paper := SpirographPaper new extent: self extent.
	self clear



]

{ #category : #stepping }
Spirograph >> start [

	super start.
	self changed.
]

{ #category : #stepping }
Spirograph >> step [

	roter revolve.
	paper movePenAt: roter penPoint.
	self changed.
]

{ #category : #stepping }
Spirograph >> stepTime [

	^10

]

{ #category : #stepping }
Spirograph >> stop [

	super stop.
	self changed.
]
