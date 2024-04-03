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
  title: [Compte-rendu TP Projets Maths],
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

= Partie 1 : Décourverte Python

== Exercice 1 : Découverte Python
Dans cette partie, on va se familiariser avec numpy et python.

#block[
```python
import numpy as np
```

]
#block[
```python
print( 2+3 )
```

#block[
```
5
```

]
]
#block[
```python
print( 2**10 )
```

#block[
```
1024
```

]
]
#block[
```python
print( np.sin(2 * np.pi) )
```

#block[
```
-2.4492935982947064e-16
```

]
]
environ 0, python approxime très mal les nombres flottants

#block[
```python
print( np.exp(1j * np.pi) + 1 )
```

#block[
```
1.2246467991473532e-16j
```

]
]
$= cos( pi ) - 1 + i times sin( pi ) = 0$
, même problème
#block[
```python
A = np.matrix([[1,2],[3,4]])
B = np.matrix([[2,3],[4,5]])

print( A*B )
```

#block[
```
[[10 13]
 [22 29]]
```

]
]
#block[
```python
A = np.matrix([[1,7],[4,2]])

print( np.linalg.det(A) )
```

#block[
```
-25.99999999999999
```

]
]
#pagebreak()
== Exercice 2 : Eigenvalues, eigenvectors
Ici on va chercher les valeurs et vecteurs propres de la matrice A.

#block[
```python
A =1/2*np.matrix([
  [np.sqrt(3)+1,-2],
  [1,np.sqrt(3)-1]
])

res = np.linalg.eig(A)

for i in range(len(res.eigenvalues)):
  print(f'Valeur  Propre {i} : {res.eigenvalues[i]}')
  print(f'Vecteur Propre {i} : {res.eigenvectors[i]}')
```

#block[
```
Valeur  Propre 0 : (0.8660254037844384+0.49999999999999994j)
Vecteur Propre 0 : [[0.81649658+0.j 0.81649658-0.j]]
Valeur  Propre 1 : (0.8660254037844384-0.49999999999999994j)
Vecteur Propre 1 : [[0.40824829-0.40824829j 0.40824829+0.40824829j]]
```

]
]
Maintenant calculons le produit $A^x times v$

#block[
```python
A =1/2* np.matrix([[np.sqrt(3)+1,-2],[1,np.sqrt(3)-1]])

v = np.matrix([[1],[2]])

for i in range(1,14):
  print(f'A**{i}*V : {np.dot(A**i,v)}')
```

#block[
```
A**1*V : [[-0.6339746 ]
 [ 1.23205081]]
A**2*V : [[-2.09807621]
 [ 0.1339746 ]]
A**3*V : [[-3.]
 [-1.]]
A**4*V : [[-3.09807621]
 [-1.8660254 ]]
A**5*V : [[-2.3660254 ]
 [-2.23205081]]
A**6*V : [[-1.]
 [-2.]]
A**7*V : [[ 0.6339746 ]
 [-1.23205081]]
A**8*V : [[ 2.09807621]
 [-0.1339746 ]]
A**9*V : [[3.]
 [1.]]
A**10*V : [[3.09807621]
 [1.8660254 ]]
A**11*V : [[2.3660254 ]
 [2.23205081]]
A**12*V : [[1.]
 [2.]]
A**13*V : [[-0.6339746 ]
 [ 1.23205081]]
```

]
]
On remarque que $A^13 times v = A times v$, donc que l’on obtient un cycle qui se répète toutes les 13 fois. Mais il y a aussi une étape intermédiaire au milieu ou le résulat est l’opposé de celui de départ : $A^7 times v = - A times v$

Faisons la même chose pour B et C.
#block[
```python
B =1/np.sqrt(2)* np.matrix([[np.sqrt(3)+1,-2],[1,np.sqrt(3)-1]])

v = np.matrix([[1],[2]])

for i in range(1,13):
  print(f'B**{i}*V : {np.dot(B**i,v)}')
```

#block[
```
B**1*V : [[-0.89657547]
 [ 1.74238296]]
B**2*V : [[-4.19615242]
 [ 0.26794919]]
B**3*V : [[-8.48528137]
 [-2.82842712]]
B**4*V : [[-12.39230485]
 [ -7.46410162]]
B**5*V : [[-13.38426086]
 [-12.6263861 ]]
B**6*V : [[ -8.]
 [-16.]]
B**7*V : [[  7.17260378]
 [-13.93906369]]
B**8*V : [[33.56921938]
 [-2.14359354]]
B**9*V : [[67.88225099]
 [22.627417  ]]
B**10*V : [[99.13843876]
 [59.71281292]]
B**11*V : [[107.07408688]
 [101.01108877]]
B**12*V : [[ 64.]
 [128.]]
```

]
]
On remarque aussi le cycle, sauf qu’ici les nombres sont multipliés par -8 toutes les 6 fois, \(on le remarque pour n\=6 et n\=12).

#block[
```python
C =1/2/np.sqrt(2)* np.matrix([[np.sqrt(3)+1,-2],[1,np.sqrt(3)-1]])

v = np.matrix([[1],[2]])

for i in range(1,13):
  print(f'C**{i}*V : {np.dot(C**i,v)}')
```

#block[
```
C**1*V : [[-0.44828774]
 [ 0.87119148]]
C**2*V : [[-1.04903811]
 [ 0.0669873 ]]
C**3*V : [[-1.06066017]
 [-0.35355339]]
C**4*V : [[-0.77451905]
 [-0.46650635]]
C**5*V : [[-0.41825815]
 [-0.39457457]]
C**6*V : [[-0.125]
 [-0.25 ]]
C**7*V : [[ 0.05603597]
 [-0.10889894]]
C**8*V : [[ 0.13112976]
 [-0.00837341]]
C**9*V : [[0.13258252]
 [0.04419417]]
C**10*V : [[0.09681488]
 [0.05831329]]
C**11*V : [[0.05228227]
 [0.04932182]]
C**12*V : [[0.015625]
 [0.03125 ]]
```

]
]
De même, On remarque le cycle, sauf qu’ici les nombres sont divisés par -8 toutes les 6 fois, \(on le remarque pour n\=6 et n\=12).

#pagebreak()
== Exercice 3 : Visualiser des functions
Dans cette partie on va visualiser des fonctions. Puis les analyser.

#block[
```python
import matplotlib.pyplot as plt

def plotfunc(f):
  x = np.arange(-2,2,0.001)
  y = f(x)
  plt.plot(x,y)
  plt.show()
```

]
#block[
```python
plotfunc(lambda x : x**3)
```

#block[
#figure([
#box(width: 342.75pt, image("main_files/figure-typst/cell-14-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
Une fonction cubique, rien de plus banal
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
#block[
```python
plotfunc(lambda x : x**2*np.sin(1/x))
```

#block[
#figure([
#box(width: 352.5pt, image("main_files/figure-typst/cell-15-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
x\*\*2\*np.sin\(1/x)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
au voisinage de zéro, la fonction à des petites variations qui sont dû au sinus. La fonction semble être impaire.

#block[
```python
plotfunc(lambda x : x**2*np.sin(1/(x**2)))
```

#block[
#figure([
#box(width: 352.5pt, image("main_files/figure-typst/cell-16-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
x\*\*2\*np.sin\(1/\(x\*\*2))
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
de même; au voisinnage de zéro, le sinus fait quelque chose de spécial. On dirait qu’elle fait l’inverse d’un sinus cardinal. Sinon la fonction à l’air d’être borné entre -1/3 et 1 et elle semble être paire.

#block[
```python
plotfunc(lambda x : 1/(1+np.exp(-x)))
```

#block[
#figure([
#box(width: 343.5pt, image("main_files/figure-typst/cell-17-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
1/\(1+np.exp\(-x))
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
La fameuse fonction sigmoïde. Elle est beaucoup utilisé en IA car elle est bornée entre 0 et 1 et elle est super simple à dérivé, ce qui est génial pour recalculer les poids des neuronnes.

#block[
```python
plotfunc(lambda x : 1/(1+np.exp(-10*x)))
```

#block[
#figure([
#box(width: 343.5pt, image("main_files/figure-typst/cell-18-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
1/\(1+np.exp\(-10x))
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
Ici on a toujours une fonction sigmoïde, mais avec un coefficient plus grand, ce qui modifie ça forme et la valeur de sa pente.

#block[
```python
plotfunc(lambda x : 1/(1+np.exp(-100*x)))
```

#block[
#figure([
#box(width: 343.5pt, image("main_files/figure-typst/cell-19-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
1/\(1+np.exp\(-100x))
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
Pareil, mais avec une pente encore plus verticale.

#block[
```python
plotfunc(lambda x : (np.exp(x)-np.exp(-x))/(np.exp(x)+np.exp(-x)))
```

#block[
#figure([
#box(width: 358.5pt, image("main_files/figure-typst/cell-20-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
\(np.exp\(x)-np.exp\(-x))/\(np.exp\(x)+np.exp\(-x))
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
De premier abord, on dirait une fonction sigmoïde, sauf que celle-ci est compris entre -1 et 1, ce qui rends cette fonction impaire. Elle est aussi un peu plus courbée que la sigmoïde à coefficient à 1.

#block[
```python
plotfunc(lambda x : (np.exp(100*x)-np.exp(-100*x))/(np.exp(100*x)+np.exp(-100*x)))
```

#block[
#figure([
#box(width: 358.5pt, image("main_files/figure-typst/cell-21-output-1.svg"))
], caption: figure.caption(
position: bottom, 
[
\(np.exp\(100#emph[x)-np.exp\(-100];x))/\(np.exp\(100#emph[x)+np.exp\(-100];x)))
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]
On prend $1/(1 + e^(-100 x))$, on l'allonge un peu pour qu'elle soit bornée entre -1 et 1, et on a la même courbe.
#pagebreak()

== Exercice 4 : Algèbre et géometrie

=== Points Alignés

comment déterminé si trois points sont alignés ? C'est très simple, on calcule l'équation de droite défini par deux points et on regarde si le troisième points suit l'équation.
#block[
```python
def areAligned(v1,v2,v3):
  sub = v1-v2
  a = sub[1]/sub[0]
  b = v1[1] - a * v1[0]

  return a*v3[0] + b == v3[1]

v1 = np.array([1,2])
v2 = np.array([2,3])
v3 = np.array([3,4])

print( areAligned(v1,v2,v3) )
```

#block[
```
True
```

]
]
#pagebreak()

=== Point dans un triangle
Comment définir si un point est un triangle ? Une méthode qui existe est de calculé la somme des angles entre le point d ( qui ne définit pas le triangle ) et les sommets du triangle. Si cette somme est égale à 2pi oui 360°, c'est ok. 

C'est ce que j'ai fait dans la méthode ci-dessous, sauf que j'ai dû arrondir le résultat car les nombres flottants en informatique, c'est pas précis.
#block[
```python
def isInTriangle(p1,p2,p3,p4):
  # soustraction des points pour avoir les vecteurs, puis on calcule la norme du vecteur
  a1 = p1-p4
  n1 = np.linalg.norm(a1)
  a2 = p2-p4
  n2 = np.linalg.norm(a2)
  a3 = p3-p4
  n3 = np.linalg.norm(a3)

  # on calcule les cos avec le produit scalaire
  cos1 = np.dot(a1,a2)/n1/n2
  cos2 = np.dot(a2,a3)/n2/n3
  cos3 = np.dot(a3,a1)/n3/n1

  # on somme les angles et on les arrondis
  return np.round( np.arccos(cos1) + np.arccos(cos2) + np.arccos(cos3), 3 ) == np.round(2*np.pi,3)


p1 = np.array([0,2])
p2 = np.array([2,0])
p3 = np.array([0,0])
p4 = np.array([0.5,0.5])

print( isInTriangle(p1,p2,p3,p4) )
```

#block[
```
True
```

]
]
#pagebreak()

=== Point dans un triangle rotaté

C'est la même chose, sauf qu'ici on a va rotater le triangle d'un angle pi/2 sur son barycentre.

Mise à part la rotation avec la matrice, rien de bien méchant.
#block[
```python
def centreMasse(p1,p2,p3):
  # calcul du barycentre
  return (p1+p2+p3)/3

def rotate(p1,angle,c):
  # on déplace le point pour que le barycentre soit à l'origine
  p1p = p1 - c

  # matrice de rotation
  matrixrot = np.array([[np.cos(angle),np.sin(angle)],[-np.sin(angle),np.cos(angle)]])

  # on rotate et on réajoute le barycentre
  return matrixrot.dot(p1p) + c

def isInTriangleRotate(p1,p2,p3,p4,angle):
  c = centreMasse(p1,p2,p3)

  p1r = rotate(p1,angle,c)
  p2r = rotate(p2,angle,c)
  p3r = rotate(p3,angle,c)

  return isInTriangle(p1r,p2r,p3r,p4)

p1 = np.array([0,2])
p2 = np.array([2,0])
p3 = np.array([0,0])
p4 = np.array([0.5,0.5])

print( isInTriangleRotate(p1,p2,p3,p4,-np.pi/2) )
```

#block[
```
True
```

]
]
#pagebreak()

=== Point incident

Plus compliqué à comprendre. On a un point, on veut savoir si ce point projeté sur un plan, appartient au triangle qui défini le plan 🤯.

Le plus dur, c'est le projeté orthogonal, sinon c'est la même méthode.

L'avantage, une formule existe :

Soit C un point du triangle, $accent(n, arrow)=vec(a,b,c)$ le vecteur normal du plan, et A le point à projeter.

$
p(x) = a times x + b times y + c times z + d = 0
$

pour trouver d on prend un point du plan.

$
d = -( accent(n, arrow) dot C)
$

Pour le projeté :

$
lambda = (a times X_A + b times Y_A + c times Z_A + d) / (a^2+b^2+c^2)
= ( accent(n, arrow) dot A) / (accent(n, arrow) dot accent(n, arrow))
$

$

A_p = vec(X_A - a times lambda,Y_A - b times lambda,Z_A - c times lambda)

$

Implémentons cela :
#block[
```python
def isIncident(p1,p2,p3,p4,vn):
  d = - np.dot(vn,p1)
  lamb =  (np.dot(vn,p4)+d)/np.dot(vn,vn)
  ph = p4 - vn*lamb
  return isInTriangle(p1,p2,p3,ph)

p1 = np.array([4,2,-1])
p2 = np.array([1,3,1])
p3 = np.array([-3,0,3])
p4 = np.array([0,1.5,0])
vn = np.array([8,-2,13])

print( isIncident(p1,p2,p3,p4,vn) )
```

#block[
```
True
```

]
]
#pagebreak()

=== Calcul de l'aire d'un triangle

D'un point de vue extérieur c'est simple à faire. Sauf que c'est long de calculer une hauteur sur des triangles qui ne sont pas toujours de la même forme. Donc j'ai chercher un autre méthode, la formule d'Héron.

Soit p le demi-périmètre, a b et c les côtés du triangle

$
p = (a+b+c)/2
$$
S = sqrt( p(p-a)(p-b)(p-c) )
$
#block[
```python
def aireTriangle(p1,p2,p3):
  a = np.linalg.norm(p1-p2)
  b = np.linalg.norm(p1-p3)
  c = np.linalg.norm(p2-p3)

  p = (a+b+c)/2

  return (p*(p-a)*(p-b)*(p-c))**(1/2)

p1 = np.array([0,2])
p2 = np.array([2,0])
p3 = np.array([0,0])

print( aireTriangle(p1,p2,p3) )
```

#block[
```
1.9999999999999993
```

]
]
#pagebreak()

=== Polygône convexe

Dernier algorithme, déterminer si un quadrilatère est convexe. Pour ce faire, on doit vérifier si tous les angles intérieurs sont inférieurs à 180°. L'équivalent, c'est de faire à chaque sommet, le produit vectorielle des arrêtes adjacentes à ce sommet, et vérifié que tous les produits vectorielle sont dans le même sens, le produit vectorielle prend l'angle minimal entre les deux arrêtes et l'oriente en fonction.
#block[
```python
def est_convexe(p1,p2,p3,p4):
  v1 = p2-p1
  v2 = p3-p2
  v3 = p4-p3
  v4 = p1-p4

  a = np.cross(v1,v2)
  b = np.cross(v2,v3)
  c = np.cross(v3,v4)
  d = np.cross(v4,v1)

  cas1 = a <= 0 and b <= 0 and c <= 0 and d <= 0 
  cas2 = a >= 0 and b >= 0 and c >= 0 and d >= 0 

  return cas1 or cas2

est_convexe( np.array([0, 0]), np.array([1, 1]), np.array([2, 0]), np.array([1, -1]) )
```

#block[
```
True
```

]
]
#pagebreak()
= Partie 2 : Algèbre linéaire et apprentissage par la machine
== Exercice 1 : Résolution de systèmes d’équations linéaires
On doit résoudre $A x = b$

Ce qui revient à faire $x = A^(-1) b$
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
#pagebreak()
== Exercice 2
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


def f(A,B,x,y):
  ax = np.matrix([[x],[y]])
  return np.linalg.norm( A.dot(ax) - B )
```

]

Ce système ne possède pas de solution car il est surdeterminé ( et il n'y pas de lignes similaires ).

$
mat(
  5,6;
  6,7;
  1,1;  
)
times 
mat(
  x;
  y; 
)
-
mat(
  3;
  1;
  5;  
)
$

on a donc

$
cases(
5 x + 6 y - 3 = 0,
6 x + 7 y - 1 = 0,
1 x + 1 y - 5 = 0,
)
$

pour calculer l'erreur, on doit calculer :

$ e = sqrt( (5 x + 6 y - 3)^2 + (6 x + 7 y - 1)^2 + (1 x + 1 y - 5)^2 ) $

après avoir développé tous les termes on trouve

$ e = sqrt( 62 x^2 + 146 x y - 32 x - 40 y + 86 y^2 + 44 ) $

et on fait quoi après ? Et bien, on cherche à minimiser cette erreur, ce qui revient à déterminer quand est-ce que la fonction ci-dessus a ses dérivés qui s'annulent

$ cases(
(diff e)/(diff x) = 124 x + 146 y - 32,
(diff e)/(diff y) = 146 x + 172 y - 40,
) $

On doit trouver ces deux différentielles égale à 0

$ cases(
0 = 124 x + 146 y - 32,
0 = 146 x + 172 y - 40,
) $

$ cases(
146 y = 32 - 124 x,
172 y = 40 - 146 x,
) $

$ cases(
y = (32 - 124 x) / 146,
y = (40 - 146 x) / 172,
) $

$ (32 - 124 x) / 146 = (40 - 146 x) / 172 $
$ (32 - 124 x) times 172 = (40 - 146 x) times 146 $
$ 5504 - 21328 x = 5840 - 21316 x $
$ 336 = - 12 x $
$ x = - 28 $

$ y = (40 - 146 times (-28)) / 172 = (40 + 4088) / 172 = (4128) / 172 = 24 $

donc la solution qui minimise l'erreur est $x=vec(-28,24)$
#block[
```python
f(A,B,-28,24)
```

#block[
```
1.7320508075688772
```

]
]
#pagebreak()

=== Moore-Penrose pseudo-inverse
Maintenant on va vérifier si le résultat précédent est bon avec la Moore-Penrose pseudo-inverse.
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
On trouve la même chose, mais le calcul est tellement simple qu’il est instantané.

=== passage à l'échelle

Maintenant on va pousser les limites de cette méthode
#block[
```python
import numpy.random as rd

def surdeter(row,col):
  A = np.random.randint(1024, size=(row, col)) - 512 
  B = np.random.randint(1024, size=(row, 1)) - 512 
  return A,B

A,B = surdeter(40000,200)

t = time.time()

res = solveMoore(A,B)

print("temps" , time.time()-t)
```

#block[
```
temps 3.055260181427002
```

]
]
Même si mon ordinateur est puissant, je ne vais pas allez plus loin que 40000 lignes et 200 colonnes. 3 secondes pour une matrice de cette taille c'est plûtot rapide.

#pagebreak()

=== Regression polynomiale

Dans cette nouvelle partie, on veut approximer un nuage de points par un polynome du second degré.
#block[
```python
import matplotlib.pyplot as plt

pts = [(-1,1),(3,0),(0,1),(-2,-2),(2,3)]

for x,y in pts:
  plt.scatter(x, y)

xs = np.linspace(-2,3,100)

A = np.matrix([[pt[0]**i for i in range(3)] for pt in pts])
B = np.matrix([[pt[1]] for pt in pts])

res = solveMoore(A,B)

res2 = [r[0,0] for r in res]
res2.reverse()

plt.plot( xs,np.polyval(np.poly1d(res2),xs) )

plt.show()


RSS = 0
for pt in pts:
  RSS += ( pt[1] - np.poly1d(pt[0]) ) ** 2

print( np.sqrt( RSS / 6 )[0] )
print( np.linalg.norm(A.dot(res)-B) )
```

#block[
#box(width: 342.75pt, image("main_files/figure-typst/cell-34-output-1.svg"))

]
#block[
```
1.5811388300841898
1.5811388300841898
```

]
]

D'après ce que j'en déduis :

erreur $= sqrt((R S S)/(N+1))$

#pagebreak()

= Partie 3 :  Regession lineaire, descente de gradient

== Generate data
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
#box(width: 347.25pt, image("main_files/figure-typst/cell-35-output-1.svg"))

]
]
les paramètres d'un modèle linéaire sont la pente (w0) et l'ordonné à l'origine (w1).

#pagebreak()
== Loss function
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
10555.887405720425
105.55887405720425
```

]
]
#pagebreak()
== Gradient descent
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
array([13580.33664556,   248.47071687])
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
[1.99358798 0.02986075]
[1.99359696 0.02924155]
```

]
]
#pagebreak()
== Experiment
#block[
```python
def descenteGradient3(w,x,y,µ,n):
    l = []
    for _ in range(n):
        grad_w = gradient(w,x,y)
        l.append(grad_w)
        w -= µ * grad_w
    l.append(w)
    return l

n=100
plt.plot(np.arange(0,n+1,1),[MSE( w, X, Y ) for w in descenteGradient3([0,0],X,Y,10**(-6),n)])

plt.show()
```

#block[
#box(width: 334.5pt, image("main_files/figure-typst/cell-40-output-1.svg"))

]
]
ça converge vite.

Maintenant modifions un peu les paramètres.
Enlevons l'aléatoire, diminuons la tolérance de l'epsilon et augmentons le pas (µ).
#block[
```python
X = np.random.uniform(low=0, high=100, size=N)
Y = 2 * X + 1 # + np.random.normal(scale=10, size=N)

print( descenteGradient([0,0],X,Y,10**(-3),100) )
print( descenteGradient2([0,0],X,Y,10**(-3),10**(-1)) )
```

#block[
```
[-2.88604565e+283 -4.25621633e+281]
[nan nan]
```

]
#block[
```
C:\Users\tomch\AppData\Local\Temp\ipykernel_9524\3115440749.py:7: RuntimeWarning: overflow encountered in scalar add
  grad_w = np.array([ sum(2 * x ** (lw-i-1) * l) for i in range(lw) ])
C:\Users\tomch\AppData\Local\Temp\ipykernel_9524\3171002804.py:11: RuntimeWarning: invalid value encountered in subtract
  w -= µ * grad_w
```

]
]
Bizarre, on ne converge pas. C'est totalement normal, car comme on a augmenté µ, dès que l'on va vouloir récalculé le gradient, celui-ci n'aura pas un coefficient trop grand pour descendre et va à chaque itération remonter.
#block[
```python
N = 100000


X = np.random.uniform(low=0, high=100, size=N)
Y = 2 * X + 1 + np.random.normal(scale=10, size=N)

plt.scatter(X, Y, edgecolors='black', color="red")
plt.show()

print( descenteGradient([0,0],X,Y,10**(-10),100) )
```

#block[
#box(width: 347.25pt, image("main_files/figure-typst/cell-42-output-1.svg"))

]
#block[
```
[2.01239356 0.03069089]
```

]
]
Avec un ensemble de 10000 élements, j'ai du diminué µ à $10^(-10)$ pour converger.



