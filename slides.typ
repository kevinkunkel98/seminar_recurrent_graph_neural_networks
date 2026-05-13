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
#let amber = rgb("#b7770d")

// ── Speaker badge ─────────────────────────────────────────────────────────────
#let tom   = box(
  fill: rgb("#e8f4fd"), stroke: 0.5pt + rgb("#2196F3"),
  inset: (x: 5pt, y: 2pt), radius: 3pt,
)[#text(size: 0.7em, fill: rgb("#1565C0"), weight: "bold")[Tom]]

#let kevin = box(
  fill: mint, stroke: 0.5pt + sage,
  inset: (x: 5pt, y: 2pt), radius: 3pt,
)[#text(size: 0.7em, fill: sage, weight: "bold")[Kevin]]

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
  fill: rgb("#fef9ec"), stroke-color: amber)
#let example(body)           = thm-box([Example], body,
  fill: rgb("#f3e5f5"), stroke-color: rgb("#7b1fa2"))

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

#set text(size: 19pt)

// ── GNN diagram for title slide ───────────────────────────────────────────────
#let gnn-diagram = canvas(length: 1cm, {
  import draw: *
  let node-r = 0.38
  let col-center = rgb("#2563a8")
  let col-inner  = navy
  let col-outer  = rgb("#3d6b9e")
  let col-edge   = rgb("#7fa8cc")

  let v  = (0, 0)
  let u1 = (-2.1,  1.3)
  let u2 = (-2.1, -1.3)
  let u3 = ( 2.0,  1.1)
  let w1 = (-3.8,  2.4)
  let w2 = (-3.8,  0.2)
  let w3 = (-3.8, -2.0)
  let w4 = ( 3.7,  2.3)
  let w5 = ( 3.7, -0.4)

  let edge-style = (stroke: (paint: col-edge, thickness: 1.2pt),
                    mark: (end: ">", size: 0.25))
  line(w1, u1, ..edge-style); line(w2, u1, ..edge-style)
  line(w3, u2, ..edge-style); line(u1, v,  ..edge-style)
  line(u2, v,  ..edge-style); line(u3, v,  ..edge-style)
  line(w4, u3, ..edge-style); line(w5, u3, ..edge-style)

  let draw-node(pos, label, fill, r: node-r, label-size: 0.32) = {
    circle(pos, radius: r, fill: fill, stroke: none)
    content(pos, text(fill: white, size: label-size * 1cm, weight: "bold")[#label])
  }
  for (pos, lbl) in ((w1, $w_1$), (w2, $w_2$), (w3, $w_3$), (w4, $w_4$), (w5, $w_5$)) {
    draw-node(pos, lbl, col-outer, r: node-r * 0.85, label-size: 0.28)
  }
  draw-node(u1, $u_1$, col-inner); draw-node(u2, $u_2$, col-inner)
  draw-node(u3, $u_3$, col-inner)
  circle(v, radius: node-r * 1.3, fill: col-center,
         stroke: (paint: white, thickness: 1.5pt))
  content(v, text(fill: white, size: 0.34cm, weight: "bold")[$v$])
  content((0, -1.25),
    text(fill: col-edge, size: 0.28cm, style: "italic")[
      $x_v^t = "COM"(x_v^(t-1),, "AGG"({{x_u^(t-1)}}_u))$
    ]
  )
})

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE 1 — Title
// ══════════════════════════════════════════════════════════════════════════════
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
  #align(center + horizon)[#gnn-diagram]
]

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE 2 — Outline
// ══════════════════════════════════════════════════════════════════════════════
= Outline

== Talk Overview

#v(0.4em)
#grid(columns: (auto, 1fr, auto), gutter: 0.6em, row-gutter: 0.55em,
  align: (right, left, left),
  tom,  [*2.1 — Graph Neural Networks*], [~5 min],
  [],   [Message passing, standard vs.\ recurrent, floats vs.\ reals], [],
  kevin,[*2.2 — Logics*], [~5 min],
  [],   [GML, GMSC, ω-GML, and their hierarchy], [],
  tom,  [*3 — Connecting GNNs and Logics via Automata*], [~20 min],
  [],   [Distributed automata, main theorems, GNN[F] vs.\ GNN[R]], [],
  kevin,[*4 — Characterizing GNNs over MSO Properties*], [~20 min],
  [],   [What is MSO? The collapse theorem], [],
  [#tom#h(0.3em)#kevin], [*Conclusion*], [~10 min],
)

#v(0.6em)
#block(fill: sand, stroke: (left: 3pt + navy), inset: (x: 0.9em, y: 0.7em), radius: 3pt)[
  *Paper:* Ahvonen, Heiman, Kuusisto, Lutz — NeurIPS 2024 @ahvonen2024logical
]

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 2.1 — GNNs  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
= GNNs

== Message Passing GNNs #h(0.5em) #tom

#v(0.2em)
Each node $v$ maintains a *feature vector* updated in rounds:

$
  x_v^((t)) = phi lr((x_v^((t-1)),, plus.o_(u in cal(N)(v)) psi(x_v^((t-1)), x_u^((t-1)))))
$

- *AGG* — aggregate neighbor feature vectors (e.g.\ sum, max)
- *COM* — combine own vector with aggregated result (e.g.\ MLP, GRU)

#v(0.4em)
*Standard GNN:* run for a *fixed* $N$ rounds, then read out. \
$N$ is a hyperparameter — must be chosen in advance.

// ── SLIDE: Standard vs. Recurrent ────────────────────────────────────────────
== Standard vs. Recurrent GNNs

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 1.0em,
  block(stroke: 1pt + blue, fill: sky, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: blue)[Standard GNN]\
    #v(0.3em)
    - Runs exactly $N$ rounds
    - $N$ fixed before computation
    - After $N$ rounds: accept or reject
    - *Problem:* must know $N$ upfront
  ],
  block(stroke: 1pt + sage, fill: mint, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: sage)[Recurrent GNN]\
    #v(0.3em)
    - No fixed round limit
    - Runs until a node reaches an *accepting* state
    - A special $bold("DONE")$ vector signals termination
    - The GNN decides *itself* when it is done
  ],
)

#v(0.5em)
#remark[
  What happens when computation can take *arbitrarily long*? E.g.\ a loop that iterates until some condition is met? — We need an adaptive stopping criterion.
]

// ── SLIDE: Formal definition of Recurrent GNN ────────────────────────────────
== Recurrent GNNs — Formal Model

#definition([Recurrent GNN])[
  A recurrent $"GNN"[RR]$ over $(Pi, d)$ is a tuple $cal(G) = (RR^d, pi, delta, F)$:
  - *init* $pi: cal(P)(Pi) -> RR^d$, #h(0.8em)
    *transition* $delta(x,y) = "COM"(x, "AGG"(y))$, #h(0.8em)
    *accept* $F subset.eq RR^d$

  $cal(G)$ *accepts* $(G, v)$ iff $x_v^t in F$ for *some* $t in NN$.
]

#v(0.3em)
Replace $RR$ with floating-point $FF$ → $"GNN"[FF]$.

#example[
  *Reachability of label $p$:* Use $C = A = 1, b = 0$ (1-dimensional).
  Round 0: state is 1 if $p in lambda(v)$, else 0.
  Round $t$: state is 1 if node or any neighbor is 1.
  Propagates through the whole graph — regardless of size.
]

// ── SLIDE: Floats vs. Reals ───────────────────────────────────────────────────
== GNN[F] vs. GNN[R] — Why It Matters

#v(0.2em)
In practice GNNs use *floats* ($FF$). Theory usually assumes *reals* ($RR$).

#v(0.3em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *The float problem:* Floating-point addition is *not associative*:
  $(a + b) + c eq.not a + (b + c)$

  In a 2-decimal system: $1 + (-1) + 0.01 = 0.01$, but $(1 + 0.01) + (-1) = 1.0 + (-1) = 0$\
  because $1.01$ is not representable and gets rounded.
]

#v(0.3em)
*Consequence* (Proposition 2.3): For every float system $FF$ there exists $k in NN$ such that for all multisets $M$ of floats:
$
  "SUM"_FF (M) = "SUM"_FF (M|_k)
$
Past $k$ copies of a value, additional copies make *no difference* — floats can't count beyond a fixed bound.

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 2.2 — Logics  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
= Logics

== Graded Modal Logic (GML) #h(0.5em) #kevin

#v(0.2em)
GML is propositional logic extended with *counting modalities*:
$
  phi ::= top mid p mid not phi mid phi and phi mid lozenge_(>= k) phi
$

The key formula $lozenge_(>= k) phi$ means: *"at least $k$ out-neighbors satisfy $phi$"*

#v(0.3em)
#example[
  On *graphs:*
  - $lozenge_(>= 1) p$ — "there is a neighbor with label $p$"
  - $lozenge_(>= 3) (q and lozenge_(>= 2) r)$ — "at least 3 neighbors have $q$ and each has ≥2 neighbors with $r$"
]

#v(0.3em)
*Classic result* @barcelo2020logical: constant-iteration GNNs $equiv$ GML (relative to FO-definable properties)

// ── SLIDE: GMSC ───────────────────────────────────────────────────────────────
== Graded Modal Substitution Calculus (GMSC)

GMSC extends GML with *recursive rules* — a program $Lambda$ consists of:

#block(fill: sand, stroke: 0.4pt + luma(200), inset: (x: 0.9em, y: 0.7em), radius: 3pt)[
  ```
  X(0) :− φ    // base case: starting formula (GML)
  X    :− ψ    // iteration: rule that may use X recursively
  ```
]

#v(0.3em)
The $n$-th unfolding $X^n$: substitute $X$ in $psi$ by $X^(n-1)$, starting from $X^0 = phi$.

$Lambda$ accepts $(G, v)$ if $G, v tack.r.double X^n$ for *some* $n$.

#v(0.3em)
#example[
  *Reachability of $p$:* #h(1em) `X(0) :− p` #h(1.5em) `X :− ◇X` \
  $X^i = lozenge dots.c lozenge p$ (exactly $i$ diamonds) = reachability in $i$ steps
]

// ── SLIDE: ω-GML and hierarchy ────────────────────────────────────────────────
== ω-GML and the Logic Hierarchy

ω-GML adds *infinite disjunctions* of GML formulas:
$
  phi ::= psi quad | quad limits(union.big)_(psi in Psi) psi
  quad (Psi "a countable set of GML formulas")
$

#v(0.3em)
Since GNN[R] with real numbers can distinguish *arbitrarily many* values, it needs this infinite expressive power.

#v(0.4em)
*Expressive power:*
$
  "GML" quad subset quad "GMSC" quad subset quad omega"-GML"
$

#v(0.3em)
#example[
  *On strings:*\
  FO $equiv$ star-free regular languages\
  MSO $equiv$ all regular languages

  *On graphs:*\
  FO can say: "every node has a neighbor"\
  MSO can say: "the graph is bipartite", "there exists a path from $a$ to $b$"
]

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 3 — Connecting GNNs and Logics via Automata  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
= GNNs and Logics via Automata

== Distributed Automata — CMPA #h(0.5em) #tom

#definition([Counting Message-Passing Automaton (CMPA)])[
  A CMPA $(Q, q_0, delta, F)$ runs on graphs:
  - Each node starts in state $q_0$
  - Each node updates its state based on its *own state* and the *multiset* of neighbor states:
    $q_v^t = delta(q_v^(t-1),, {{q_u^(t-1) | (v,u) in E}})$
  - Node $v$ *accepts* iff $q_v^t in F$ for some $t$

  *FCMPA* — finite state set $Q$ #h(2em) *CMPA* — countably infinite $Q$
]

#v(0.3em)
CMPAs are like GNNs but with *discrete* states. This makes them easier to connect with logic.

// ── SLIDE: The three-way correspondence ──────────────────────────────────────
== The Three-Way Correspondence

#v(0.3em)
The key insight: GNNs, automata, and logics form a *tight triangle*:

#v(0.4em)
#align(center)[
  #block(fill: sand, inset: (x: 1.5em, y: 1em), radius: 4pt, stroke: 0.5pt + navy)[
    #grid(columns: (1fr, auto, 1fr), align: center + horizon, gutter: 1em,
      block(fill: sky, inset: 0.7em, radius: 3pt)[GNN[$FF$]],
      $<->$,
      block(fill: sky, inset: 0.7em, radius: 3pt)[FCMPA],
    )
    #v(0.3em)
    #grid(columns: (1fr, auto, 1fr), align: center + horizon, gutter: 1em,
      block(fill: mint, inset: 0.7em, radius: 3pt)[GNN[$RR$]],
      $<->$,
      block(fill: mint, inset: 0.7em, radius: 3pt)[CMPA],
    )
  ]
]

#v(0.4em)
- GNN[$FF$] $<->$ FCMPA because floats have bounded counting (Prop.\ 2.3)
- GNN[$RR$] $<->$ CMPA because reals can distinguish any multiset size exactly
- Both automaton classes then connect to their respective logic

// ── SLIDE: Why GNN[R] > GNN[F] ───────────────────────────────────────────────
== Why GNN[R] is Strictly More Powerful

#v(0.2em)
*The counting argument:*

#v(0.2em)
#block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  GNN[$RR$] can express: *"The number of out-neighbors is a prime."*

  For any $U subset.eq NN$ — even *undecidable* ones — GNN[$RR$] can check whether the neighbor count lies in $U$.
]

#v(0.4em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  GNN[$FF$] with bound $k$ cannot distinguish graphs with $k$ vs.\ $k+1$ neighbors.

  So GNN[$FF$] *cannot* express primality of degree for arbitrary degree.
]

#v(0.4em)
*Absolute result:* GNN[$FF$] $<$ GNN[$RR$]. \
But the extra power of reals lies in properties no one ever needs in practice — which is the surprising result coming up in Section 4.

// ── SLIDE: Main Theorems ──────────────────────────────────────────────────────
== Main Theorems

#v(0.2em)
#theorem([GNN[F] ≡ GMSC — Theorem 3.2 #h(0.3em) @ahvonen2024logical])[
  The following have the *same expressive power* — absolutely, no background logic:
  $
    "GNN"[FF] quad equiv quad "R-simple AC-GNN"[FF] quad equiv quad "GMSC" quad equiv quad "FCMPA"
  $
]

#v(0.4em)
#theorem([GNN[R] ≡ ω-GML — Theorem 3.4 #h(0.3em) @ahvonen2024logical])[
  $
    "GNN"[RR] quad equiv quad "CMPA" quad equiv quad omega"-GML"
  $
  ω-GML can define *undecidable* graph properties — so GNN[$RR$] is very powerful.
]

#v(0.3em)
Both results are *absolute* — no relativization to a background logic required.

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 4 — Characterizing GNNs over MSO  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
= GNNs over MSO Properties

== What is MSO? #h(0.5em) #kevin

MSO (Monadic Second-Order Logic) extends FO with *set quantification*:
- FO: quantify over *elements* ($exists x$, $forall x$)
- MSO: additionally quantify over *sets of elements* ($exists X$, $forall X$)

#v(0.4em)
#grid(columns: (1fr, 1fr), gutter: 1em,
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *On graphs:*\
    #v(0.2em)
    FO can say:\
    "every node has a neighbor"\
    #v(0.3em)
    MSO can say:\
    "the graph is bipartite"\
    "there exists a path from $a$ to $b$"\
    many global structural properties
  ],
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *On strings:*\
    #v(0.2em)
    FO $equiv$ star-free regular languages\
    #v(0.3em)
    MSO $equiv$ all regular languages\
    #v(0.3em)
    (a clean, well-known correspondence)
  ],
)

#v(0.3em)
MSO is in a sense the *natural* logic for graphs — it captures almost all properties one cares about in practice.

// ── SLIDE: More MSO examples ──────────────────────────────────────────────────
== MSO — What It Can Express

#v(0.2em)
MSO-expressible graph properties include:

#grid(columns: (1fr, 1fr), gutter: 0.8em,
  list(
    [Connectivity],
    [$k$-colorability],
    [Hamiltonicity],
    [Bipartiteness],
  ),
  list(
    [Planarity (for fixed genus)],
    [Existence of a path between two labeled nodes],
    [Many more natural structural properties],
  ),
)

#v(0.4em)
#remark[
  MSO is *not* the limit of what GNNs can do. Section 3 showed GNN[$RR$] can go far beyond MSO. But MSO covers everything that matters in practice.
]

// ── SLIDE: The MSO Collapse Theorem ──────────────────────────────────────────
== The MSO Collapse Theorem

#v(0.2em)
#theorem([MSO Collapse — Theorem 4.3 #h(0.3em) @ahvonen2024logical])[
  For any property $cal(P)$ expressible in MSO:
  $
    cal(P) "expressible as GNN"[RR] quad arrow.l.r.double quad cal(P) "expressible as GNN"[FF]
  $
  Both are further captured by GMSC. This also holds for constant-iteration GNNs.
]

#v(0.4em)
#grid(columns: (1fr, 1fr), gutter: 1em,
  block(fill: rgb("#ffebee"), stroke: 1pt + rgb("#f44336"), inset: 0.8em, radius: 3pt)[
    *Absolutely:* GNN[$RR$] $>$ GNN[$FF$]\
    #v(0.2em)
    Extra power: "degree is prime", undecidable properties.
  ],
  block(fill: mint, stroke: 1pt + sage, inset: 0.8em, radius: 3pt)[
    *Relative to MSO:* GNN[$RR$] $=$ GNN[$FF$]\
    #v(0.2em)
    For all practically relevant properties, floats are *just as good*.
  ],
)

// ── SLIDE: Intuition for the proof ───────────────────────────────────────────
== Why the Gap Vanishes — Intuition

#v(0.2em)
The proof goes via *Parity Tree Automata (PTAs)* — which characterize MSO on tree-structured graphs (Janin–Walukiewicz theorem):

#v(0.3em)
#align(center)[
  #block(fill: sand, inset: (x: 1.5em, y: 0.8em), radius: 4pt, stroke: 0.5pt + navy)[
    MSO property $cal(P)$ $arrow.r$ PTA $A$ $arrow.r$ $k$-prefix decorations $arrow.r$ GMSC program $Lambda$
  ]
]

#v(0.4em)
*Key insight:* The extra power of GNN[$RR$] lies entirely *outside* of MSO. \
If $cal(P)$ is in MSO and expressible by GNN[$RR$], one can always find a GMSC program — and hence a GNN[$FF$] — for it.

#v(0.3em)
#block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Practical consequence:* Theoretical analyses with $RR$ are safe — for MSO properties the results transfer to floats. If a GNN doesn't learn an MSO-definable property, the problem is in training or architecture, not float precision.
]

// ══════════════════════════════════════════════════════════════════════════════
// CONCLUSION  [Kevin & Tom]
// ══════════════════════════════════════════════════════════════════════════════
= Summary

== Results at a Glance #h(0.5em) #kevin #h(0.2em) #tom

#v(0.4em)
#table(
  columns: (auto, 1fr, 1fr, 1fr),
  align: (left, center, center, center),
  stroke: none,
  fill: (_, row) => if row == 0 { navy } else if calc.odd(row) { rgb("#f0f4f9") } else { white },
  table.hline(stroke: 0.5pt + navy),
  [#text(fill: white, weight: "bold")[Setting]],
  [#text(fill: white, weight: "bold")[GNN[F]]],
  [#text(fill: white, weight: "bold")[GNN[R]]],
  [#text(fill: white, weight: "bold")[Automaton]],
  table.hline(stroke: 0.3pt + luma(200)),
  [Absolute],         [≡ GMSC],  [≡ ω-GML],  [F: FCMPA, R: CMPA],
  [Relative to MSO],  [≡ GMSC],  [≡ GMSC (!!)], [≡ FCMPA],
  table.hline(stroke: 0.5pt + navy),
)

#v(0.6em)
*Key takeaway:*
- Absolutely: GNN[$FF$] $<$ GNN[$RR$] — reals can express undecidable properties
- Relative to MSO: GNN[$FF$] $equiv$ GNN[$RR$] — *theory and practice converge*

// ── SLIDE: Open Questions ─────────────────────────────────────────────────────
== Conclusion & Open Questions

#v(0.2em)
*What we showed:*
- Exact logical characterizations: GNN[$FF$] $equiv$ GMSC, GNN[$RR$] $equiv$ ω-GML
- Both results are *absolute* — no background logic needed
- The real–float gap *vanishes* for all MSO-definable properties
- Floats lose nothing vs.\ reals for any property one would use in practice

#v(0.4em)
*Open questions:*
- *Termination:* How does a recurrent GNN learn *when* to stop? Not addressed.
- *Global readout:* How does the characterization change with a global pooling layer?
- *Complexity:* Is expressibility in GMSC decidable?
- *Attention architectures:* Where do GAT / Transformer fit in this framework?

// ══════════════════════════════════════════════════════════════════════════════
// References
// ══════════════════════════════════════════════════════════════════════════════
= References

== References

#set text(size: 14pt)
#bibliography("refs.bib", style: "ieee", title: none)
