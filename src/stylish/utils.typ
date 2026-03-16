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

#let pipe(..funcs) = {
  funcs = funcs.pos() 
  let init = funcs.remove(0)
  funcs.fold(init, (acc, f) => (..args) => f(acc(..args)) )
}