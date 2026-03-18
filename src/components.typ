#import "dependencies.typ": *
#import "utils.typ"
#import "stylish/core.typ" as sty: element, get-fields, select, set-element, show-element

#let prefix = "busyslide:" + toml("../typst.toml").package.version
#let (element, select, set-element, show-element) = sty.setup(prefix)

#let slide-title(title) = {
  if title == none { return none }
  if title != auto { return title }
  let headings = query(selector.or(heading.where(level: 1), heading.where(level: 2)).before(here()))
  if headings == () or headings.last().level < 2 { return none }

  let number = if heading.numbering != none {
    element(class: "slide-heading-number", counter(heading).display(heading.numbering))
    element(class: "slide-heading-separator", [ ])
  }
  let title = headings.filter(h => h.level == 2).last().body

  if number != none { stack(dir: ltr, number, title) } else { block(title) }
}

#let presentation-title(body) = element(class: "title", body)
#let presentation-description(body) = element(class: "description", body)
#let presentation-author(body) = element(class: "author", body)
#let presentation-date(body) = element(class: "date", body)

#let arrange(..bodies, dir: ltr, column-width: auto) = element(
  class: "arrange",
  fields: (
    bodies: bodies.pos(),
    ..bodies.named(),
    dir: dir,
    column-width: column-width,
  ),
  it => {
    let fields = it.fields
    let bodies = fields.remove("bodies")
    let column-width = fields.remove("column-width")
    let dir = fields.remove("dir")
    let styles = fields // left-over arguments
    let n = bodies.len()
    let resolve-column-width(n, width) = {
      if type(width) != array { width = (width,) }
      let more-number = n - width.len()
      for i in range(more-number) {
        width += (width.at(calc.rem(i, width.len())),)
      }
      return width
    }
    let default-layout(..args) = grid(..args, ..bodies, gutter: 1em, ..styles)

    if dir == ltr {
      default-layout(columns: resolve-column-width(n, column-width))
    } else if dir == ttb {
      default-layout()
    } else {
      panic("Directions supported are ttb and rtl.")
    }
  },
)
