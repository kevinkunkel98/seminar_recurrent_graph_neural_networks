#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 4 — GNNs über MSO-Eigenschaften  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
== Was ist MSO? #h(0.5em) #kevin

MSO (Monadische Logik zweiter Stufe) erweitert FO um *Mengenquantifizierung*:
- FO: Quantifizierung über *Elemente* ($exists x$, $forall x$)
- MSO: zusätzlich Quantifizierung über *Mengen von Elementen* ($exists X$, $forall X$)

#v(0.3em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.9em,
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *Auf Graphen:* FO — „jeder Knoten hat einen Nachbarn"\
    #v(0.2em)
    MSO — „der Graph ist bipartit", „Pfad von $a$ nach $b$", $k$-Färbbarkeit, Zusammenhang, …
  ],
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *Auf Zeichenketten:*\
    #v(0.1em)
    FO $equiv$ sternfreie reguläre Sprachen\
    MSO $equiv$ alle regulären Sprachen
  ],
)

#v(0.25em)
#example[
  *Bipartitheit:* $exists X. forall y. forall z. (E(y,z) -> (X(y) <-> not X(z)))$ — FO kann das *nicht* (keine Mengenvariablen).
]

#v(0.2em)
#remark[
  GNN[$RR$] geht weit über MSO hinaus (Satz 3.4). Aber MSO erfasst nahezu alles, was in der Praxis relevant ist.
]

// ── SLIDE: The MSO Collapse Theorem ──────────────────────────────────────────
== Das MSO-Kollapstheorem #h(0.5em) #kevin

#v(0.15em)
#theorem([MSO-Kollaps — Satz 4.3 #h(0.3em) @ahvonen2024logical])[
  Für jede in MSO ausdrückbare Eigenschaft $cal(P)$:
  $
    cal(P) "ausdrückbar als GNN"[RR] quad arrow.l.r.double quad cal(P) "ausdrückbar als GNN"[FF]
  $
  Kombiniert mit Satz 3.2: GNN[$FF$] $equiv$ GNN[$RR$] $equiv$ GMSC über allen MSO-Eigenschaften.
]

#v(0.25em)
- *Beweisidee:* GMSC/ω-GML sehen nur Bäume (bisimulationsinvariant)
- MSO auf Bäumen ↔ Paritätsbaumautomaten (PTAs)
- Aus einem PTA baut man ein GMSC-Programm per Tiefenzertifikat:

#v(0.1em)
#align(center)[
  #block(fill: sand, inset: (x: 1.5em, y: 0.6em), radius: 4pt, stroke: 0.5pt + navy)[
    MSO-Eigenschaft $cal(P)$ $arrow.r$ PTA $A$ $arrow.r$ $k$-Präfixdekorationen $arrow.r$ GMSC-Programm $Lambda$
  ]
]

#v(0.2em)
#block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Schlüsselerkenntnis:* Die Extrastärke von GNN[$RR$] liegt vollständig *außerhalb* von MSO. Falls ein GNN eine MSO-Eigenschaft nicht lernt, liegt das am Training oder der Architektur — *nicht* an der Float-Präzision.
]
