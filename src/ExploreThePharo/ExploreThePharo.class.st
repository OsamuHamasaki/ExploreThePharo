"
I have result collection of exploring the Pharo.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ExploreThePharo,
	#superclass : #Object,
	#category : #ExploreThePharo
}

{ #category : #utilities }
ExploreThePharo class >> findClassOf: anObject definedSelector: aSelector [

	"ExploreThePharo findClassOf: Object definedSelector: #new"

	| result aClass |
	result := WriteStream with: ''.

	aClass := anObject class.
	[ 
	result nextPutAll: aClass printString.
	aClass isNil or: [ aClass selectors includes: aSelector ] ] 
		whileFalse: [ 
			result nextPutAll: ' -> '.
			aClass := aClass superclass ].

	^ result contents
]

{ #category : #utilities }
ExploreThePharo class >> screenImageCapture [

	| aForm aMorph aPresenter |
	aForm := self currentWorld imageFormForRectangle: Rectangle fromUser.
	aMorph := ImageMorph withForm: aForm.
	aPresenter := SpMorphPresenter new morph: aMorph.
	aPresenter open
]
