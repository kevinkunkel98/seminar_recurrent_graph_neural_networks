#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "helpers.typ": *
#import "diagrams.typ": gnn-diagram

// ── Slide setup ───────────────────────────────────────────────────────────────
#show: metropolis-theme.with(
  footer-right: context {
    if state("show-slide-number", true).get() { utils.slide-counter.display() }
  },
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
  footer: [Leipzig, 19.06.2026],
)

#set text(size: 19pt)
#set block(breakable: false)

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE 1 — Titelfolie
// ══════════════════════════════════════════════════════════════════════════════
#slide(
  config: utils.merge-dicts(
    config-methods(header: _ => none, footer: _ => none),
    config-common(freeze-slide-counter: true),
  ),
  align: horizon,
)[
  #set align(left)
  #v(1fr)
  #text(size: 10pt, fill: luma(140), tracking: 2pt)[SEMINAR · GRAPH NEURAL NETWORKS · SS 2026]
  #v(0.5em)
  #set par(leading: 0.75em)
  #text(size: 28pt, weight: "bold", fill: navy)[Logical Characterizations of Recurrent \ Graph Neural Networks with Reals and Floats]
  #v(0.3em)
  #text(size: 11pt, fill: luma(100))[Ahvonen · Heiman · Kuusisto · Lutz — _arXiv 2024_]
  #v(0.85em)
  #line(length: 100%, stroke: 1.5pt + navy)
  #v(0.65em)
  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [
      #text(size: 13pt, weight: "bold")[Kevin Kunkel & Thomas Mohr] \
      #v(0.15em)
      #text(size: 11pt, fill: luma(110))[Universität Leipzig · Betreuer: Prof. Carsten Lutz]
    ],
    [#image("leipziglogo.png", width: 12em)],
  )
  #v(1fr)
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
