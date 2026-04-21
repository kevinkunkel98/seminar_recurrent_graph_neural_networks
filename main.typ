#import "@preview/ctheorems:1.1.3": *

// ── Palette ───────────────────────────────────────────────────────────────────
#let navy  = rgb("#1c3a5e")
#let blue  = rgb("#2563a8")
#let sky   = rgb("#dce9f7")
#let sage  = rgb("#1e6b3c")
#let mint  = rgb("#e4f4ec")
#let rule-color = rgb("#c0cfe0")

// ── Page ──────────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 3.5cm, top: 3cm, bottom: 3cm),
  numbering: "1",
  number-align: center,
  footer: context {
    let n = counter(page).get().first()
    if n > 1 {
      align(center, text(size: 9pt, fill: luma(160), str(n)))
    }
  },
)

// ── Typography ────────────────────────────────────────────────────────────────
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.72em, spacing: 1.3em)
#show link: set text(fill: blue)

// ── Headings ──────────────────────────────────────────────────────────────────
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(1.6em, weak: true)
  let num = counter(heading).display("1")
  stack(
    dir: ltr,
    spacing: 0.6em,
    text(fill: navy, weight: "bold", size: 13pt)[#num],
    text(fill: navy, weight: "bold", size: 13pt)[#it.body],
  )
  v(0.25em, weak: true)
  line(length: 100%, stroke: 0.4pt + rule-color)
  v(0.7em, weak: true)
}

#show heading.where(level: 2): it => {
  v(1em, weak: true)
  let num = counter(heading).display("1.1")
  text(fill: blue, weight: "semibold", size: 11.5pt)[#num #h(0.5em) #it.body]
  v(0.4em, weak: true)
}

// ── Math ──────────────────────────────────────────────────────────────────────
#set math.equation(numbering: "(1)", supplement: [])
#show math.equation.where(block: false): it => box(it)   // keep inline eq on one line

// ── Theorem Environments ──────────────────────────────────────────────────────
#show: thmrules.with(qed-symbol: $square$)

#let _box(color, fill) = (name: str, num: content, body: content) => {
  block(
    width: 100%,
    inset: (x: 1em, y: 0.75em),
    radius: 2pt,
    fill: fill,
    stroke: (left: 2.5pt + color),
  )[
    #text(weight: "bold", fill: color)[#name #num]
    #if str.len(str) > 0 [ #text(style: "italic")[(#str)]]
    #text(".")
    #h(0.4em)
    #body
  ]
}

#let theorem = thmenv(
  "theorem", none, none,
  (name, num, body, color: blue) =>
    block(width: 100%, inset: (x: 1em, y: 0.75em), radius: 2pt,
          fill: sky, stroke: (left: 2.5pt + blue))[
      #text(weight: "bold")[Theorem #num]
      #if name != [] [#text(style: "italic", size: 10.5pt)[ (#name)]]
      #[.] #h(0.3em) #body
    ]
)

#let lemma = thmenv(
  "lemma", none, none,
  (name, num, body) =>
    block(width: 100%, inset: (x: 1em, y: 0.75em), radius: 2pt,
          fill: sky, stroke: (left: 2.5pt + blue))[
      #text(weight: "bold")[Lemma #num]
      #if name != [] [#text(style: "italic", size: 10.5pt)[ (#name)]]
      #[.] #h(0.3em) #body
    ]
)

#let proposition = thmenv(
  "proposition", none, none,
  (name, num, body) =>
    block(width: 100%, inset: (x: 1em, y: 0.75em), radius: 2pt,
          fill: sky, stroke: (left: 2.5pt + blue))[
      #text(weight: "bold")[Proposition #num]
      #if name != [] [#text(style: "italic", size: 10.5pt)[ (#name)]]
      #[.] #h(0.3em) #body
    ]
)

#let corollary = thmenv(
  "corollary", none, none,
  (name, num, body) =>
    block(width: 100%, inset: (x: 1em, y: 0.75em), radius: 2pt,
          fill: sky, stroke: (left: 2.5pt + blue))[
      #text(weight: "bold")[Corollary #num]
      #if name != [] [#text(style: "italic", size: 10.5pt)[ (#name)]]
      #[.] #h(0.3em) #body
    ]
)

#let definition = thmenv(
  "definition", none, none,
  (name, num, body) =>
    block(width: 100%, inset: (x: 1em, y: 0.75em), radius: 2pt,
          fill: mint, stroke: (left: 2.5pt + sage))[
      #text(weight: "bold", fill: sage)[Definition #num]
      #if name != [] [#text(style: "italic", size: 10.5pt)[ (#name)]]
      #[.] #h(0.3em) #body
    ]
)

#let example = thmplain(
  "example", "Example",
  titlefmt: it => text(weight: "bold")[#it],
  bodyfmt: it => it,
)

#let remark = thmplain(
  "remark", "Remark",
  titlefmt: it => text(style: "italic")[#it],
)

#let proof = thmproof("proof", "Proof")

// ── Title Block ───────────────────────────────────────────────────────────────
#let maketitle(
  title: [],
  author: [],
  affiliation: [],
  course: [],
  date: [],
  abstract: none,
) = {
  v(0.8cm)
  align(center)[
    #text(size: 20pt, weight: "bold", fill: navy, font: "New Computer Modern")[#title]
    #v(1.2em)
    #text(size: 11pt)[#author] \
    #v(0.2em)
    #text(size: 10pt, style: "italic", fill: luma(80))[#affiliation] \
    #if course != [] {
      v(0.2em)
      text(size: 10pt, style: "italic", fill: luma(80))[#course]
    }
    #v(0.3em)
    #text(size: 10pt, fill: luma(120))[#date]
    #v(1.4em)
    #line(length: 55%, stroke: 0.6pt + navy)
  ]
  if abstract != none {
    v(1.2em)
    pad(x: 1.8cm)[
      #align(center)[#text(size: 10pt, weight: "bold", tracking: 0.8pt)[ABSTRACT]]
      #v(0.6em)
      #text(size: 10.5pt)[#abstract]
    ]
    v(1.2em)
    line(length: 100%, stroke: 0.3pt + rule-color)
    v(1.5em)
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DOCUMENT
// ─────────────────────────────────────────────────────────────────────────────

#maketitle(
  title: [Recurrent Graph Neural Networks \ and Their Logical Characterizations],
  author: [Kevin Kunkel],
  affiliation: [Universität Leipzig],
  course: [Seminar: Graph Neural Networks],
  date: [Summer Semester 2025],
  abstract: [
    Graph neural networks (GNNs) process graph-structured data via iterative
    message passing. Recurrent GNNs extend this by allowing an unbounded number
    of rounds, terminating only when a node's feature vector enters an
    _accepting_ set. We survey the expressive power of recurrent GNNs and
    their exact logical characterizations: GNNs over floating-point numbers
    are captured by the graded modal substitution calculus (GMSC), while
    GNNs over the reals correspond to the infinitary modal logic $omega$-GML.
    We also outline how these results relate to distributed automata and
    monadic second-order logic.
  ],
)

= Introduction

Graph neural networks (GNNs) @scarselli2009graph have become a central tool
for learning on graph-structured data, with applications ranging from
molecular property prediction to traffic forecasting and knowledge-graph
reasoning. The theoretical foundations of GNNs — in particular their
_expressive power_ — have attracted considerable interest since Barceló
et al. @barcelo2020logical showed that constant-iteration GNNs are precisely
as expressive as graded modal logic (GML) on first-order definable properties.

A natural and practically motivated extension is to allow GNNs to run for an
_adaptive_ number of steps, halting only when a termination condition is
satisfied. These *recurrent GNNs* are the subject of @ahvonen2024logical, whose
main results we present here. The key questions are:

+ What is the exact logical expressiveness of recurrent GNNs when computations
  use real numbers versus floating-point numbers?
+ Do the two arithmetic regimes differ in expressive power?
+ What is the relationship to monadic second-order logic (MSO)?

We write $"GNN"[RR]$ for recurrent GNNs over $RR$ and $"GNN"[FF]$ for those
over floating-point numbers $FF$.

= Preliminaries

== Graphs and Node Properties

We work with finite, node-labeled directed graphs. Let $"LAB"$ be a countably
infinite set of _node label symbols_. A *$Pi$-labeled graph* for $Pi subset.eq "LAB"$
is a triple $G = (V, E, lambda)$ where $V$ is a finite set of nodes,
$E subset.eq V times V$ is a set of directed edges, and
$lambda : V -> cal(P)(Pi)$ assigns a set of labels to each node.

A *pointed graph* $(G, v)$ pairs a graph $G$ with a distinguished node $v in V$.
A *node property over $Pi$* is a class $cal(N)$ of pointed $Pi$-labeled graphs.

== Recurrent Graph Neural Networks

#definition("Recurrent GNN")[
  A *recurrent GNN* $cal(G) = (RR^d, pi, delta, F)$ over $(Pi, d)$ consists of
  - an *initialization function* $pi : cal(P)(Pi) -> RR^d$,
  - a *transition function* $delta : RR^d times cal(M)(RR^d) -> RR^d$ given by
    $delta(x, y) = "COM"(x, "AGG"(y))$, and
  - a set $F subset.eq RR^d$ of *accepting feature vectors*.

  On a pointed graph $(G, v)$ the GNN computes iteratively:
  $
    x_u^0 &= pi(lambda(u)) quad forall u in V \
    x_u^t &= "COM"(x_u^(t-1),, "AGG"({x_w^(t-1) | (u,w) in E}))
  $
  The GNN *accepts* $(G, v)$ if $x_v^t in F$ for some $t in NN$.
]

The aggregation function AGG typically is sum, min, max, or average; COM
is a learned combination. The *R-simple* variant fixes the non-linearity to
truncated ReLU:
$
  "COM"(x, "AGG"(y)) = f(x dot.c C + sum_(u) x_u dot.c A + bold(b)),
  quad f = "ReLU"^*
$
where $C, A in RR^(d times d)$ and $bold(b) in RR^d$.

== Modal Logics

The *graded modal logic* GML extends propositional logic with counting
modalities $\u{27E8} k \u{27E9} phi$ meaning "at least $k$ out-neighbors satisfy $phi$."
Its *substitution calculus* extension MSC @kuusisto2023modal adds fixpoint-like
substitution rules, while *GMSC* further incorporates counting.
The *infinitary* extension $omega$-GML allows countably infinite disjunctions.

= Main Results

The central theorems of @ahvonen2024logical establish exact matches between
recurrent GNN models and modal logics.

#theorem("Floats")[
  $"GNN"[FF]$s, GMSC, and R-simple aggregate-combine $"GNN"[FF]$s all have
  the same expressive power. #cite(<ahvonen2024logical>, supplement: "Thm. 3.2")
]

This result is _absolute_: it does not relativize to a background logic, relying
only on natural assumptions about floating-point arithmetic (specifically, that
$FF$ is a discretely-ordered semiring with decidable equality).

#theorem("Reals")[
  $"GNN"[RR]$s have the same expressive power as $omega$-GML.
  #cite(<ahvonen2024logical>, supplement: "Thm. 3.4")
]

#corollary[
  Relative to MSO-expressible properties, $"GNN"[RR]$s and $"GNN"[FF]$s are
  equally expressive, and both are captured by GMSC.
  #cite(<ahvonen2024logical>, supplement: "Thm. 4.3")
]

These results imply a striking fact: the gap between reals and floats
disappears entirely for MSO-definable properties. The theoretically unlimited
arithmetic of $RR$ provides no benefit over the finite precision of $FF$ when
the target property is MSO-definable.

= Distributed Automata Characterizations

The proofs crucially employ a correspondence between GNNs and distributed
automata. A *counting message-passing automaton* (CMPA) is an automaton
running on a graph where each node updates its state based on its current
state and the _multiset_ of states received from out-neighbors.

#definition("CMPA")[
  A CMPA is a tuple $(Q, q_0, delta, F)$ where $Q$ is a (possibly infinite)
  set of states, $delta : Q times cal(M)(Q) -> Q$ is the transition function,
  and $F subset.eq Q$ is the set of accepting states. On a pointed graph
  $(G, v)$ the automaton runs synchronously: each node $u$ computes
  $q_u^(t) = delta(q_u^(t-1), {{q_w^(t-1) | (u,w) in E}})$
  and $(G, v)$ is accepted iff $q_v^t in F$ for some $t$.
]

The *bounded* variant FCMPA restricts $Q$ to be finite. The correspondence is:

#proposition[
  $
    "GNN"[FF] equiv "FCMPA" < "GNN"[RR] equiv "CMPA"
  $
  where $equiv$ denotes equal expressive power and $<$ strict containment.
]

= Discussion

== Reals vs. Floats

The strict separation $"GNN"[FF] < "GNN"[RR]$ in the general (non-MSO) setting
shows that unbounded arithmetic genuinely increases expressive power. A
$"GNN"[RR]$ can define undecidable graph properties via $omega$-GML, while
$"GNN"[FF]$s are always decidable (being finite-state in disguise via FCMPAs).

== Implications for Practice

Most deployed GNNs operate in floating-point arithmetic. The characterization
via GMSC and FCMPAs suggests that their theoretical expressive power is
well-understood and bounded, and that any property expressible by a
$"GNN"[RR]$ that is also MSO-definable can already be expressed by a $"GNN"[FF]$.

== Open Questions

- Can the results extend to GNNs with *global readout* mechanisms?
- What is the complexity of deciding whether a given GMSC formula is
  expressible by an R-simple $"GNN"[FF]$?
- How do attention-based architectures (e.g. GAT) fit into this logical
  framework?

= Conclusion

Recurrent GNNs admit clean and exact logical characterizations:
floating-point GNNs correspond to GMSC and real-valued GNNs to $omega$-GML.
Relative to MSO these two regimes collapse to the same expressive class,
revealing a pleasing harmony between theory (reals) and practice (floats).
These results deepen our understanding of what GNNs can and cannot express,
and open avenues for connecting neural network architectures to classical
logics and automata theory.

#bibliography("refs.bib")
