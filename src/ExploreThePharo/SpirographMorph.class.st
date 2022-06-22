"
I am a Morph represented a Spirograph.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	borderColor:		<Object>
	fillColor:		<Object>
	paper:		<Object>
	roter:		<Object>
	showCircles:		<Object>


    Implementation Points
"
Class {
	#name : #SpirographMorph,
	#superclass : #Morph,
	#instVars : [
		'size',
		'paper',
		'showCircles',
		'roter',
		'fillColor',
		'borderColor',
		'encompassingRectForOuterCircle',
		'updatingMethods'
	],
	#category : #ExploreThePharo
}

{ #category : #'instance creation' }
SpirographMorph class >> open [
	"SpirographMorph open"
	| aMorph roter |
	roter := SpirographRoter new.
	aMorph := self new
		roter: roter;
		openInWindow;
		stop;
		yourself.
	roter radius: 35 offset: (aMorph size / 2 - 35) penOffset: 25 revolutionAngle: 1.

	^aMorph
	
]

{ #category : #initialization }
SpirographMorph >> clear [
	
	paper clear.
	self changed



]

{ #category : #default }
SpirographMorph >> defaultPenColor [
	
	^Color red
]

{ #category : #default }
SpirographMorph >> defaultSize [

	^600
]

{ #category : #drawing }
SpirographMorph >> drawCirclesOn: aCanvas [

	| rects centerOfRoter penPointOfRoter center |
	center := self bounds center.
	rects := { encompassingRectForOuterCircle . roter encompassingRectangle }.
	rects do: [ :rect |
		aCanvas fillOval: (rect translateBy: center) color: fillColor borderWidth: 1 borderColor: borderColor.
		 ].

	centerOfRoter := roter center translateBy: center.
	penPointOfRoter := roter penLocation translateBy: center.
	aCanvas line: centerOfRoter  to: penPointOfRoter color: Color green.

]

{ #category : #drawing }
SpirographMorph >> drawOn: aCanvas [
	
	self drawPaperOn: aCanvas.
	showCircles ifTrue: [ self drawCirclesOn: aCanvas ].

]

{ #category : #drawing }
SpirographMorph >> drawPaperOn: aCanvas [
	
	paper drawFormOn: aCanvas at: self bounds origin.

]

{ #category : #initialization }
SpirographMorph >> hideCircles [
	
	showCircles := false.
	self changed.


]

{ #category : #initialization }
SpirographMorph >> initialize [
	
	super initialize.
	self showCircles.
	self size: self defaultSize.
	self penColor: self defaultPenColor.
	fillColor := Color transparent.
	borderColor := Color black.
	updatingMethods := Dictionary newFrom: { 
		#location -> [ paper movePenAt: roter penLocation. self changed. ] . 
		#atStartLocation -> [ self stop ] .
		#settings -> [ encompassingRectForOuterCircle := roter  encompassingRectangleForOuterCircle. self reset. ] }.
]

{ #category : #accessing }
SpirographMorph >> penColor: aColor [
	
	paper penColor: aColor.

]

{ #category : #initialization }
SpirographMorph >> reset [
	
	roter reset.
	paper setPenAt: roter penLocation.
	self changed.
]

{ #category : #accessing }
SpirographMorph >> roter: aSpirographRoter [

	roter := aSpirographRoter.
	roter addDependent: self.
]

{ #category : #initialization }
SpirographMorph >> showCircles [
	
	showCircles := true.
	self changed.


]

{ #category : #accessing }
SpirographMorph >> size [
	
	^size
]

{ #category : #accessing }
SpirographMorph >> size: anInteger [
	
	size := anInteger.
	self extent: anInteger @ anInteger.
	paper := SpirographPaper extent: self extent.
	self clear



]

{ #category : #'stepping and presenter' }
SpirographMorph >> start [

	super start.
	self changed.
]

{ #category : #'stepping and presenter' }
SpirographMorph >> step [

	roter revolve.

]

{ #category : #stepping }
SpirographMorph >> stepTime [

	^10

]

{ #category : #'stepping and presenter' }
SpirographMorph >> stop [

	super stop.
	self changed.
]

{ #category : #updating }
SpirographMorph >> update: aspectSymbol [

	| updateMethod |
	updateMethod := updatingMethods at: aspectSymbol ifAbsent: [ [] ].
	updateMethod value
]
