#import "components.typ": *
#import "slides.typ": *

#let enable-transition(info, ..args) = render-transition(
  theme-colors: info.palette,
  slide-func: (fill: none, body) => {
    set page(fill: fill)
    transition-slide(element(body, class: "transition-slide-body"))
  },
  ..args,
)

#let init(info, body) = {
  set document(
    title: info.title, 
    author: info.author, 

  )
  show heading: enable-transition.with(info)
  set page(
    header: element(
      class: "slide-header",
      progressive-outline(
        layout: "horizontal",
        level-1-mode: "all",
        level-2-mode: "none",
        text-styles: (
          level-1: (
            active: (fill: info.palette.secondary, weight: "bold"),
            inactive: (fill: info.palette.light, weight: "regular"), 
            completed: (fill: info.palette.light, weight: "bold"),
          )
        ), 
        separator: element(" | ", class: "progressive-outline-separator"), 
        ..info.at("progressive-outline-args", default: (:))
      ),
    ),
    footer: element(
      class: "slide-footer",
      context {
        element(info.author, class: "author")
        element(h(1fr), class: "footer-sep")
        if page.numbering != none {
          element(counter(page).display(page.numbering), class: "slide-number")
        }
      },
    ),
  )

  show select("title-slide"): set page(header: none, footer: none)
  show select("transition-slide"): set page(header: none, footer: none)
  presentate.set-options(handout: info.handout)
  body
}
