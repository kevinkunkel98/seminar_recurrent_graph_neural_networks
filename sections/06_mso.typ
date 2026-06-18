#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 4 — GNNs über MSO-Eigenschaften  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════

// == MSO

// #v(0.1em)
// #remark[
//   GMSC $not subset$ MSO: es gibt Eigenschaften in GMSC, die MSO nicht ausdrücken kann. GMSC und $mu$-Kalkül sind *orthogonal* — keine enthält die andere.
// ]


// #v(0.2em)
// #example[
//   *Auf Zeichenketten:*\
//   - FO $equiv$ sternfreie reguläre Sprachen #h(1em) MSO $equiv$ alle regulären Sprachen

//   *Auf Graphen:*\
//   - FO: „jeder Knoten hat einen Nachbarn" #h(1em)MSO: „der Graph ist bipartit", „Pfad von $a$ nach $b$"
// ]


// #v(0.2em)
// #remark[
//   Centre-Point $in$ GMSC $without$ MSO: MSO kann globale Tiefenuniformität nicht ausdrücken. Damit ist Satz 4.3 eine echte Einschränkung — der Kollaps gilt nur *innerhalb* von MSO.
// ]
== Was ist MSO?

MSO (Monadic Second Order Logic) erweitert FO (First Order Logic) um *Mengenquantifizierung*:
- FO: Quantifizierung über *Elemente* ($exists x$, $forall x$)
- MSO: zusätzlich Quantifizierung über *Mengen von Elementen* ($exists X$, $forall X$)

#v(0.3em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.9em,
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *Auf Graphen:*
    - FO: „jeder Knoten hat einen Nachbarn"\
    - MSO: „der Graph ist bipartit", „Pfad von $a$ nach $b$", $k$-Färbbarkeit, Zusammenhang, …
  ],
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *Auf Zeichenketten:*\
    - FO $equiv$ sternfreie reguläre Sprachen\
    - MSO $equiv$ alle regulären Sprachen
  ],
)

#v(0.25em)
#example[
  *Bipartitheit:* $exists X. forall y. forall z. (E(y,z) -> (X(y) <-> not X(z)))$. FO kann das *nicht* (keine Mengenvariablen).
]

// ── SLIDE: Centre-Point — GMSC ⊄ MSO ─────────────────────────────────────────
== Centre-Point — GMSC ausdrückbar, MSO nicht

#v(0.15em)
#definition([Centre-Point (Bsp. 2.5 @ahvonen2024logical)])[
  $(G, w)$ hat die *Centre-Point-Eigenschaft* gdw. es ein $n in NN$ gibt, sodass *jeder* gerichtete Pfad von $w$ nach genau $n$ Schritten in einer *Sackgasse* (Knoten ohne ausgehende Nachbarn) endet.
]


#v(0.4em)
- *GMSC-Programm* ($X$ appointed):
#v(0.3em)
#align(center)[
  #block(fill: sand, stroke: 0.4pt + luma(200), inset: (x: 1.4em, y: 0.85em), radius: 4pt)[
    #grid(
      columns: (auto, auto, auto),
      column-gutter: 0.8em,
      row-gutter: 0.6em,
      align: (right, center, left),
      [$X^((0))$], [:−], [$square bot$],
      [$X$], [:−], [$lozenge X and square X$],
    )
  ]
]
#v(0.3em)
- $X^0 = square bot$ — wahr in Sackgassen ($square$ über leerem Nachbar-Set = wahr)
- $X^(n+1) = lozenge X^n and square X^n$ gilt in $v$ gdw. $v$ ≥1 Nachbar hat *und* alle Nachbarn $X^n$ erfüllen
- $X^n$ gilt in $v$ gdw. alle Pfade von $v$ haben Länge exakt $n$

// ── SLIDE: The MSO Collapse Theorem ──────────────────────────────────────────
== Das MSO-Kollapstheorem
#v(0.25em)
- *Beweisidee:* GMSC/ω-GML sind unraveling-invariant (graded Bisim.) → sehen nur Bäume
- MSO auf Bäumen ↔ Paritätsbaumautomaten (PTAs)
- Aus einem PTA baut man ein GMSC-Programm per Tiefenzertifikat:
#v(0.1em)
#align(center)[
  #block(fill: sand, inset: (x: 1.5em, y: 0.6em), radius: 4pt, stroke: 0.5pt + navy)[
    MSO-Eigenschaft $cal(P)$ $arrow.r$ PTA $A$ $arrow.r$ $k$-Präfixdekorationen $arrow.r$ GMSC-Programm $Lambda$
  ]
]

// ── SLIDE: Proof Pipeline ─────────────────────────────────────────────────────
== Das MSO-Kollapstheorem
#v(0.5em)
*1. $cal(P) arrow.r$ PTA $A$*
- GMSC ist unraveling-invariant (graded Bisim.) → wertet nur Baumfaltung $T_G(v)$ aus
- MSO auf Bäumen $equiv$ Paritätsbaumautomaten (Janin–Walukiewicz-Theorem)
- ∴ zu $cal(P)$ existiert PTA $A$: $A$ akzeptiert $T_G(v)$ $arrow.l.r.double$ $cal(P)(G,v)$
#v(0.4em)
*2. PTA $A$ $arrow.r$ $k$-Präfixdekorationen*
- PTA läuft *top-down*; die *Dekoration* wird von Blättern zur Wurzel aufgebaut
- *Tiefe-$n$-Dekoration:* weise jedem Knoten der ersten $n$ Ebenen seine Zustandsmengen-Familie $mu(v)$ zu
- Falls $A$ akzeptiert: ∃ minimales $n^*$, ab dem Dekoration einen Akzeptanzzeugen enthält
#v(0.4em)
*3. $k$-Präfixdekorationen $arrow.r$ GMSC-Programm $Lambda$*
- Variable $X_S$ pro Zustandsmenge $S$: $X_S^n (v) = 1$ $arrow.l.r.double$ $S in mu(v)$ (Dekoration an $v$)
- Terminalklausel ($n=0$): GML-Formel für Blattbedingungen des PTA
- Iterationsklausel: $lozenge_(>= k)$ propagiert Zustände — simuliert einen PTA-Übergangsschritt

== Hauptsätze 2

#v(0.4em)
#theorem([Satz 1])[
  Das Folgende hat die *gleiche Ausdrucksstärke*:
  $
    "GNN[F]" quad equiv quad "R-simple GNN[F]" quad equiv quad "GMSC"
  $
]

#v(0.2em)
#theorem([Satz 2])[
  Das Folgende hat die *gleiche Ausdrucksstärke*:
  $
    "GNN"[RR] quad equiv quad omega"-GML"
  $
]

#v(0.2em)
#theorem([Satz 3 — MSO-Kollaps])[
  Für jede in *MSO ausdrückbare* Eigenschaft $cal(P)$:
  $
    cal(P) "ausdrückbar als GNN"[RR] quad arrow.l.r.double quad cal(P) "ausdrückbar als GNN"[FF]
  $
  $=>$ Kombiniert mit Satz 1: #h(0.4em) GNN$[FF]$ $equiv$ GNN$[RR]$ $equiv$ GMSC #h(0.3em) *(über MSO)*
]

// == Absolut vs. MSO

// #v(0.3em)
// #grid(
//   columns: (1fr, 1fr),
//   gutter: 0.8em,
//   block(fill: rgb("#ffebee"), stroke: 1pt + rgb("#f44336"), inset: 0.8em, radius: 3pt)[
//     *Absolut:* GNN[$RR$] $>$ GNN[F]\
//     #v(0.15em)
//     Beispiel: „Grad ist Primzahl" — GNN[$RR$] kann das, GNN[F] nicht (bounded, Prop. 2.3).
//   ],
//   block(fill: mint, stroke: 1pt + sage, inset: 0.8em, radius: 3pt)[
//     *Relativ zu MSO:* GNN[$RR$] $=$ GNN[F]\
//     #v(0.15em)
//     Für alle praktisch relevanten Eigenschaften: Floats sind genauso gut. → Satz 4.3
//   ],
// )
