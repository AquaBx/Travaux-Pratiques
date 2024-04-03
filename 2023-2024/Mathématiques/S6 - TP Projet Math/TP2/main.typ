// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = [
  #line(start: (25%,0%), end: (75%,0%))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): block.with(
    fill: luma(230), 
    width: 100%, 
    inset: 8pt, 
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.amount
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == "string" {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == "content" {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

#show figure: it => {
  if type(it.kind) != "string" {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    new_title_block +
    old_callout.body.children.at(1))
}

#show ref: it => locate(loc => {
  let target = query(it.target, loc).first()
  if it.at("supplement", default: none) == none {
    it
    return
  }

  let sup = it.supplement.text.matches(regex("^45127368-afa1-446a-820f-fc64c546b2c5%(.*)")).at(0, default: none)
  if sup != none {
    let parent_id = sup.captures.first()
    let parent_figure = query(label(parent_id), loc).first()
    let parent_location = parent_figure.location()

    let counters = numbering(
      parent_figure.at("numbering"), 
      ..parent_figure.at("counter").at(parent_location))
      
    let subcounter = numbering(
      target.at("numbering"),
      ..target.at("counter").at(target.location()))
    
    // NOTE there's a nonbreaking space in the block below
    link(target.location(), [#parent_figure.at("supplement") #counters#subcounter])
  } else {
    it
  }
})

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      block(
        inset: 1pt, 
        width: 100%, 
        block(fill: white, width: 100%, inset: 8pt, body)))
}



#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
#show: doc => article(
  title: [Compte-rendu TP sur l’intégration numérique],
  authors: (
    ( name: [Tom Chauvel],
      affiliation: [],
      email: [] ),
    ),
  sectionnumbering: "1.1 :",
  toc: true,
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)


#pagebreak()
= Exercice 1 : Résolution de systèmes d’équations linéaires
#block[
```python
import numpy as np
```

]
#block[
```python
A = np.matrix([
  [ 0, 2, 0, 1],
  [ 2, 2, 3, 2],
  [ 4,-3, 0, 1],
  [ 6, 1,-6,-5]
])

B = np.matrix([
  [ 0],
  [-2],
  [-7],
  [ 6],
])

print(np.linalg.inv(A).dot(B))
```

#block[
```
[[-0.5       ]
 [ 1.        ]
 [ 0.33333333]
 [-2.        ]]
```

]
]
= Exercice 2
<exercice-2>
#block[
```python
A = np.matrix([
  [ 5, 6 ],
  [ 6, 7 ],
  [ 1, 1 ]
])

B = np.matrix([
  [ 3],
  [ 1],
  [-5],
])

# print(np.linalg.inv(A).dot(B))
# il n'y a pas de solutions

def f(A,B,x,y):
  ax = np.matrix([[x],[y]])
  return np.linalg.norm( A.dot(ax) - B )

f(A,B,-28,24)
```

#block[
```
1.7320508075688772
```

]
]
== Moore-Penrose pseudo-inverse
<moore-penrose-pseudo-inverse>
#block[
```python
import time

def solveMoore(A,B):
  A_plus = np.linalg.inv(A.T.dot(A)).dot(A.T)
  return A_plus.dot(B)

t = time.time()

res = solveMoore(A,B)

print("temps" , time.time()-t)
print(res)
```

#block[
```
temps 0.0
[[-28.]
 [ 24.]]
```

]
]
== passage à l’échelle
<passage-à-léchelle>
#block[
```python
import numpy.random as rd

def surdeter(row,col):
  A = np.random.randint(1024, size=(row, col)) - 512 
  B = np.random.randint(1024, size=(row, 1)) - 512 
  return A,B

A,B = surdeter(3,2)

# res = solveMoore(A,B)

# print(A)
# print(B)
# print(res)
# print(f(A,B,res[0,0],res[1,0]))
```

]
== Regression polynomiale
<regression-polynomiale>
#block[
```python
import matplotlib.pyplot as plt

pts = [(-1,1),(3,0),(0,1),(-2,-2),(2,3)]

for x,y in pts:
  plt.scatter(x, y)


# def Lagrange(pts):
#   x = np.poly1d([1,0])
#   P=0

#   for i in range(len(pts)):
#     Li = 1
#     xi = pts[i][0]
#     for j in range(len(pts)):
#       if i!=j:
#         xj = pts[j][0]
#         Li *= (x-xj)/(xi-xj)
#     P += Li * pts[i][1]

#   return P

xs = np.linspace(-2,3,100)

A = np.matrix([[pt[0]**i for i in range(3)] for pt in pts])
B = np.matrix([[pt[1]] for pt in pts])

res = solveMoore(A,B)

res = [r[0,0] for r in res]
res.reverse()


plt.plot( xs,np.polyval(np.poly1d(res),xs) )

plt.show()
```

#block[
#box(width: 342.75pt, image("main_files/figure-typst/cell-7-output-1.svg"))

]
]



