#import "dependencies.typ": *
#import "components.typ": element, slide-title

#let general-slide(title: auto, body, ..styles) = presentate.slide(
  {
    element(context slide-title(title), class: "slide-title")
    element(body, class: "slide-body")
  },
  ..styles,
)

#let transition-slide(body) = element(
  class: "transition-slide",
  {
    presentate.slide(body, logical-slide: false)
  },
)

#let general-title-slide(body) = element(
  class: "title-slide",
  {
    presentate.slide(body, logical-slide: false)
  },
)

// #let slide(
//   title: auto, 
//   layout: "blank",
//   body, 
//   ..styles
// ) = element(
//   class: "slide-layout-" + layout, 
//   general-slide(title: title, body, ..styles)
// )