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

#show raw: it => {
  if it.block {
    block(fill: luma(230), width: 100%, inset: 8pt, radius: 2pt, it)
  } else {
    it
  }
}

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
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match != none {
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
  } else {
    it
  }
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
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
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
  cols: 1,
  doc,
)


\= Generate data

#block[
```python
import numpy as np
import matplotlib.pyplot as plt

# Number of data points
N = 100

X = np.random.uniform(low=0, high=100, size=N)

# Making y = 2x + 1 + some gaussian or normal noise (assumption of linear regression itself)
Y = 2 * X + 1 + np.random.normal(scale=10, size=N)

# Plotting the data to see if it looks linear
plt.scatter(X, Y, edgecolors='black', color="red")
plt.show()
```

#block[
#box(width: 347.25pt, image("main_files/figure-typst/cell-2-output-1.svg"))

]
]
les paramètres d’un modèle linéaire sont la pente \(w0) et l’ordonné à l’origine \(w1).

\= Loss function

#block[
```python
def SSR(w,x,y):
    N = len(y)
    s = 0

    lw = len(w)
    fw = lambda x : sum( w[i]*x**(lw-i-1) for i in range(lw) )

    for i in range(0,N):
        s += ( fw( x[i] ) - y[i] )**2
    return s

def MSE(w,x,y):
    N = len(y)
    return SSR(w,x,y)/N
```

]
#block[
```python
print(SSR([2,1],X,Y))
print(MSE([2,1],X,Y))
```

#block[
```
10611.321361525486
106.11321361525486
```

]
]
\= Gradient descent

#block[
```python
def gradient(w,x,y):
    lw = len(w)
    fw = lambda x : sum( w[i]*x**(lw-i-1) for i in range(lw) )

    l = ( fw(x) - y )

    grad_w = np.array([ sum(2 * x ** (lw-i-1) * l) for i in range(lw) ])

    return grad_w

gradient([2,1],X,Y)
```

#block[
```
array([1281.0548388 ,  227.52501592])
```

]
]
#block[
```python
def descenteGradient(w,x,y,µ,n):
    for _ in range(n):
        grad_w = gradient(w,x,y)
        w -= µ * grad_w
    return w

def descenteGradient2(w,x,y,µ,ϵ):
    normeE = np.inf
    while normeE > ϵ:
        grad_w = gradient(w,x,y)
        w -= µ * grad_w
        normeE = np.abs(np.max(grad_w))
    return w

print( descenteGradient([0,0],X,Y,10**(-6),100) )
print( descenteGradient2([0,0],X,Y,10**(-6),10**(-1)) )
```

#block[
```
[2.01287455 0.01512762]
[ 2.0544249 -2.728125 ]
```

]
]
\= Experiment

#block[
```python
X = np.random.uniform(low=0, high=100, size=N)
Y = 2 * X + 1 # + np.random.normal(scale=10, size=N)

print( descenteGradient([0,0],X,Y,10**(-3),100) )
print( descenteGradient2([0,0],X,Y,10**(-3),10**(-1)) )
```

#block[
```
[-3.13744424e+280 -4.74950810e+278]
[nan nan]
```

]
#block[
```
/tmp/ipykernel_738/3115440749.py:7: RuntimeWarning: overflow encountered in scalar add
  grad_w = np.array([ sum(2 * x ** (lw-i-1) * l) for i in range(lw) ])
/tmp/ipykernel_738/3171002804.py:11: RuntimeWarning: invalid value encountered in subtract
  w -= µ * grad_w
```

]
]



