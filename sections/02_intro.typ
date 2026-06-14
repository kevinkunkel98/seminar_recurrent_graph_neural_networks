#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE — Einführung
// ══════════════════════════════════════════════════════════════════════════════
== Einführung — Beitrag des Papers #h(0.5em) #tom #h(0.2em) #kevin

#v(0.2em)
GNNs sind Standard in der Praxis — aber was können sie *theoretisch* ausdrücken?

#v(0.25em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.8em, y: 0.65em), radius: 3pt)[
    *Bekannt — Barceló et al. 2020* @barcelo2020logical\
    #v(0.15em)
    Konstantiterations-GNNs $equiv$ GML\
    — aber: *relativ zu FO* als Hintergrundlogik\
    — und: kein Rekurrenz-Modell
  ],
  block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.8em, y: 0.65em), radius: 3pt)[
    *Dieser Beitrag — NeurIPS 2024* @ahvonen2024logical\
    #v(0.15em)
    Erste Charakterisierung *rekurrenter* GNNs — *absolut*, ohne jede Hintergrundlogik\
    — zwei Szenarien: GNN[$RR$] (Theorie) und GNN[F] (Hardware)
  ],
)

#v(0.35em)
*Zentrale Frage:* Wo liegt die Ausdrucksstärke rekurrenter GNNs — und macht es einen Unterschied, ob man reelle Zahlen oder Gleitkommazahlen verwendet?

#v(0.2em)
#block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.9em, y: 0.6em), radius: 3pt)[
  *Vorschau:* GNN[F] $equiv$ GMSC und GNN[$RR$] $equiv$ ω-GML — und: GNN[F] $=$ GNN[$RR$] für alle MSO-definierbaren Eigenschaften
]
