#import "themes/clean.typ": *

#let mock-image = block.with(width: 100%, height: 1fr, fill: gray.lighten(50%))

#show: styler
#show regex("\p{thai}+"): set text(font: "IBM Plex Sans Thai")

#title-slide()

= Introduction

== Slide Title

=== Here is the title

#slide[
  Slide title can be created by using the level-3 heading.
]

= Layouts

== blank

=== Blank Slide

#slide[
  #lorem(50)
]

== side-image

=== Side Image Slide
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

=== Integration with Mannot

#slide[
  #import "@preview/mannot:0.3.2": *
  #show: pause
  $ a^2 + b^2 = markhl(c^2) $

  Highlight
  $
    mathrect(integral_0^oo e^(-x^2) dif x &= sqrt(pi)/2)
  $
]

#[
  #show: set-element("slide-title", cont: true, cont-display: " (cont.)")

  #slide[
    Anothe Slide #show: pause;
    Hello
  ]

]

== Alchemist

=== Integration with Alchemist
#slide[
  #skeletize({
    single(1)
    fragment("CH_3")
    single(-1)
  })
]


= Last Section

#slide[

]
