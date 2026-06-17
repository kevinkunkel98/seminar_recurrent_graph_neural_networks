#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 2.2 — Logiken  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
== Graded Modal Logic (GML)

#v(0.2em)
- GML ist Aussagenlogik, erweitert um *Zählmodalitäten*:
$
  phi ::= top mid p mid not phi mid phi and phi mid lozenge_(>= k) phi
$

- Die Schlüsselformel $lozenge_(>= k) phi$ bedeutet: *„mindestens $k$ ausgehende Nachbarn erfüllen $phi$"*

#v(0.3em)
#example[
  Auf *Graphen:*
  - $lozenge_(>= 1) p$ — „es gibt einen Nachbarn mit Label $p$"
  - $lozenge_(>= 3) (q and lozenge_(>= 2) r)$ — „mindestens 3 Nachbarn haben $q$ und jeder hat ≥2 Nachbarn mit $r$"
]

#v(0.3em)
- *Klassisches Ergebnis* @barcelo2020logical: Konstantiterations-GNNs $equiv$ GML (relativ zu FO-definierbaren Eigenschaften)

// ── SLIDE: GMSC ───────────────────────────────────────────────────────────────
== Graded Modal Substitution Calculus (GMSC)

- GMSC erweitert GML um *rekursive Regeln* — ein Programm $Lambda$ besteht aus zwei Klauseltypen:

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

// ── SLIDE: Main Theorems ──────────────────────────────────────────────────────
== Hauptsätze

#v(0.4em)
#theorem([1])[
  Das Folgende hat die *gleiche Ausdrucksstärke*:
  $
    "GNN[F]" quad equiv quad "R-simple GNN[F]" quad equiv quad "GMSC"
  $
]

#v(0.2em)
#theorem([2])[
  Das Folgende hat die *gleiche Ausdrucksstärke*:
  $
    "GNN"[RR] quad equiv quad omega"-GML"
  $
]

#v(0.2em)
#block(
  stroke: (paint: luma(160), dash: "dashed"),
  fill: luma(248),
  inset: (x: 0.9em, y: 0.7em),
  radius: 4pt,
  width: 100%,
)[
  #text(fill: luma(130), weight: "bold")[Satz 3] #h(0.5em)
  #text(fill: luma(130))[Kommt in Abschnitt 4 …]
  #h(1fr)
  #highlight(fill: luma(50))[#text(fill: luma(50))[GNN$[RR]$ $equiv$ GNN$[FF]$ über MSO-Eigenschaften]]
]

// ── SLIDE: ω-GML and hierarchy ────────────────────────────────────────────────
== ω-GML und die Logikhierarchie

- ω-GML fügt *unendliche Disjunktionen* von GML-Formeln hinzu:
$
  phi ::= psi quad | quad limits(union.big)_(psi in Psi) psi
  quad (Psi "eine abzählbare Menge von GML-Formeln")
$


#v(0.3em)
- Da GNN[R] mit reellen Zahlen *beliebig viele* Werte unterscheiden kann, benötigt es diese unendliche Ausdrucksstärke.
- ω-GML kann *unentscheidbare* Grapheigenschaften definieren — daher ist GNN[$RR$] sehr mächtig.

#v(0.4em)
- *Ausdrucksstärke (semantische Inklusion, nicht syntaktisch):*
$
  "GML" quad subset.neq quad "GMSC" quad subset.neq quad omega"-GML"
$
