#import "../helpers.typ": *
#import "../diagrams.typ": gnn-big-diagram, relu-star-diagram, reachability-example

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 2.1 — GNNs  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
== GNNs #h(0.5em) #tom

#v(0.2em)
Update von Feature-Vektoren:

$
  x_v^t = "COM" (x_v^(t-1), "AGG"( \{\{ x_u^(t-1) | (v,u) in E \}\} ) )
$

- *AGG* — aggregiert die Merkmalsvektoren der Nachbarn (z.B. Summe, Maximum)

- *COM* — kombiniert den eigenen Vektor mit dem aggregierten Ergebnis (z.B. MLP)

#v(0.5em)

#remark[
  Ungewöhnliche Konvention: Vektoren werden von *ausgehenden Nachbarn* gesammelt!
]

== GNN — Visualisierung der Nachrichtenweiterleitung #h(0.5em) #tom

#align(center + horizon)[
  #gnn-big-diagram
]

== R-simple GNNs

*R-simple GNNs:*

$
  #let faded(x) = text(fill: gray, $#x$)
  faded(x_v^(t) &= "COM" (x_v^(t-1), "AGG"( \{\{ x_u^(t-1) | (v,u) in E \}\} ) )) \
  x_v^(t) &= "ReLU*" (x_v^(t-1) dot bold(C) + sum_((v,u) in E) x_u^(t-1) dot bold(A) + bold(b) )
$
$bold(A)$: Matrix, $bold(b)$: Bias-Vektor, $bold(C)$: Matrix.

*ReLU\*:* truncated ReLU — beschränkt Output auf $[0, 1]$.

#v(0.3em)
#align(center)[#relu-star-diagram]

== Knoteneigenschaften #tom

*Beispieleigenschaft:* _Ist Symbol $p$ von Knoten $v$ aus erreichbar?_

#v(0.3em)
#align(center)[#reachability-example]


-> Wie lässt sich das über GNNs lösen?

#pagebreak()

Idee:
- Initial erhält jeder Knoten mit Label $p$ den Merkmalswert 1.

- Update: Falls ein Nachbar den Wert 1 hat, setze sich selbst auf 1.

- Akzeptierende Merkmalsvektoren $F = {1}$.


Realisierbar als *R-simple GNN*:
$
  x_v^(t) = "ReLU*" (x_v^(t-1) + sum_((v,u) in E) x_u^(t-1) )
$

(durch Setzen von $bold(A)=1$, $bold(b)=0$, $bold(C)=1$.)


== Konstantiterations- vs. Rekurrente GNNs #tom

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 1.0em,
  block(stroke: 1pt + blue, fill: sky, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: blue)[Konstantiterations-GNN]\
    #v(0.3em)
    - Läuft genau $N$ Runden ($N$ als Hyperparameter)
    - Nach $N$ Runden: Akzeptieren oder Ablehnen
    - $x_v^N in F$
    - *Problem:* $N$ muss vorab bekannt sein
  ],
  block(stroke: 1pt + sage, fill: mint, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: sage)[Rekurrentes GNN]\
    #v(0.3em)
    - Läuft bis ein Knoten einen *akzeptierenden* Zustand erreicht
    - $x_v^t in F$ für *ein* $t in NN$
    - Ein spezieller $bold("DONE")$-Vektor signalisiert das Ende
    - Das GNN entscheidet *selbst*, wann es fertig ist
  ],
)

#v(0.35em)
Beide können verwendet werden, um eine *Knoteneigenschaft* auszudrücken.

// ── Reachability als Trennbeispiel (neue Folie mit SVG) ───────────────────────
== Reachability als Trennbeispiel #h(0.5em) #tom

#v(0.2em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Reachability als Trennbeispiel:* Erreichbarkeit ist mit einem rekurrenten GNN ausdrückbar, aber mit *keinem* Konstantiterations-GNN — denn für jedes feste $N$ gibt es einen Graphen, in dem $p$ erst nach mehr als $N$ Schritten erreichbar ist. Das ist die zentrale Neuerung gegenüber Barceló et al. 2020 @barcelo2020logical.
]

#v(0.4em)
#align(center)[
  #image("../gnn_reachability.svg", width: 92%)
]

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
