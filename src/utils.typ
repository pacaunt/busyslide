#let compile(data, scope: (:)) = {
  let eval = eval.with(scope: scope)
  let compile = compile.with(scope: scope)

  if type(data) == dictionary {
    data = data.pairs().map(((k, v)) => (k, compile(v))).to-dict()
  } else if type(data) == array {
    data = data.map(compile)
  } else {
    data = eval(data)
  }
  return data
}

#let merge-dicts(dict, merge: (:)) = {
  for (k, v) in dict.pairs() {
    if k not in merge { merge.insert(k, v) } else {
      if type(v) == dictionary {
        v = merge-dicts(v, merge: merge.at(k))
      } 
      merge.insert(k, v)
    }
  }
  return merge
}
