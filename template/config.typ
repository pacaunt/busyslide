// For a smooth experience
#import "@preview/pariman:0.2.2": * 
#import "@preview/chemformula:0.1.2": ch 
#import "@preview/cetz:0.4.2" as cetz: draw, canvas 
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node 
#import "@preview/rowmantic:0.5.0" as rowmantic: rowtable, rowgrid 
#import "@preview/gentle-clues:1.3.1" as gc
#import "@preview/alchemist:0.1.8": * 

// Configuation Styles
#let info = (
  title: "Atoms & Elements",
  description: "อะตอมและสมบัติของธาตุ",
  author: "แทน SIIT 32",
  date: datetime.today().display("[Month repr:long] [year]"),
  image: block(width: 100%, height: 100%, fill: luma(230)),
  palette: (
    primary: teal.mix(luma(50)),
    secondary: teal.mix(luma(200)),
    light: gray,
    accent: orange,
    dark: luma(30),
  ),
  main-font: "TeX Gyre Termes",
  math-font: "XITS Math",
  progressive-outline-args: (
    separator: "  >  ",
  ),
  handout: false,
)

#let bond-wrapper(func) = (..args) => {
  if args.pos() != () { func(angle: args.pos().first(), ..args.named()) } else { func(..args) }
}

#let (single, double, triple, cram-dashed-left, cram-dashed-right, cram-filled-left, cram-filled-right) = (single, double, triple, cram-dashed-left, cram-dashed-right, cram-filled-left, cram-filled-right).map(bond-wrapper)

#let skeletize = skeletize-config((
  atom-sep: 1.5cm,
  angle-increment: 30deg, 
))

#let mathrect(body) = rect(math.equation(block: true, body))