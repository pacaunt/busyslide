// For a smooth experience
#import "@preview/pariman:0.2.2": * 
#import "@preview/chemformula:0.1.2": ch 
#import "@preview/cetz:0.4.2" as cetz: draw, canvas 
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node 
#import "@preview/rowmantic:0.5.0" as rowmantic: rowtable, rowgrid 

// Configuation Styles
#let info = (
  title: "Nature Template",
  description: "Some cool description about this presentation",
  author: "John Doe",
  date: datetime.today().display(),
  image: block(width: 100%, height: 100%, fill: luma(230)),
  palette: (
    primary: teal.mix(luma(20)),
    secondary: teal.mix(luma(200)),
    light: gray,
    accent: orange,
    dark: luma(30),
  ),
  main-font: "TeX Gyre Termes",
  math-font: "TeX Gyre Termes Math",
  progressive-outline-args: (
    separator: "  >  ",
  ),
)