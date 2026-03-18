#import "@local/busyslide:0.1.0": *
#import "../config.typ": *

#let title-slide(info: info) = general-title-slide({
  import components: *
  arrange[
    #element(none, class: "decorator-rect")
    #v(1fr)
    #presentation-title(title())
    #presentation-description(info.description)
    #v(1fr)

    #presentation-author(info.author) \
    #presentation-date(info.date)
  ][
    #element(none, class: "decorator-background")
    #info.image
  ]
})

#let styler(body) = {
  show: init.with(info)
  set page(paper: "presentation-16-9", numbering: "1/1")
  set text(size: 20pt, font: info.main-font, fill: info.palette.dark)
  show math.equation: set text(font: info.math-font)

  show select("title-slide.description"): set text(bottom-edge: "bounds", fill: red)
  show select("title-slide"): it => {
    show: set-element("arrange", column-width: 1fr, gutter: 2cm)
    show select("decorator-rect"): it => {
      place(top + left, rect(
        fill: info.palette.primary,
        width: 60%,
        height: -2cm,
      ))
    }
    show select("decorator-background"): it => {
      place(bottom + left, dy: 2cm, dx: -2cm, rect(
        fill: info.palette.secondary,
        width: 100% + 4cm,
        height: 5cm,
      ))
    }
    show select("description"): set text(bottom-edge: "bounds")
    show select("description"): it => {
      block(
        stroke: (left: 4pt + info.palette.secondary),
        inset: (left: .8em),
        outset: (y: .2em),
        it,
      )
    }
    show select("title"): set text(size: 1.5em, fill: info.palette.primary)
    show select("title"): upper
    it
  }

  show select("slide-header"): set text(size: 0.8em, fill: info.palette.light)

  show select("slide-footer"): set text(size: 0.8em, fill: info.palette.light)


  show select("slide-body"): set image(height: 1fr, fit: "contain")

  show select("transition-slide"): set page(fill: info.palette.primary)
  show select("transition-slide"): set text(size: 1.2em)

  show select("slide-title"): set block(below: .8em)
  show select("slide-title"): set text(size: 2em, weight: "bold", fill: info.palette.primary)
  show select("slide-title"): set stack(spacing: .3em)

  set highlight(fill: info.palette.secondary)

  body
}

#let slide = general-slide

#let side-image-slide(
  info: info,
  title: auto,
  body,
  fig,
) = {
  show select("slide-body"): set align(horizon)
  show select("decorator"): it => {
    place(horizon + right, rect(
      width: 4cm,
      height: 100% + 4cm,
      outset: (right: 2cm),
      fill: info.palette.secondary,
    ))
  }
  general-slide(
    title: title,
    {
      element(none, class: "decorator")
      components.arrange(
        column-width: (1fr, 1fr),
        body,
        fig,
      )
    },
  )
}

#let alert = alert.with(func: it => text(fill: info.palette.accent, emph(it)))

#let (tc1, tc2, tc3) = (
  info.palette.primary,
  info.palette.secondary,
  info.palette.accent,
).map(c => text.with(fill: c, weight: "bold"))
