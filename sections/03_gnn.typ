#import "../helpers.typ": *
#import "../diagrams.typ": gnn-big-diagram, relu-star-diagram, reachability-example

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 2.1 — GNNs  [Tom]
// ══════════════════════════════════════════════════════════════════════════════

== Message Passing GNNs #h(0.5em) #tom

#align(center)[
  #gnn-big-diagram
]

Update: $x_v^t = "COM" (x_v^(t-1), "AGG"( \{\{ x_u^(t-1) | (v,u) in E \}\} ) )$.

- *AGG* — aggregiert Feature-Vektoren der Nachbarn.
- *COM* — kombiniert eigenen Feature-Vektor mit aggregiertem Ergebnis.

== Node Properties #tom

*Beispiel:* _Ist Symbol ☕ von Knoten $v$ aus erreichbar?_

#v(0.3em)
#align(center)[#reachability-example]


Wie lässt sich das mit einem GNN lösen?

#pagebreak()

Lösung:
- *Initial*: Jeder Knoten mit Label ☕ erhält Feature-Vektor 1, der Rest 0.

- *Update*: Setze auf 1, wenn Knoten selbst oder mind. ein Nachbar den Feature-Vektor 1 hat.

- *Akzeptieren:* Sobald Feature-Vektor der Node 1 ist.

== Constant oder Recurrent?

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 1.0em,
  block(stroke: 1pt + blue, fill: sky, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: blue)[Constant-Iteration GNN]\
    #v(0.3em)
    Läuft genau $N$ Runden.
    Nach $N$ Runden akzeptieren oder ablehnen.
  ],
  block(stroke: 1pt + sage, fill: mint, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: sage)[Rekurrentes GNN]\
    #v(0.3em)
    Läuft so lange, bis ein Knoten einen akzeptierenden Zustand erreicht.
  ],
)

#v(0.35em)
Beide können verwendet werden, um eine *Node Property* auszudrücken.

== R-simple GNNs #tom

$
  #let faded(x) = text(fill: gray, $#x$)
  faded(x_v^(t) &= "COM" (x_v^(t-1), "AGG"( \{\{ x_u^(t-1) | (v,u) in E \}\} ) )) \
  x_v^(t) &= "ReLU*" (x_v^(t-1) dot bold(C) + sum_((v,u) in E) x_u^(t-1) dot bold(A) + bold(b) )
$
$bold(A)$: Matrix, $bold(b)$: Bias-Vektor, $bold(C)$: Matrix, $"ReLU*"$: Truncated ReLU.

#align(center)[#relu-star-diagram]

☕-Reachability realisierbar als *R-simple GNN* (mit $bold(A)=1$, $bold(b)=0$, $bold(C)=1$):
$
  x_v^(t) = "ReLU*" (x_v^(t-1) + sum_((v,u) in E) x_u^(t-1) )
$

