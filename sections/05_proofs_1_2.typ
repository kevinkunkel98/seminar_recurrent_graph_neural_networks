#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 3 — GNNs und Logiken über Automaten  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
// == Verteilte Automaten — CMPA #h(0.5em) #tom

// #definition([Zählender Nachrichtenweiterleitungsautomat (CMPA)])[
//   Ein CMPA $(Q, q_0, delta, F)$ läuft auf Graphen:
//   - Jeder Knoten startet im Zustand $q_0$
//   - Jeder Knoten aktualisiert seinen Zustand basierend auf seinem *eigenen Zustand* und der *Multimenge* der Nachbarzustände:
//     $q_v^t = delta(q_v^(t-1), , {{q_u^(t-1) | (v,u) in E}})$
//   - Knoten $v$ *akzeptiert*, wenn $q_v^t in F$ für ein $t$

//   *FCMPA* — endliche Zustandsmenge $Q$ #h(2em) *CMPA* — abzählbar unendliches $Q$
// ]

// #v(0.3em)
// CMPAs sind wie GNNs, aber mit *diskreten* Zuständen. Das macht sie einfacher mit Logik zu verbinden.

// // ── SLIDE: The three-way correspondence ──────────────────────────────────────
// == Die Dreifachkorrespondenz #h(0.5em) #tom

// #v(0.2em)
// GNNs, Automaten und Logiken bilden ein *enges Dreieck*. Warum der Umweg über CMPAs? Direktübersetzung GNN[$FF$] → GMSC ist technisch schwer — CMPAs machen es handhabbar:

// #v(0.15em)
// #block(fill: sand, stroke: (left: 3pt + amber), inset: (x: 0.8em, y: 0.5em), radius: 3pt)[
//   GNN[$FF$] bounded (Prop. 2.3) → endlich viele Zustände → FCMPA → direkte logische Kodierung → GMSC
// ]

// #v(0.3em)
// #align(center)[
//   #block(fill: sand, inset: (x: 1.5em, y: 1em), radius: 4pt, stroke: 0.5pt + navy)[
//     #grid(
//       columns: (1fr, auto, 1fr),
//       align: center + horizon,
//       gutter: 1em,
//       block(fill: sky, inset: 0.7em, radius: 3pt)[GNN[$FF$]], $<->$, block(fill: sky, inset: 0.7em, radius: 3pt)[FCMPA],
//     )
//     #v(0.3em)
//     #grid(
//       columns: (1fr, auto, 1fr),
//       align: center + horizon,
//       gutter: 1em,
//       block(fill: mint, inset: 0.7em, radius: 3pt)[GNN[$RR$]],
//       $<->$,
//       block(fill: mint, inset: 0.7em, radius: 3pt)[CMPA],
//     )
//   ]
// ]

// #v(0.3em)
// - GNN[F] $<->$ FCMPA — Floats sind bounded → endliche Zustandsmenge
// - GNN[$RR$] $<->$ CMPA — reelle Zahlen unterscheiden jede Nachbaranzahl exakt

== Beweis GNN[$RR$] $<=>$ $omega$-GML

//- GNNs mit
//  - unendlich vielen Zuständen $Q$
//  - unbounded counting $k$
//  - reellen Zahlen $RR$
//
//  => omega-GML
//
#v(0.2em)
#theorem([Satz 1])[
  Das Folgende hat die *gleiche Ausdrucksstärke*:
  $
    "GNN"[RR] quad equiv quad omega"-GML"
  $
]

#v(0.2em)
#columns(2, gutter: 1em)[

  *GNN[$RR$] $->$ $omega$-GML:*

  Übergangsfunktion hängt ab von
  1. eigenem Zustand
  2. Multi-Set von Zuständen der Nachbarn.

  Beides kann in GML-Formel erfasst werden.

  Über unendliche Disjunktion können beliebige Tiefen erfasst werden.

  #colbreak()

  *$omega$-GML $->$ GNN[$RR$]*:

  Formel in unendliche Disjunktion von "Typen" umwandeln.

  Jeder Knoten erkundet schrittweise seine Nachbarschaft.
  /*
  - Knoten erhält „Tree Encodings“ seiner Nachbarn.
  - `AGG` kombiniert zu größerem Baum
  - `COM` aktualisiert Label der neuen Wurzel entsprechend eigenem Label
  */

  /*
  #v(1em)
  Formel prüfen:
  - GNN erstellt Schritt für Schritt die konzentrische Map.
    Jedes Mal überprüft es, ob die aktuelle Map in der „unendlich langen Liste“ der $omega$-GML-Formel ist.
  - Falls ja, hält es an.
  */

  Baum als Binärstring encodieren. $-> RR$
  /*
  1. Anzahl Nodes unär kodieren: $1^n 0$
  2. alle $n$ Labels auflisten
  3. Adjazenzmatrix zeilenweise ($n^2$ Bits)
  */
]


== Floats

In der Praxis *Gleitkommazahlen* (F), nicht $RR$!

$
  ± 0.d_1 dots.h.c d_p times beta^e
$

Floats sind *endlich*!

#v(0.2em)
#grid(
  columns: (1fr, 1fr),
  gutter: 1.0em,
  block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
    *Problem 1:* Addition ist nicht assoziativ.

    #h(1em) #highlight(fill: rgb("#aaffaa"), radius: 50pt, extent: 5pt)[Python Demo]

    $->$ Isomorphie-Invarianz?
  ],
  block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
    *Problem 2:* Nur endliches Zählen.

    $
      "SUM"_"F" (M) = "SUM"_"F" (M|_k)
    $

    $->$ Gleitkommazahlen können nicht über eine feste Grenze hinaus zählen.
  ],
)

Problem 1 lösbar durch Summen-Konvention. $=>$ Problem 2.

== Beweis $"GNN"[F] <=> "R-simple GNNs" <=> "GMSC"$

#v(0.4em)
#theorem([Satz 2])[
  Das Folgende hat die *gleiche Ausdrucksstärke*:
  $
    "GNN[F]" quad equiv quad "R-simple GNN[F]" quad equiv quad "GMSC"
  $
]

#v(2em)
#columns(2, gutter: 1em)[

  *GNN[F] $->$ GMSC:*

  Nur endlich viele Zustandskombinationen bei Floats.
  #h(1em)
  #highlight(" Problem 2 ", fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), radius: 3pt)

  $->$ Alle möglichen Multi-Sets können als GML-Formel encodiert werden.

  #colbreak()

  *GMSC $->$ R-simple GNN:*

  (Programm in "Normalform" überführen.)

  Je (Sub-)Schema ein Eintrag im Feature-Vektor.

  Logik über Matrizen $C, A$ und Bias-Vektor $b$.

  Zustätzlich eine _Clock_.

  /*
  Synchronisation notwendig:
  - Je Regel unterschiedlich viele Schritte
  - GNN macht immer maximalen Schritt-Count.
  - GNN macht pro Logik-Schritt $D' + 1$ message rounds
  - Zähler erforderlich $->$ zweite Vektor-Hälfte.
  */
]
