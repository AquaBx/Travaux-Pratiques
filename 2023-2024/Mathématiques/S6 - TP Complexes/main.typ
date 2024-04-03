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
  title: [Compte-rendu TP Elements sur la variable complexe],
  authors: (
    ( name: [Tom Chauvel],
      affiliation: [],
      email: [] ),
    ),
  sectionnumbering: "1.1.a",
  toc: true,
  cols: 1,
  doc,
)



#pagebreak()


= Calcul d’intégrales le long d’un chemin

== Intégration d’une fonction

Dans ce premier exemple nous allons calculer l'intégrale suivante à la main, et nous allons vérifier avec python

$integral^pi_0(2+sin(t)) d t = [2t - cos(t)]^pi_0$
$= 2 pi - cos(pi) - (-cos(0))$
$= 2 pi + 2$


Vérifions avec python
#block[
```python
from sympy import *
```

]
#block[
```python
t = symbols('t',real=True)
f = lambda x : 2 + sin(x)

inte = integrate(f(t),(t,0,pi))


print(inte)
```

#block[
```
2 + 2*pi
```

]
]

On obtient le même résultat.

#pagebreak()

== Intégration le long d’un chemin

Maintenant nous allons intégrer le long d'un arc du cercle de rayon 1 et de centre 0 avec $f(z)=z^2$

Mathématiquement :

$f(z)=z^2$

$gamma(t)=z=e^(i t)$

$gamma(a)=e^(i a) = 1 => a = 0$

$gamma(b)=e^(i b) = 0.5 + i sqrt(3)/2 => b = pi/3$

$(d z)/(d t) = gamma'(t)=(e^(i t))'=i e^(i t) =>  gamma'(t) d t = d z$

$ integral_(gamma) f(z) d z = integral_a^b f( gamma(t) ) times gamma'(t) d t$ 

$= integral_a^b ( e^(i t) )^2 times i e^(i t) d t$ 

$= integral_a^b i e^(2 i t) times e^(i t) d t$ 

$= integral_a^b i e^(3 i t) d t$ 

$= [ e^(3 i t)/(3) ]^(pi/3)_0 $

$= e^(3 i times (pi/3) )/(3) - e^(3 i times 0 )/(3)$ 

$= (-1-1)/(3)$

$= (-2)/(3)$ 

Avec python:
#block[
```python
t = symbols('t',real=True)
z = symbols('z',complex=True)
f = z*z

gamma = exp(I*t)
gamma_p = diff(gamma,t)

f2 = f.replace(z,gamma) * gamma_p

a = 0
b = pi/3

inte = integrate(f2,(t,a,b))

print(inte)
```

#block[
```
-2/3
```

]
]

On obtient bien la même chose

#pagebreak()


== Création d’un script et applications

=== Le long d'un arc de cercle

Ici on fait la même chose, mais avec un cercle de rayon 2, $f(z)=z^2 + 3 z$, et des bornes d'intégrations différentes.

Mathématiquement:

$f(z)=z^2 + 3 z$

$gamma(t)=z=2 e^(i t)$

$gamma(a)=2 e^(i a) = 2 => a = 0$

$gamma(b)=2 e^(i b) = 2 i => b = pi/2$

$(d z)/(d t) = gamma'(t) = (2 e^(i t))'=2 i e^(i t) =>  gamma'(t) d t = d z$

$integral_(gamma) f(z) d z = integral_a^b f( gamma(t) ) times gamma'(t) d t$

$= integral_a^b (( 2 e^(i t) )^2 + 3 times 2 e^(i t) )times 2 i e^(i t) d t$

$= integral_a^b ( 4 e^(2 i t) + times 6 e^(i t) )times 2 i e^(i t) d t$

$= integral_a^b 8 i e^(3 i t) + times 12 i e^(2 i t) d t$

$= [ 8/3 e^(3 i t) + 12/2 e^(2 i t) ]^(pi/2)_0$

$= 8/3 e^(3 i times (pi/2) ) - 8/3 e^(3 i times 0 ) + 6 e^(2 i (pi/2)) - 6 e^(2 i 0)$

$= 8/3 times (-i) - 8/3 - 6 - 6 = -(8 i + 44)/3$
#pagebreak()
Sur Python:
#block[
```python
def integr(f,g,a,b):
  gp = diff(g,t)
  f = f.replace(z,g) * gp
  return simplify( integrate(f,(t,a,b)) )
```

]
#block[
```python
t = symbols('t',real=True)
z = symbols('z',complex=True)

f = z*z + 3*z

gamma = 2*exp(I*t)

a = 2
b = 2*I

b_inf = solve(gamma - a,t)
b_sup = solve(gamma - b,t)

print(integr(f,gamma,b_inf,b_sup))
```

#block[
```
-44/3 - 8*I/3
```

]
]

On trouve la même chose.

#pagebreak()

=== Le long d'un chemin

Ici, au lieu de faire avec un arc de cercle, on va calculer le long de deux segment.

Mathématiquement :

- Entre 2 et 2+2i

$f(z)=z^2 + 3 z$

$gamma(t)=z=i t$

$gamma(a)=i a = 2 => a = -2 i$

$gamma(b)=i b= 2+2 i => b = 2-2 i$

$(d z)/(d t) = gamma'(t) = (i t)'=i =>  gamma'(t) d t = d z$

$integral_(gamma) f(z) d z = integral_a^b f( gamma(t) ) times gamma'(t) d t$

$= integral_a^b (-i t^2- 3t) d t$

$= [ -(i t^3)/3 - (3 t^2)/2]^(2-2 i)_(-2 i)$

on simplifie $(2-2 i)^2=-8 i$

$= -8/3 (2-2 i) + 12 i -8/3-6 $

$= -14 +(16/3+36/3) i = -14 + 52/3 i$

- Entre 2+2i et 2i

$f(z)=z^2 + 3 z$

$gamma(t)=z=t$

$gamma(a)=a =2+2 i$

$gamma(b)=b=2$

$(d z)/(d t) = gamma'(t) = (i t)'=1 =>  gamma'(t) d t = d z$

$integral_(gamma) f(z) d z = integral_a^b f( gamma(t) ) times gamma'(t) d t$

$= integral_a^b (t^2 + 3t) d t$

$= [ (t^3)/3 + (3 t^2)/2]^(2 i)_(2+2 i)$

on simplifie $(2+2 i)^2=8 i$

$= -8/3 i - 6 - 8/3 i (2+2 i ) -12 i $

$= -8 i -12 i -6 +16/3 = -20 i - 2 / 3$

- somme des intégrales

$I_(t o t a l) = -20 i - 2 / 3 -14 + 52/3 i = -8/3 i - 44/3$

#pagebreak()

Avec python :
#block[
```python
t = symbols('t',complex=True)
z = symbols('z',complex=True)
f = z*z + 3*z

a = 2
b = 2+2*I
c = 2*I

gamma = -I*t
b_inf = solve(gamma-a,t)
b_sup = solve(gamma-b,t)

res1 = integr(f,gamma,b_inf,b_sup)

gamma = -t
b_inf = solve(gamma-b,t)
b_sup = solve(gamma-c,t)

res2 = integr(f,gamma,b_inf,b_sup)

print(res1+res2)
```

#block[
```
-44/3 - 8*I/3
```

]
]

On trouve bien la même chose avec Python.

On remarque aussi que le calcul entre deux segments et un arc de cercle donne le même résultat.

C'est normale car d'après le corrolaire du théorème de Cauchy, si une fonction est holomorphe alors l'intégrale du contour est égale du moment qu'on a le même point de départ et le même point d'arrivé ; le chemin importe peu.

#pagebreak()

=  Calcul d’intégrales le long d’un contour fermé

== Premières applications

Ici on doit calculer trois intégrales entre $0$ et $2 pi$

$gamma(t)=z=cos(t) + i sin(t) = e^(i t) $

$a = 0 $

$b = 2 pi $

$(d z)/(d t) = gamma'(t) = (e^(i t))'=i e^(i t) =>  gamma'(t) d t = d z $

#linebreak()
- Pour $f_1(z) = z^2$
#linebreak()

$integral_(gamma) f(z) d z = integral_0^(2 pi) f( gamma(t) ) times gamma'(t) d t$

$= integral_0^(2 pi) (e^(i t))^2 times i e^(i t) d t$

$= integral_0^(2 pi) i e^(3 i t) d t$

$= [e^(3 i t)/3]_0^(2 pi)$

$= e^(3 i times 2 pi)/3 - e^(3 i times 0)/3$

$= 1/3 - 1/3 = 0$

#linebreak()
- Pour $f_2(z) = 1/z$
#linebreak()

$integral_(gamma) f(z) d z = integral_0^(2 pi) f( gamma(t) ) times gamma'(t) d t$

$= integral_0^(2 pi) 1/(e^(i t)) times i e^(i t) d t$

$= integral_0^(2 pi) i d t$

$= [i t]_0^(2 pi)$

$= 2 i pi $

#pagebreak()
- Pour $f_3(z) = c o n j (z)$
#linebreak()

$integral_(gamma) f(z) d z = integral_0^(2 pi) f( gamma(t) ) times gamma'(t) d t$

$= integral_0^(2 pi) e^(-i t) times i e^(i t) d t$

$= integral_0^(2 pi) i d t$

$= [i t]_0^(2 pi)$

$= 2 i pi $

Vérifions nos calculs:
#block[
```python
z = symbols('z',complex=True)
t = symbols('t',complex=True)

f1 = z*z
f2 = 1 / z
f3 = conjugate( z )

g = cos(t) + I * sin(t) 

a = 0
b = 2*pi

print( "f1 : ",integr(f1,g,a,b) )
print( "f2 : ",integr(f2,g,a,b) )
print( "f3 : ",integr(f3,g,a,b) )
```

#block[
```
f1 :  0
f2 :  2*I*pi
f3 :  2*I*pi
```

]
]

On trouve les mêmes résultats avec Python et à la main.

Aussi calculer l'intégrale du conjugué ou celle de l'inverse pour un cercle de rayon 1 donne le même résultat.

#pagebreak()

== Application du théorème des résidus

Ici, on va chercher premièrement tous nos résidus. Ensuite on va intégrer pour plusieurs cercles, grâce au théorème des résidus.

Pour le premier cas, un cercle de rayon 1 et un cercle de rayon 2.

Pour le second cas, un cercle de rayon 1, un cercle de rayon 2 et un cercle de rayon 3.

Le dernier rayon est suffisant car il englobe tous nos résidus, ce qui est équivalent à aller jusqu'à l'infini.

=== $f_1(z)=1/(z(z-1))$

#linebreak()

Les poles sont 0 et 1

$R e s(f_1,0)=1/((1-1)!)[(z-0)^1 1/(z(z-1))]^(1-1)_(z=0)$
$=[z/(z(z-1))]_(z=0)$
$=1/(0-1)] = -1$

$R e s(f_1,1)=1/((1-1)!)[(z-1)^1 1/(z(z-1))]^(1-1)_(z=1)$
$=[(z-1)/(z(z-1))]_(z=1)$
$=1/1 = 1$

Donc pour $0<beta<1$ on prend juste le résidu en 0 :

$integral_(gamma) f(z) d z = 2 i pi times R e s (0) = 2 i pi times (-1) = -2 i pi$

Et pour $1<beta$ on prend le résidu en 1 et en 0 :

$integral_(gamma) f(z) d z = 2 i pi times (R e s (0) + R e s (1)) = 2 i pi times 0 = 0$
```powershell
//cercle rayon 1

Donner le numerateur: 1
Donner le denominateur: z*(z-1)
Donner le rayon du contour: 1
Résultat =  -2*I*pi

//cercle rayon 2

Donner le numerateur: 1
Donner le denominateur: z*(z-1)
Donner le rayon du contour: 2
Résultat =  0
```

D'après les résultats du programme on trouve : 

- $-2 i pi$ pour $0<beta<1$

- $0$ pour $1<beta$

Les résultats sont cohérants avec ceux calculés à la main.

=== $f_2(z)=1/(z(z-1)(z-2))$

#linebreak()

Les poles sont 0, 1 et 2

$R e s(f_2,0)=1/((1-1)!)[(z-0)^1 1/(z(z-1)(z-2))]^(1-1)_(z=0)$
$=[z/(z(z-1)(z-2))]_(z=0)$
$=1/((-1)(-2))] = 1/2$

$R e s(f_2,1)=1/((1-1)!)[(z-1)^1 1/(z(z-1)(z-2))]^(1-1)_(z=1)$
$=[(z-1)/(z(z-1)(z-2))]_(z=1)$
$=1/((1)(-1))] = -1$

$R e s(f_2,2)=1/((1-1)!)[(z-2)^1 1/(z(z-1)(z-2))]^(1-1)_(z=2)$
$=[(z-2)/(z(z-1)(z-2))]_(z=2)$
$=1/((2)(1))] = 1/2$

Donc pour $0<beta<1$ on prend juste le résidu en 0 :

$integral_(gamma) f(z) d z = 2 i pi times R e s (0) = 2 i pi times (1/2) = i pi$

Pour $1<beta<2$ on prend le résidu en 0 et en 1 :

$integral_(gamma) f(z) d z = 2 i pi times (R e s (0) + R e s (1)) = 2 i pi times (-1/2) = - i pi$

et pour $2<beta$ on prend tous les résidus :

$integral_(gamma) f(z) d z = 2 i pi times (R e s (0) + R e s (1) + R e s (2)) = 2 i pi times (0) = 0$

#pagebreak()
```powershell
//cercle rayon 1

Donner le numerateur: 1
Donner le denominateur: z*(z-1)*(z-2)
Donner le rayon du contour: 1
Résultat =  I*pi

//cercle rayon 2

Donner le numerateur: 1
Donner le denominateur: z*(z-1)*(z-2)
Donner le rayon du contour: 2
Résultat =  -I*pi

//cercle rayon 3

Donner le numerateur: 1
Donner le denominateur: z*(z-1)*(z-2)
Donner le rayon du contour: 3
Résultat =  0
```

D'après les résultats du programme on trouve : 

- $i pi$ pour $0<beta<1$

- $-i pi$ pour $1<beta<2$

- $0$  pour $2<beta$

Les résultats sont aussi cohérants avec ceux calculés à la main.

#pagebreak()

== Intégrales de Cauchy


En utilisant, le programme, on pourra calcul $integral_(gamma) f(z) d z$.

Il suffira juste de divisé par $2 i pi$ le résultat pour avoir le résultat des intégrals de Cauchy.

D'après $p(z) = e^z$, on sait que le rayon du cercle est 1.
```
Donner le numerateur: exp(z)
Donner le denominateur: z
Donner le rayon du contour: 1
Résultat =  2*I*pi
```

On trouve $I = (2 i pi) / (2 i pi) = 1$

Pour vérifier, il suffit de calculer la somme des résidus (car les $2 i pi$ se simplifie dans le calcul), ici seulement en $z=0$

$I = R e s(f,0)=(z times (e^z)/z)_(z=0) = e^0 = 1$

Du coup le résultat est cohérant.
```
Donner le numerateur: exp(z)
Donner le denominateur: z-1/2
Donner le rayon du contour: 1
Résultat =  3.29744254140026*I*pi
```

$I = (3.29744254140026 i pi) / (2 i pi) = 1.64872127$

Vérifions:

$I = Sigma  R e s = R e s (f,1/2) = e^(1/2) = sqrt(e) = 1.64872127$

Résultat cohérant
```
Donner le numerateur: exp(z)
Donner le denominateur: z-2
Donner le rayon du contour: 1
Résultat =  0
```

Ici $I = 0 / (2 i pi) = 0$

C'est normal car le résidu n'est pas dans le cercle de rayon 1, donc la somme est nulle.
#pagebreak()


= Intégrales sur R

Pour cette dernière partie, on va calculé deux intégrales à la main et vérifier ensuite avec python.

Pour I1

$integral_(-oo)^(+oo) 1/(x^2+1) d x = integral_(-oo)^(+oo) 1/((z+i)(z-i)) d x $

Les pôles sont i et -i
Je choisi le demi-cercle supérieur qui contient seulement i

$ R e s(f,i) = 1/(z+i)_(z=i) = 1/(2i)$

$I=2 i pi R e s(f,i) = pi$

Pour I2

$integral_(-oo)^(+oo) 1/(x^2+1)^3 d x = integral_(-oo)^(+oo) 1/((z+i)^3(z-i)^3) d x $

Les pôles sont i et -i de multiplicité 3
Je choisi le demi-cercle supérieur qui contient seulement i

$ R e s(f,i) = 1/2 [1/(z+i)^3]^(2)_(z=i)$

$ = 1/2 [-(3(z+i)^2)/(z+i)^6]^(1)_(z=i)$

$ = -3/2 [1/(z+i)^4]^(1)_(z=i)$

$ = -3/2 [(-4(z+i)^3)/(z+i)^8]^(0)_(z=i)$

$ = 12/2 [1/(z+i)^5]^(0)_(z=i)$

$ = 6 [1/(2i)^5] = 6/(32i) = 3/(16i)$


$I=2 i pi R e s(f,i) = 2 i pi times 3/(16i) = 3/8 pi$

Vérifions avec python :
#block[
```python
x = symbols('x',complex=False)

f1 = 1/(1+x*x)
f2 = 1/((1+x*x)**3)

print( "f1 : ",integrate(f1,(x,"-oo","+oo")) )
print( "f2 : ",integrate(f2,(x,"-oo","+oo")) )
```

#block[
```
f1 :  pi
f2 :  3*pi/8
```

]
]
On obtient les mêmes résultats.



