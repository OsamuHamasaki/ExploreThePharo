"
I represent a Spirograph roter.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	center:		<Object>
	offset:		<Object>
	penLocation:		<Object>
	penOffset:		<Object>
	radius:		<Object>
	revolutionAngle:		<Object>
	rotationAngle:		<Object>
	startPenLocation:		<Object>
	stopBlock:		<Object>


    Implementation Points
"
Class {
	#name : #SpirographRoter,
	#superclass : #Model,
	#instVars : [
		'radius',
		'offset',
		'penOffset',
		'center',
		'revolutionAngle',
		'rotationAngle',
		'startPenLocation',
		'penLocation'
	],
	#category : #ExploreThePharo
}

{ #category : #accessing }
SpirographRoter >> center [

	^center
]

{ #category : #accessing }
SpirographRoter >> encompassingRectangle [

	^(center - radius) corner: (center + radius)
]

{ #category : #accessing }
SpirographRoter >> encompassingRectangleForOuterCircle [

	| radiusOfOuterCircle origin |
	radiusOfOuterCircle := offset + radius.
	origin := 0@0.
	^(origin - radiusOfOuterCircle) corner: (origin + radiusOfOuterCircle)
]

{ #category : #'private - testing' }
SpirographRoter >> isPenOnStartLocation [
	
	^penLocation =~ startPenLocation
]

{ #category : #accessing }
SpirographRoter >> penLocation [

	^penLocation
]

{ #category : #accessing }
SpirographRoter >> radius: aNumber1 offset: aNumber2 penOffset: aNumber3 revolutionAngle: aNumber4 [

	radius := aNumber1.
	offset := aNumber2.
	penOffset := aNumber3.
	
	revolutionAngle := Float pi negated * aNumber4 / 180.
	rotationAngle := revolutionAngle negated * (offset + radius) / radius.
	
	self reset.
	self changed: #settings
]

{ #category : #accessing }
SpirographRoter >> raius: aNumber1 offset: aNumber2 penOffset: aNumber3 revolutionAngle: aNumber4 [

	radius := aNumber1.
	offset := aNumber2.
	penOffset := aNumber3.
	
	revolutionAngle := Float pi negated * aNumber4 / 180.
	rotationAngle := revolutionAngle negated * (offset + radius) / radius.
	
	self reset.
	self changed: #settings
]

{ #category : #initialization }
SpirographRoter >> reset [

	center := 0 @ offset negated.
	penLocation := 0 @ (offset + penOffset) negated.
	startPenLocation := penLocation.
]

{ #category : #moving }
SpirographRoter >> revolve [

	| newCenter |
	newCenter := center rotateBy: revolutionAngle about: 0@0.
	penLocation := (penLocation translateBy: (newCenter - center)) rotateBy: rotationAngle about: newCenter.
	center := newCenter.
	self changed: #location.
	self isPenOnStartLocation ifTrue: [ self changed: #atStartLocation ].

]
