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
    - MSO: „der Graph ist bipartit", $k$-Färbbarkeit, Zusammenhang, …
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
== Das MSO-Kollapstheorem — Beweisidee

#v(0.6em)
Wir bauen aus einer MSO-Eigenschaft Schritt für Schritt ein GMSC-Programm:

#v(0.8em)
*1. Eigenschaft #sym.arrow.r Automat*
- Graph zu einem Baum abwickeln (GMSC sieht ohnehin nur Bäume)
- MSO-Eigenschaft in einen Baumautomaten übersetzen (Janin–Walukiewicz)

#v(0.5em)
*2. Automat #sym.arrow.r endliches Zertifikat*
- Der Automat prüft den Baum, indem er Zustände durch ihn schickt
- Statt des unendlichen Laufs genügt ein *endlich tiefer* Ausschnitt als Beweis
- Bei Akzeptanz steht das Ergebnis ab einer endlichen Tiefe fest

#v(0.5em)
*3. Zertifikat #sym.arrow.r GMSC-Programm*
- Das Programm rechnet diesen Automaten Runde für Runde nach
- *Eine Iterationsrunde = ein Schritt des Automaten*
- #sym.arrow.r Jede MSO-Eigenschaft, die ein GNN[$RR$] kann, liegt in GMSC

== Mengen & Alternierung: blauer Pfad zu Rot
#v(0.3em)
#import "@preview/cetz:0.3.4"

#grid(
  columns: (auto, 1fr),
  column-gutter: 1.2em,
  align: horizon,
  [
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *
      let kblau = rgb("#1565c0")
      let kgruen = rgb("#2e7d32")
      let krot = rgb("#c62828")

      // normale Kanten (rechter Ast)
      set-style(stroke: (paint: luma(160), thickness: 1pt))
      line((0, 0), (1.6, -1.6))
      line((1.6, -1.6), (1.6, -3.2))

      // Gewinnpfad (grün, dick)
      set-style(stroke: (paint: kgruen, thickness: 2.5pt))
      line((0, 0), (-1.6, -1.6))
      line((-1.6, -1.6), (-1.6, -3.2))

      let node(pos, lbl, col) = {
        circle(pos, radius: 0.5, fill: col, stroke: white + 1.5pt)
        content(pos, text(fill: white, weight: "bold", size: 0.9em, lbl))
      }
      node((0, 0), "w", kblau)
      node((-1.6, -1.6), "a", kblau)
      node((1.6, -1.6), "b", kgruen)
      node((-1.6, -3.2), "c", krot)
      node((1.6, -3.2), "d", krot)

      // Annotation an a (die Zustandsmenge)
      content((-2.1, -1.6), anchor: "east", text(size: 0.6em, fill: kblau)[*{prüf-blau, such-rot}*])
      // b bricht
      content((2.1, -1.6), anchor: "west", text(size: 0.68em, fill: kgruen)[✗ grün bricht])
    })
  ],
  [
    #set text(size: 0.92em)
    *Gesucht:* Pfad zu #text(fill: rgb("#c62828"))[*rot*], alle Knoten #text(fill: rgb("#1565c0"))[*blau*].
    #v(0.5em)
    - An *a*: zwei Prüfungen *gleichzeitig*: blau sein _und_ rot weitersuchen → *Zustandsmenge* (Alternierung).
    #v(0.25em)
    - *b* ist grün → Pfad bricht, obwohl _d_ rot ist.
    #v(0.25em)
    - *w* sammelt alle Wege → *Familie* von Mengen; akzeptiert, weil der Weg über _a_ aufgeht.
  ],
)

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
