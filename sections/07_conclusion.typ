#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// FAZIT  [Kevin & Tom]
// ══════════════════════════════════════════════════════════════════════════════
== Ergebnisse im Überblick #h(0.5em) #kevin #h(0.2em) #tom

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
== Fazit und Ausblick #h(0.5em) #kevin #h(0.2em) #tom

#v(0.2em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.65em), radius: 3pt)[
    *Erkenntnisse des Papers*\
    #v(0.2em)
    - GNN[F] $equiv$ GMSC, GNN[$RR$] $equiv$ ω-GML — erste *exakte* Charakterisierung rekurrenter GNNs
    - Absolut: GNN[$RR$] $>$ GNN[F] (Primalität, unentscheidbare Eigenschaften)
    - Relativ zu MSO: GNN[F] $=$ GNN[$RR$] — *Kollaps*
  ],
  block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.8em, y: 0.65em), radius: 3pt)[
    *Die Siliziumschranke*\
    #v(0.2em)
    - Jede GPU/TPU rechnet mit IEEE 754 Floats
    - Prop. 2.3 formalisiert: Floats können ab Schranke $k$ nicht mehr zählen
    - Eine *physikalische* Grenze in Silizium.\
    - *Diese Schranke ist für die Praxis irrelevant.*
  ],
)

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
== Referenzen

#set text(size: 14pt)
#bibliography("../refs.bib", style: "ieee", title: none)
