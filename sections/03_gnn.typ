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

// ── GNN[F] vs. GNN[R] ─────────────────────────────────────────────────────────
== GNN[F] vs. GNN[R] — Warum das wichtig ist

#v(0.2em)
In der Praxis verwenden GNNs *Gleitkommazahlen* ($FF$). Die Theorie nimmt meist *reelle Zahlen* ($RR$) an.

#v(0.3em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Das Gleitkommazahlenproblem:* Gleitkommazahlenaddition ist *nicht assoziativ*:
  $(a + b) + c eq.not a + (b + c)$

  In einem 2-Dezimalsystem: $1 + (-1) + 0.01 = 0.01$, aber $(1 + 0.01) + (-1) = 1.0 + (-1) = 0$\
  da $1.01$ nicht darstellbar ist und gerundet wird.
]

#v(0.3em)
*Folgerung* (Proposition 2.3): Für jedes Gleitkommazahlensystem $FF$ gibt es ein $k in NN$, sodass für alle Multimengen $M$ von Gleitkommazahlen gilt:
$
  "SUM"_FF (M) = "SUM"_FF (M|_k)
$
Nach $k$ Kopien eines Wertes machen weitere Kopien *keinen Unterschied* — Gleitkommazahlen können nicht über eine feste Grenze hinaus zählen.

#v(0.3em)
#block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.9em, y: 0.6em), radius: 3pt)[
  *Konvention:* Im Folgenden nehmen wir GNN[$FF$] stets als *bounded* im Sinne von Prop. 2.3 an. Genau diese Beschränkung macht GNN[$FF$] strikt schwächer als GNN[$RR$].
]
