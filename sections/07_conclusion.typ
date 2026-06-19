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

- Relativ zu MSO: GNN[F] $equiv$ GNN[$RR$] *Theorie und Praxis konvergieren*

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
