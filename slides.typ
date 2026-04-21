#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "@preview/cetz:0.3.4": canvas, draw

// ── Palette ───────────────────────────────────────────────────────────────────
#let navy  = rgb("#1c3a5e")
#let blue  = rgb("#1a4f8a")
#let sky   = rgb("#dce9f7")
#let sage  = rgb("#1e6b3c")
#let mint  = rgb("#e4f4ec")
#let sand  = rgb("#f7f4ef")

// ── Theorem box helpers ───────────────────────────────────────────────────────
#let thm-box(title, body, fill: sky, stroke-color: blue) = block(
  width: 100%, inset: (x: 0.9em, y: 0.65em), radius: 3pt,
  fill: fill, stroke: (left: 3pt + stroke-color),
)[
  #text(weight: "bold", fill: stroke-color, size: 0.9em)[#title]
  #h(0.4em)
  #body
]

#let theorem(title, body)    = thm-box([Theorem: #title], body)
#let definition(title, body) = thm-box([Definition: #title], body,
  fill: mint, stroke-color: sage)
#let remark(body)            = thm-box([Remark], body,
  fill: rgb("#fef9ec"), stroke-color: rgb("#b7770d"))

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
    title:       [Recurrent Graph Neural Networks],
    subtitle:    [Logical Characterizations via Modal Logic],
    author:      [Kevin Kunkel & Thomas Mohr],
    date:        [Summer Semester 2026],
    institution: [Universität Leipzig — Seminar: Graph Neural Networks \ Supervisor: Prof. Carsten Lutz],
  ),
)

// Slightly larger body text for readability
#set text(size: 19pt)

// ── GNN diagram for title slide ───────────────────────────────────────────────
#let gnn-diagram = canvas(length: 1cm, {
  import draw: *

  let node-r = 0.38
  let col-center = rgb("#2563a8")   // highlighted center node
  let col-inner  = navy
  let col-outer  = rgb("#3d6b9e")
  let col-edge   = rgb("#7fa8cc")
  let col-arrow  = navy

  // ── node positions ──────────────────────────────────────────────────────────
  let v  = (0, 0)          // center (query node)
  let u1 = (-2.1,  1.3)    // inner neighbors
  let u2 = (-2.1, -1.3)
  let u3 = ( 2.0,  1.1)
  let w1 = (-3.8,  2.4)    // outer nodes
  let w2 = (-3.8,  0.2)
  let w3 = (-3.8, -2.0)
  let w4 = ( 3.7,  2.3)
  let w5 = ( 3.7, -0.4)

  // ── edges ───────────────────────────────────────────────────────────────────
  let edge-style = (stroke: (paint: col-edge, thickness: 1.2pt),
                    mark: (end: ">", size: 0.25))

  line(w1, u1, ..edge-style)
  line(w2, u1, ..edge-style)
  line(w3, u2, ..edge-style)
  line(u1, v,  ..edge-style)
  line(u2, v,  ..edge-style)
  line(u3, v,  ..edge-style)
  line(w4, u3, ..edge-style)
  line(w5, u3, ..edge-style)

  // ── draw nodes ──────────────────────────────────────────────────────────────
  let draw-node(pos, label, fill, r: node-r, label-size: 0.32) = {
    circle(pos, radius: r, fill: fill, stroke: none)
    content(pos, text(fill: white, size: label-size * 1cm, weight: "bold")[#label])
  }

  // outer nodes
  for (pos, lbl) in ((w1, $w_1$), (w2, $w_2$), (w3, $w_3$),
                     (w4, $w_4$), (w5, $w_5$)) {
    draw-node(pos, lbl, col-outer, r: node-r * 0.85, label-size: 0.28)
  }

  // inner neighbors
  draw-node(u1, $u_1$, col-inner)
  draw-node(u2, $u_2$, col-inner)
  draw-node(u3, $u_3$, col-inner)

  // center node — highlighted, slightly larger
  circle(v, radius: node-r * 1.3, fill: col-center,
         stroke: (paint: white, thickness: 1.5pt))
  content(v, text(fill: white, size: 0.34cm, weight: "bold")[$v$])

  // ── annotation ──────────────────────────────────────────────────────────────
  content((0, -1.25),
    text(fill: col-edge, size: 0.28cm, style: "italic")[
      $x_v^t = "COM"(x_v^(t-1),, "AGG"({{x_u^(t-1)}}_u))$
    ]
  )
})

// ── Slides ────────────────────────────────────────────────────────────────────

// Custom title slide: left = info, right = GNN diagram
#slide(
  config: config-methods(header: _ => none, footer: _ => none),
  composer: (1fr, 1fr),
  align: horizon,
)[
  #set align(left)
  #v(1fr)
  #text(size: 26pt, weight: "bold", fill: navy)[Recurrent Graph Neural Networks]
  #v(0.3em)
  #text(size: 15pt, fill: luma(80))[Logical Characterizations via Modal Logic]
  #v(0.9em)
  #line(length: 80%, stroke: 1pt + navy)
  #v(0.6em)
  #text(size: 13pt)[Kevin Kunkel & Thomas Mohr]
  #v(0.2em)
  #text(size: 11pt, fill: luma(100))[Summer Semester 2026]
  #v(0.15em)
  #text(size: 11pt, fill: luma(100))[
    Universität Leipzig — Seminar: Graph Neural Networks \
    Supervisor: Prof. Carsten Lutz
  ]
  #v(1fr)
][
  #align(center + horizon)[
    #gnn-diagram
  ]
]

// --------------------------------------------------------------------------
= Motivation

== Why Study GNN Expressiveness?

#v(0.4em)
- GNNs are powerful — but *what exactly* can they compute?
- Classic result @barcelo2020logical: constant-iteration GNNs $equiv$ graded modal logic GML
  #h(1em) _(relative to first-order definable properties)_
- Missing piece: GNNs that run for an *adaptive* number of steps

#v(0.6em)
#block(
  fill: sand, stroke: (left: 3pt + navy), inset: (x: 0.9em, y: 0.7em), radius: 3pt,
)[
  *Question:* What is the expressive power of recurrent GNNs — ones that
  halt only when a node's state enters an _accepting set_?
]

// --------------------------------------------------------------------------
= Background

== Message Passing GNNs

#v(0.3em)
Each node $v$ maintains a feature vector updated in rounds:

$
  x_v^((t)) = phi lr((x_v^((t-1)),, plus.o_(u in cal(N)(v)) psi(x_v^((t-1)), x_u^((t-1)))))
$

- $phi$ — *combination* function (MLP, GRU, …)
- $plus.o$ — *aggregation* over neighbor multiset (sum, max, …)
- $cal(N)(v)$ — out-neighbors of $v$

#v(0.5em)
*Standard GNNs* run for a fixed $N$ rounds then read out.

*Recurrent GNNs* run until a termination condition is met.

// --------------------------------------------------------------------------
== Recurrent GNNs — Formal Model

#definition([Recurrent GNN])[
  A recurrent $"GNN"[RR]$ over $(Pi, d)$ is a tuple $cal(G) = (RR^d, pi, delta, F)$ with
  - *init* $pi: cal(P)(Pi) -> RR^d$, #h(1em)
    *transition* $delta(x,y) = "COM"(x, "AGG"(y))$, #h(1em)
    *accept* $F subset.eq RR^d$

  Node $v$ starts at $x_v^0 = pi(lambda(v))$ and updates:
  $x_v^t = "COM"(x_v^(t-1),, "AGG"({{x_w^(t-1) | (v,w) in E}}))$

  $cal(G)$ *accepts* $(G,v)$ iff $x_v^t in F$ for some $t in NN$.
]

Replace $RR$ with floating-point numbers $FF$ to get $"GNN"[FF]$.

// --------------------------------------------------------------------------
== R-Simple Aggregate-Combine GNNs

The *R-simple* variant uses truncated ReLU and a fixed linear architecture:

$
  "COM"(x, "AGG"(y)) = f lr((x dot C + sum_u x_u dot A + bold(b))),
  quad f = "ReLU"^*
$

where $C, A in RR^(d times d)$, $bold(b) in RR^d$, and $"ReLU"^*(x) = min(max(0,x), 1)$.

#v(0.5em)
#remark[
  Despite their simplicity, R-simple GNNs are as expressive as general $"GNN"[FF]$s
  — one of the main theorems.
]

// --------------------------------------------------------------------------
= Modal Logics

== Logical Toolkit

#v(0.3em)
#grid(columns: (1fr, 1fr), gutter: 1.2em,
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *GML* — Graded Modal Logic \
    #v(0.3em)
    Propositional logic + counting modalities
    $⟨ k ⟩ phi$ : "≥ $k$ out-neighbors satisfy $phi$"
    #v(0.3em)
    Captures constant-iteration GNNs @barcelo2020logical
  ],
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *MSC* — Modal Substitution Calculus \
    #v(0.3em)
    GML + rule-based fixpoint substitutions \
    #v(0.3em)
    *GMSC* adds counting to MSC \
    #v(0.3em)
    $omega$-*GML* — infinite disjunctions of GML formulas
  ],
)

#v(0.6em)
Expressive power: $"GML" subset "GMSC" subset omega"-GML"$

// --------------------------------------------------------------------------
= Main Results

== Theorem 1 — Floats

#v(0.4em)
#theorem([Floats #h(0.3em) @ahvonen2024logical])[
  The following have the *same expressive power*:

  $
    "GNN"[FF] quad equiv quad "R-simple AC-GNN"[FF] quad equiv quad "GMSC"
  $
]

#v(0.5em)
- The result is *absolute* — no relativization to a background logic
- Only assumption: $FF$ is a discretely-ordered semiring with decidable equality
- Reduces general $"GNN"[FF]$s to the simple R-simple form

// --------------------------------------------------------------------------
== Theorem 2 — Reals

#v(0.4em)
#theorem([Reals #h(0.3em) @ahvonen2024logical])[
  $
    "GNN"[RR] quad equiv quad omega"-GML"
  $
]

#v(0.5em)
- Also *absolute* — no background logic required
- $omega$-GML can define *undecidable* graph properties
- Hence $"GNN"[RR]$s are strictly more powerful than $"GNN"[FF]$s in general

// --------------------------------------------------------------------------
== Theorem 3 — MSO Collapse

#v(0.4em)
#theorem([MSO Collapse #h(0.3em) @ahvonen2024logical])[
  For any property $cal(P)$ expressible in MSO:
  $
    cal(P) "expressible as" "GNN"[RR] arrow.l.r.double cal(P) "expressible as" "GNN"[FF]
  $
  Both are further captured by GMSC.
]

#v(0.5em)
- The real–float gap *vanishes* for MSO-definable properties
- Practical GNNs (float arithmetic) lose *nothing* vs.\ theoretical models (reals)
  for any MSO-definable target property

// --------------------------------------------------------------------------
= Distributed Automata

== Counting Message-Passing Automata

#definition([CMPA])[
  A *counting message-passing automaton* $(Q, q_0, delta, F)$ runs on graphs:
  each node updates its state based on its own state and the *multiset* of
  neighbor states — just like a GNN, but with discrete states.
  - *FCMPA*: finite $Q$  #h(2em) *CMPA*: countably infinite $Q$
]

#v(0.3em)
The full correspondence:

$
  "GNN"[FF] equiv "FCMPA" < "GNN"[RR] equiv "CMPA"
$

#v(0.3em)
- FCMPAs are the finite-state heart of floating-point GNNs
- CMPAs capture the full power of real-valued recurrent computation on graphs
- Links GNNs to *distributed computing* models

// --------------------------------------------------------------------------
= Summary

== Results at a Glance

#v(0.5em)
#table(
  columns: (auto, 1fr, 1fr),
  align: (left, center, center),
  stroke: none,
  fill: (_, row) => if row == 0 { navy } else if calc.odd(row) { rgb("#f0f4f9") } else { white },
  table.hline(stroke: 0.5pt + navy),
  [#text(fill: white, weight: "bold")[Setting]],
  [#text(fill: white, weight: "bold")[GNN model]],
  [#text(fill: white, weight: "bold")[Logic / Automaton]],
  table.hline(stroke: 0.3pt + luma(200)),
  [Absolute (floats)],   [$"GNN"[FF]$],         [GMSC ≡ FCMPA],
  [Absolute (reals)],    [$"GNN"[RR]$],          [$omega$-GML ≡ CMPA],
  [Relative to MSO],     [$"GNN"[FF] equiv "GNN"[RR]$], [GMSC],
  table.hline(stroke: 0.5pt + navy),
)

#v(0.6em)
Key takeaway: *theory and practice converge* for MSO-definable properties.

// --------------------------------------------------------------------------
== Conclusion & Open Questions

#v(0.3em)
*What we showed:*
- Exact logical characterizations of recurrent GNNs, for both $RR$ and $FF$
- Absolute results — no background logic needed
- Real–float equivalence for all MSO-definable properties

#v(0.5em)
*Open questions:*
- GNNs with *global readout* — how does the characterization change?
- Complexity of deciding expressibility in GMSC?
- Attention-based architectures (GAT, Transformer) in this framework?

// --------------------------------------------------------------------------
= References

== References

#set text(size: 14pt)
#bibliography("refs.bib", style: "ieee", title: none)
