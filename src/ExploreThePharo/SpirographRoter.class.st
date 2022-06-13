Class {
	#name : #SpirographRoter,
	#superclass : #Object,
	#instVars : [
		'radius',
		'offset',
		'penOffset',
		'center',
		'penPoint',
		'revolutionAngle',
		'rotationAngle'
	],
	#category : #ExploreThePharo
}

{ #category : #accessing }
SpirographRoter >> center [

	^center
]

{ #category : #accessing }
SpirographRoter >> encompassingRectangle [

	^(center - radius) @ (center + radius)
]

{ #category : #accessing }
SpirographRoter >> encompassingRectangleForOuterCircle [

	| radiusOfOuterCircle origin |
	radiusOfOuterCircle := offset + radius.
	origin := 0@0.
	^(origin - radiusOfOuterCircle) @ (origin + radiusOfOuterCircle)
]

{ #category : #accessing }
SpirographRoter >> penPoint [

	^penPoint
]

{ #category : #accessing }
SpirographRoter >> raius: aNumber1 offset: aNumber2 penOffset: aNumber3 revolutionAngle: aNumber4 [

	radius := aNumber1.
	offset := aNumber2.
	penOffset := aNumber3.
	
	revolutionAngle := Float pi * aNumber4 / 180.
	rotationAngle := revolutionAngle negated * (offset + radius) / radius.
	
	self reset

]

{ #category : #initialization }
SpirographRoter >> reset [

	center := 0 @ offset negated.
	penPoint := 0 @ (offset + penOffset) negated.
]

{ #category : #moving }
SpirographRoter >> revolve [

	| newCenter |
	newCenter := center rotateBy: revolutionAngle centerAt: 0@0.
	penPoint := (penPoint translateBy: (newCenter - center)) rotateBy: rotationAngle centerAt: newCenter.
	center := newCenter.

]
