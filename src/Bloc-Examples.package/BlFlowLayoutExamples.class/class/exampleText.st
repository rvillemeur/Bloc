examples
exampleText
	<example>
	| aText aLineIterator  theWords aParent aSpace floatA aFloatIndex |

	theWords := OrderedCollection new.

	aText := SpText fromString: (String loremIpsum: 2000).

	aLineIterator := aText rope iterator.

	[ aLineIterator hasNext ] whileTrue: [ 
		| aLine aWordIterator aBreak |
		aLine := aLineIterator nextLine.
		aWordIterator := aLine iterator.
		aBreak := true.
		[ aWordIterator hasNext ] whileTrue: [ 
			| aWord |
			aWord := aWordIterator nextWord.
			theWords add: (BlTextElement new
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent.
					c flow newLine: aBreak ];
				text: (SpText fromRope: aWord);
				yourself).
			aBreak := false ] ].

	floatA := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 63.
			c vertical exact: 155.
			c margin: (BlInsets top: 3 right: 3 bottom: 0 left: 3) ];
		background: Color red.

	aFloatIndex := (theWords size / 3) asInteger.
	
	theWords add: floatA afterIndex: aFloatIndex.
	aFloatIndex + 2 to: theWords size do: [ :anIndex |
		| anElement |
		anElement := (theWords at: anIndex).
		anElement text attributes: { SpTextForegroundAttribute paint: (Color red) }.
		anElement text: anElement text ].
	
	aParent := BlElement new
		layout: BlFlowLayout new horizontal;
		constraintsDo: [ :c |
			c horizontal exact: 600.
			c vertical fitContent.
			c padding: (BlInsets all: 10) ];
		position: 100 @ 50;
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color lightGray width: 8);
		addChildren: theWords;
		yourself.

	aSpace := BlSpace new.
	aSpace root addChild: aParent.
	
	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	aSpace show