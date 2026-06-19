#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE — Einführung
// ══════════════════════════════════════════════════════════════════════════════
== Einführung — Beitrag des Papers

- GNNs sind überall in der Praxis, aber was können sie eigentlich erkennen?
#v(0.2em)
- Unser Werkzeug: rekurrente GNNs in *Modallogik* übersetzen → Ausdrucksstärke wird greifbar.

#v(0.7em)
#grid(
  columns: (1fr, 1fr),
  gutter: 0.9em,
  block(fill: rgb("#eef0ff"), stroke: (left: 3pt + blue), inset: (x: 0.85em, y: 0.7em), radius: 3pt)[
    *Theorie* #h(0.3em) GNN[$RR$]\
    #v(0.15em)
    reelle Zahlen: unendlich präzise.
  ],
  block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.85em, y: 0.7em), radius: 3pt)[
    *Praxis* #h(0.3em) GNN[F]\
    #v(0.15em)
    Gleitkommazahlen: endliche Genauigkeit
  ],
)

#v(0.7em)
#align(center)[
  #text(fill: navy, size: 1.05em)[
    *Macht dieser Unterschied einen Unterschied?*
  ]
]
