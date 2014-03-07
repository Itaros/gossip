///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'Label' variables: '' classVariables: '')

META Label
title: t
    "create a simple label pane "

    ^ <70 self t>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'Button' variables: '' classVariables: '')

META Button
title: t action: b
    "create a button pane"

    ^ <71 self t b>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'TextComponent' variables: '' classVariables: '')
METHOD TextComponent
getText
    "Retrieve text"

   ^ <80 String self>
!
METHOD TextComponent
getSelectedText
    "Retrieve selected text"

   ^ <81 String self>
!
METHOD TextComponent
setText: s
    "Set text"

    ^ <82 self s>
!
METHOD TextComponent
keystroke: aString action: aBlock
    "Bind a block to a keystroke"

    <134 self aString aBlock>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( TextComponent subclass: 'TextLine' variables: '' classVariables: '')
META TextLine
textLine
    "Create a one-line text pane"
    ^ <72 self>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( TextComponent subclass: 'TextArea' variables: '' classVariables: '')
META TextArea
textArea
    "Create a multi-line text area"
    ^ <73 self>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'ListPane' variables: '' classVariables: '')
META ListPane
list: d action: b
    "Create a list pane"

    ^ <75 self d b>
!
METHOD ListPane
getIndex
    "Get index of the selected item"

    ^ <83 self>
!
METHOD ListPane
setList: d
    "set data"

    ^ <84 self d>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'Slider' variables: '' classVariables: '')
META Slider
hSliderFrom: low to: high do: b 
    " make horizontal slider "

    ^ <85 self false low high b>
!
META Slider
vSliderFrom: low to: high do: b 
    " make vertical slider "

    ^ <85 self true low high b>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'ImagePane' variables: '' classVariables: '')
META ImagePane
image: img
    ^ (self title: '') setImage: img
!
METHOD ImagePane
setImage: img
    "Set image on pane"
    <77 self img>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'Pane' variables: '' classVariables: '')
METHOD Pane
onMouseDown: b
    "add mouse action "
    <86 self [ :x :y | b value: x@y ] >
!
METHOD Pane
onMouseUp: b
    " on mouse up do action "
    <87 self  [ :x :y | b value: x@y ] >
!
METHOD Pane
onMouseMove: b
    "add mouse action "
    | t |
    
    <88 self [ :x :y | 
        t := x@y.
        b value: t ]>
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'GridPane' variables: '' classVariables: '')
META GridPane
rows: r columns: c data: d
  ^ <74 self c r d>
!
META GridPane
row: p
  ^ self rows: 1 columns: p size data: p
!
META GridPane
column: p
  ^ self rows: p size columns: 1 data: p
!
///////////////////////////////////////

///////////////////////////////////////
EVAL Class addNewClass: ( Object subclass: 'BorderPane' variables: '' classVariables: '')
META BorderPane
north: n center: c south: s
   ^ self north: n south: s east: nil west: nil center: c
!
META BorderPane
north: n south: s east: e west: w center: c
   ^ <76 self n s e w c>
!
META BorderPane
west: w east: e
  ^ self north: nil south: nil east: e west: w center: nil
!
META BorderPane
west: w east: e center: c
  ^ self north: nil south: nil east: e west: w center: c
!
///////////////////////////////////////
