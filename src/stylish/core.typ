#import "utils.typ"

#let element-kind = "element_information"

#let is-element(prefix: none, meta-info) = {
  if type(meta-info) != content or meta-info.func() != metadata { return false }
  let info = meta-info.value
  (
    type(info) == dictionary and "kind" in info and info.kind == prefix + "_" + element-kind
  )
}

#let element(
  display,
  fields: (:),
  prefix: none,
  class: none,
  id: none,
  label: none,
  family: none, // accepted as info
) = {
  assert(prefix != none, message: "A uniquw prefix must be specified.")

  let info = (
    kind: prefix + "_" + element-kind,
    display: display,
    fields: fields,
    class: class,
    id: "#" + id,
    label: label,
  )

  let family-class 
  let family-id

  if family != none {
    family-class = (family.parent, class).join(".")
    family-id = (family.parent-id, class).join(".")
    info.parent = family-class
    info.parent-id = family-id
  } else {
    info.parent = info.class
    info.parent-id = info.id
  }

  let sequence = [].func()

  if type(display) != function { display = it => display }

  // a function that will resolve the information
  let resolve-info(prefix: prefix) = {
    let retrieved = ellipse.body

    if not is-element(prefix: prefix, retrieved) {
      retrieved = (original: retrieved)
    } else {
      retrieved = retrieved.value
    }

    return utils.merge-dicts(retrieved, merge: info)
  }

  // make `body` aware of its environment
  let body = context {
    let resolved-info = resolve-info()
    set ellipse(resolved-info.original)
    // protect the ellipse
    context display(resolved-info)
  }

  for name in (info.label, info.class, info.id, family-class, family-id,) {
    if name != none {
      name = prefix + "_" + name
      body = [#sequence((body, metadata(resolve-info)))#std.label(name)]
    }
  }
  // This context protects the body from sequence join.
  context body
}

#let select(identifier, prefix: none) = label(prefix + "_" + identifier)

#let set-element(prefix, identifier, ..fields) = doc => context {
  let original = ellipse.body
  let info = (
    kind: prefix + "_" + element-kind,
    fields: fields.named(),
    original: original,
  )

  show select(identifier, prefix: prefix): set ellipse(metadata(info))

  doc
}

#let show-element(identifier, prefix: none, ..funcs) = doc => context {
  let original = ellipse.body
  show select(identifier, prefix: prefix): it => {
    let (elem, info) = it.children
    let resolved-info = (info.value)()
    // provide the context for elem
    let body = {
      set ellipse(metadata(resolved-info))
      elem
    }
    set ellipse(original)
    // protect the ellipse
    context (utils.pipe(..funcs))([#body#metadata(resolved-info)])
  }

  doc
}

#let get-fields(elem) = {
  return elem.children.last().value.fields
}

#let setup(prefix) = (
  element: element.with(prefix: prefix),
  select: select.with(prefix: prefix),
  set-element: set-element.with(prefix),
  show-element: show-element.with(prefix: prefix),
)

// usage

// #let (element, select, set-element, show-element) = setup("mypackage:0.1.0")

// #show select("parent.child"): set text(fill: red)
// #show select("child"): strong
// #element(
//   class: "parent",
//   it => {
//     [
//       PARENT
//       - #element(
//           class: "child",
//           family: it,
//           [CHILD],
//         )
//     ]
//   },
// )
// #show select("#apple-box"): set text(fill: green)
// #show select("#apple-box.cherry"): set text(fill: blue)

// #element(
//   class: "container", 
//   id: "apple-box", 
//   self => {
//     [
//       HELLO 
//       - #element(
//         class: "cherry", 
//         family: self, 
//         [CHERRY]
//       )
//     ]
//   }
// )

// #element(class: "child", [ANOTHER CHILD])

// #show select("hello-text"): set text(fill: red)

// // #element([Hello], class: "hello-text")

// // #show select("hello-text"): set text(fill: green)

// // #element([Hello], class: "hello-text")

// // #show: set-element("hello-text", body: "New Body")

// #show: set-element("hello-text", body: "New Body")

// #show: show-element("hello-text", it => {
//   set text(fill: blue)
//   it
// })

// #element(
//   it => {
//     it.body
//   },
//   fields: (body: "Default"),
//   class: "hello-text",
// )
// Another body
