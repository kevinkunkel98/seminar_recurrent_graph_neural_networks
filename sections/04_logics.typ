#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 2.2 — Logiken  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
== Graded Modal Logic (GML)

#v(0.2em)
- GML ist Aussagenlogik, erweitert um *Zählmodalitäten*:
$
  phi ::= top | p | not phi | phi and phi | lozenge_(>= k) phi
$

- Zum Beispiel $lozenge_(>= k) phi$ bedeutet: *„mindestens $k$ ausgehende Nachbarn erfüllen $phi$"*

#v(0.3em)
#example[
  Auf *Graphen:*
  - $lozenge_(>= 1) p$ — „es gibt einen Nachbarn mit Label $p$"
  - $lozenge_(>= 3) (q and lozenge_(>= 2) r)$ — „mindestens 3 Nachbarn haben $q$ und jeder hat ≥2 Nachbarn mit $r$"
]

// ── SLIDE: GMSC ───────────────────────────────────────────────────────────────
== Graded Modal Substitution Calculus (GMSC)

- GMSC erweitert GML um *rekursive Regeln*
- ein Programm $Lambda$ besteht aus zwei Klauseltypen:

#v(0.2em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *Terminalklausel* `X(0) :− φ`\
    $phi ::= top | p | not phi | phi and phi | lozenge_(>= k) phi$\
    #text(size: 0.82em, style: "italic")[Reine GML-Formel — keine Schema-Variablen]
  ],
  block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *Iterationsklausel* `X :− ψ`\
    $psi ::= top | p | X | not psi | psi and psi | lozenge_(>= k) psi$\
    #text(size: 0.82em, style: "italic")[Darf Schema-Variable $X$ rekursiv enthalten]
  ],
)

#v(0.25em)
- Die $n$-te Entfaltung $X^n$: ersetze $X$ in $psi$ durch $X^(n-1)$, beginnend mit $X^0 = phi$.

- Ein Programm $Lambda$ hat eine Menge $cal(A)$ von *appointed* Variablen.
- $Lambda$ akzeptiert $(G, v)$, falls $G, v tack.r.double X^n$ für *ein* $n$ und *ein* $X in cal(A)$.


#v(0.3em)
#example[
  *Erreichbarkeit von $p$:* #h(1em) `X(0) :− p` #h(1.5em) `X :− ◇X` \
  $X^i = lozenge dots.c lozenge p$ (genau $i$ Rauten) = Erreichbarkeit in $i$ Schritten
]

// ── SLIDE: ω-GML and hierarchy ────────────────────────────────────────────────
== ω-GML und die Logikhierarchie

- ω-GML fügt *unendliche Disjunktionen* von GML-Formeln hinzu:
$
  phi ::= psi quad | quad limits(or.big)_(psi in Psi) psi
  quad (Psi "eine abzählbare Menge von GML-Formeln")
$


#v(0.3em)
- Da GNN[R] mit reellen Zahlen *beliebig viele* Werte unterscheiden kann, benötigt es diese unendliche Ausdrucksstärke.
- ω-GML kann *unentscheidbare* Grapheigenschaften definieren, daher ist GNN[$RR$] sehr mächtig.

#v(0.4em)
- *Ausdrucksstärke (semantische Inklusion, nicht syntaktisch):*
$
  "GML" quad subset.neq quad "GMSC" quad subset.neq quad omega"-GML"
$

== Vom Halteproblem zur unentscheidbaren Eigenschaft #h(0.5em) #kevin
#v(0.3em)

```python
def zaehle_bis_5(n):
    while n != 5:     # hält erst an, wenn n == 5
        n = n - 1     # zählt runter
    return "fertig!"
```

#v(0.3em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  block(fill: rgb("#e8f5e9"), inset: (x: 0.7em, y: 0.5em), radius: 3pt)[
    #text(fill: rgb("#2e7d32"))[*`zaehle_bis_5(8)`*] → 8,7,6,5 → *hält an*
  ],
  block(fill: rgb("#ffebee"), inset: (x: 0.7em, y: 0.5em), radius: 3pt)[
    #text(fill: rgb("#c62828"))[*`zaehle_bis_5(-1)`*] → −1,−2,… → *ewig*
  ],
)

#v(0.4em)
- *Halteproblem (Turing 1936):* kein Programm sagt für *jedes* andere vorher, ob es anhält
- Nummeriere alle Programme $P_1, P_2, P_3, dots$ und definiere die *Haltemenge*:
#v(0.2em)
#align(center)[
  #block(fill: sand, inset: (x: 1em, y: 0.55em), radius: 4pt, stroke: 0.5pt + navy)[
    $U = { n in NN mid(|) P_n "hält bei Eingabe " n "an" }$ #h(0.6em) #text(fill: rgb("#c62828"))[unentscheidbar]
  ]
]
