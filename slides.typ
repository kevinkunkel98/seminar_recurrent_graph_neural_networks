#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "helpers.typ": *
#import "diagrams.typ": gnn-diagram

// ── Slide setup ───────────────────────────────────────────────────────────────
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary:          navy,
    primary-light:    rgb("#1a4f8a"),
    secondary:        rgb("#1c3a5e"),
    neutral-lightest: white,
    neutral-light:    rgb("#edf2f8"),
  ),
  config-page(margin: (x: 2.8em, y: 2.2em)),
  config-info(
    title:       [Rekurrente Graph Neural Networks],
    subtitle:    [Logische Charakterisierungen mittels Modallogik],
    author:      [Kevin Kunkel & Thomas Mohr],
    date:        [Sommersemester 2026],
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
  #text(size: 26pt, weight: "bold", fill: navy)[Rekurrente Graph Neural Networks]
  #v(0.3em)
  #text(size: 15pt, fill: luma(80))[Logische Charakterisierungen mittels Modallogik]
  #v(0.9em)
  #line(length: 80%, stroke: 1pt + navy)
  #v(0.6em)
  #text(size: 13pt)[Kevin Kunkel & Thomas Mohr]
  #v(0.2em)
  #text(size: 11pt, fill: luma(100))[Sommersemester 2026]
  #v(0.15em)
  #text(size: 11pt, fill: luma(100))[
    Universität Leipzig — Seminar: Graph Neural Networks \
    Betreuer: Prof. Carsten Lutz
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
