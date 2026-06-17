#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// FAZIT  [Kevin & Tom]
// ══════════════════════════════════════════════════════════════════════════════
== Ergebnisse im Überblick

#v(0.4em)
#table(
  columns: (auto, 1fr, 1fr),
  // 1fr),
  align: (left, center, center, center),
  stroke: none,
  fill: (_, row) => if row == 0 { navy } else if calc.odd(row) { rgb("#f0f4f9") } else { white },
  table.hline(stroke: 0.5pt + navy),
  [#text(fill: white, weight: "bold")[Kontext]],
  [#text(fill: white, weight: "bold")[GNN[F]]],
  [#text(fill: white, weight: "bold")[GNN[R]]],
  // [#text(fill: white, weight: "bold")[Automat]],
  table.hline(stroke: 0.3pt + luma(200)),
  [Absolut], [≡ GMSC], [≡ ω-GML],
  // [F: FCMPA, R: CMPA],
  [Relativ zu MSO], [≡ GMSC], [≡ GMSC (!!)],
  // [≡ FCMPA],
  table.hline(stroke: 0.5pt + navy),
)


#v(0.6em)
*Fazit:*
- Absolut: GNN[F] $<$ GNN[$RR$] — reelle Zahlen können unentscheidbare Eigenschaften ausdrücken

- Relativ zu MSO: GNN[F] $equiv$ GNN[$RR$] — *Theorie und Praxis konvergieren*

// ── SLIDE: Fazit — Theorie, Silizium, Zukunft ────────────────────────────────
== Fazit und Ausblick
#v(0.2em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.65em), radius: 3pt)[
    *Erkenntnisse des Papers*\
    #v(0.2em)
    - GNN[F] $equiv$ GMSC, GNN[$RR$] $equiv$ ω-GML
    - erste *exakte* Charakterisierung rekurrenter GNNs
    - Absolut: GNN[$RR$] $>$ GNN[F] (Primalität, unentscheidbare Eigenschaften)
    - Relativ zu MSO: GNN[F] $=$ GNN[$RR$] — *Kollaps*
  ],
  block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.8em, y: 0.65em), radius: 3pt)[
    *Die Float-Schranke*\
    #v(0.2em)
    - Jede GPU/TPU rechnet mit IEEE-754-Floats
    - Prop. 2.3: Floats *sättigen* — ab einer Schranke $k$ kein weiteres Zählen
    - Folge der *endlichen Mantisse*
    - *In der Praxis fast nie relevant*: sie greift nur bei unbeschränktem Zählen
  ],
)

#v(0.6em)

// Merksatz — stärkste Betonung
#block(
  fill: mint,
  width: 100%,
  radius: 3pt,
  inset: (x: 0.9em, y: 0.7em),
)[
  #text(size: 1.05em)[
    *Mitnehmen:* Lernt ein GNN eine MSO-Eigenschaft nicht, liegt es an Architektur oder Training und *nicht* an der Float-Präzision.
  ]
]

// #v(0.35em)
// #block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
//   *Was das für die Zukunft bedeutet:* Theoretische Analysen mit $RR$ gelten direkt für Hardware — Theoretiker und Ingenieure sprechen dieselbe Sprache. Wenn ein GNN eine Eigenschaft nicht lernt, liegt es am Training oder der Architektur. *Mehr Bits helfen nicht. Bessere Architekturen könnten.*
// ]

// #v(0.3em)
// *Offene Fragen:*
// - *Terminierung:* Wann und wie lernt ein GNN zu stoppen? (Ungelöst)
// - *Attention:* Wo ordnen sich GAT / Transformer in dieses Framework ein?

// ══════════════════════════════════════════════════════════════════════════════
// Referenzen
// ══════════════════════════════════════════════════════════════════════════════
#state("show-slide-number", true).update(false)
== Referenzen

#set text(size: 14pt)
#bibliography("../refs.bib", style: "ieee", title: none)
