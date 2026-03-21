#import "dependencies.typ": *
#import "utils.typ"
#import "stylish/core.typ" as sty: element, get-fields, select, set-element, show-element

#let prefix = "busyslide:" + toml("../typst.toml").package.version
#let (element, select, set-element, show-element) = sty.setup(prefix)

#let slide-title(title, level: 3, cont: false, cont-display: " (cont.)") = element(
  fields: (
    body: title,
    level: level,
    cont: cont,
    cont-display: cont-display,
  ),
  class: "slide-title",
  it => {
    let fields = it.fields
    if fields.body == none { return none }
    if fields.body != auto {
      if fields.cont {
        fields.body += fields.cont-display
      }
      return block(fields.body)
    }
    let headings = query(
      selector
        .or(
          ..range(1, fields.level + 1).map(i => heading.where(level: i)),
        )
        .before(here()),
    )
    if headings == () or headings.last().level < fields.level { return none }

    let number = if heading.numbering != none {
      element(class: "slide-heading-number", counter(heading).display(heading.numbering))
      element(class: "slide-heading-separator", [ ])
    }
    fields.body = headings.filter(h => h.level == fields.level).last().body + if fields.cont { fields.cont-display }

    if number != none { stack(dir: ltr, number, fields.body) } else { block(fields.body) }
  },
)

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
