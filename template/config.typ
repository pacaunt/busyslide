// For a smooth experience
#import "@preview/pariman:0.2.2": * 
#import "@preview/chemformula:0.1.2": ch 
#import "@preview/cetz:0.4.2" as cetz: draw, canvas 
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node 
#import "@preview/rowmantic:0.5.0" as rowmantic: rowtable, rowgrid 
#import "@preview/gentle-clues:1.3.1" as gc

// Configuation Styles
#let info = (
  title: "Atoms & Elements",
  description: "อะตอมและสมบัติของธาตุ",
  author: "แทน SIIT 32",
  date: datetime.today().display("[Month repr:long] [year]"),
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