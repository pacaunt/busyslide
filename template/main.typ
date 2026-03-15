// For a smooth experience
#import "@preview/pariman:0.2.2": * 
#import "@preview/chemformula:0.1.2": ch 
#import "@preview/cetz:0.4.2" as cetz: draw, canvas 
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node 
#import "@preview/rowmantic:0.5.0" as rowmantic: rowtable, rowgrid 
// main template 
#import "themes/nature.typ": * 

#let mock-image = block.with(width: 100%, height: 1fr, fill: gray.lighten(50%))
#show: styler

#title-slide()

= Introduction

== Slide Title

#slide[
    Slide title can be created by using the level-2 heading.
]

= Layouts

== blank

#slide[
    #lorem(50)
]

== side-image 

#side-image-slide[
    #lorem(50)
    #tc1[Some Text]
    #tc2[Another Text]
][
    #mock-image()
]

= Animations 

== Alert form
#slide[
    A Good Presentation #alert(auto)[starts here].
]

== Mannot 
#slide[
    #import "@preview/mannot:0.3.2": *
    #show: pause 
    $ a^2 + b^2 = markhl(c^2) $
]


= Last Section

#slide[

]