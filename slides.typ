#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "helpers.typ": *
#import "diagrams.typ": gnn-diagram

// ── Slide setup ───────────────────────────────────────────────────────────────
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: navy,
    primary-light: rgb("#1a4f8a"),
    secondary: rgb("#1c3a5e"),
    neutral-lightest: white,
    neutral-light: rgb("#edf2f8"),
  ),
  config-page(margin: (x: 2.8em, y: 2.2em)),
  config-info(
    title: [Rekurrente Graph Neural Networks],
    subtitle: [Logische Charakterisierungen mittels Modallogik],
    author: [Kevin Kunkel & Thomas Mohr],
    date: [Sommersemester 2026],
    institution: [Universität Leipzig — Seminar: Graph Neural Networks \ Betreuer: Prof. Carsten Lutz],
  ),
)

#set text(size: 19pt)
#set block(breakable: false)

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE 1 — Titelfolie
// ══════════════════════════════════════════════════════════════════════════════
#slide(
  config: config-methods(header: _ => none, footer: _ => none),
  composer: (1fr, 1fr),
  align: horizon,
)[
  #set align(left)
  #v(1fr)
  #text(size: 10pt, fill: luma(140), tracking: 2pt)[SEMINAR · GRAPH NEURAL NETWORKS · SS 2026]
  #v(0.5em)
  #set par(leading: 0.75em)
  #text(size: 32pt, weight: "bold", fill: navy)[Rekurrente Graph \ Neural Networks]
  #v(0.35em)
  #text(size: 15pt, fill: luma(70))[Logische Charakterisierungen mittels Modallogik]
  #v(0.85em)
  #line(length: 85%, stroke: 1.5pt + navy)
  #v(0.65em)
  #text(size: 13pt, weight: "bold")[Kevin Kunkel & Thomas Mohr]
  #v(0.15em)
  #text(size: 11pt, fill: luma(110))[
    Universität Leipzig · Betreuer: Prof. Carsten Lutz
  ]
  #v(0.55em)
  #block(fill: sand, stroke: (left: 2.5pt + navy), inset: (x: 0.75em, y: 0.55em), radius: 3pt)[
    #text(size: 10.5pt)[*Paper:* Ahvonen, Heiman, Kuusisto, Lutz — _NeurIPS 2024_ @ahvonen2024logical]
  ]
  #v(1fr)
][
  #align(center + horizon)[#gnn-diagram]
]

// ══════════════════════════════════════════════════════════════════════════════
// Sections
// ══════════════════════════════════════════════════════════════════════════════
#include "sections/01_gliederung.typ"
#include "sections/02_intro.typ"
#include "sections/03_gnn.typ"
#include "sections/04_logics.typ"
#include "sections/05_automata.typ"
#include "sections/06_mso.typ"
#include "sections/07_conclusion.typ"

#slide(config: config-methods(header: _ => none, footer: _ => none))[
  #align(center + horizon)[
    #v(1fr)
    #text(size: 36pt, weight: "bold", fill: navy)[Vielen Dank für Ihre Aufmerksamkeit!]
    #v(0.6em)
    #line(length: 40%, stroke: 1.5pt + navy)
    #v(0.6em)
    #text(size: 24pt, fill: luma(80))[Fragen?]
    #v(1fr)
  ]
]
