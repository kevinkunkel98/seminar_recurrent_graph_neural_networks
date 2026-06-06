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

#let theorem(title, body)    = thm-box([Satz: #title], body)
#let definition(title, body) = thm-box([Definition: #title], body,
  fill: mint, stroke-color: sage)
#let remark(body)            = thm-box([Anmerkung], body,
  fill: rgb("#fef9ec"), stroke-color: amber)
#let example(body)           = thm-box([Beispiel], body,
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
    title:       [Rekurrente Graph Neural Networks],
    subtitle:    [Logische Charakterisierungen mittels Modallogik],
    author:      [Kevin Kunkel & Thomas Mohr],
    date:        [Sommersemester 2026],
    institution: [Universität Leipzig — Seminar: Graph Neural Networks \ Betreuer: Prof. Carsten Lutz],
  ),
)

#set text(size: 19pt)

// ── ReLU* (truncated ReLU) diagram ───────────────────────────────────────────
#let relu-star-diagram = canvas(length: 1cm, {
  import draw: *
  let col-ax  = luma(100)
  let col-fn  = rgb("#1a4f8a")
  let col-hi  = rgb("#1e6b3c")

  // Axes
  line((-0.8, 0), (3.2, 0), stroke: (paint: col-ax, thickness: 0.8pt),
       mark: (end: ">", size: 0.18))
  line((0, -0.5), (0, 2.0), stroke: (paint: col-ax, thickness: 0.8pt),
       mark: (end: ">", size: 0.18))

  // Axis labels
  content((3.35, 0),   text(size: 0.28cm, fill: col-ax)[$x$])
  content((0.15, 2.1), text(size: 0.28cm, fill: col-ax)[$y$])

  // Tick marks + labels
  line((1.5, -0.08), (1.5, 0.08), stroke: (paint: col-ax, thickness: 0.6pt))
  content((1.5, -0.30), text(size: 0.25cm, fill: col-ax)[$1$])
  line((-0.08, 1.5), (0.08, 1.5), stroke: (paint: col-ax, thickness: 0.6pt))
  content((-0.28, 1.5), text(size: 0.25cm, fill: col-ax)[$1$])

  // Dashed guide lines
  line((1.5, 0), (1.5, 1.5),
       stroke: (paint: luma(200), thickness: 0.6pt, dash: "dashed"))
  line((0, 1.5), (1.5, 1.5),
       stroke: (paint: luma(200), thickness: 0.6pt, dash: "dashed"))

  // Function: 0 for x<0, identity for 0≤x≤1, 1 for x>1
  line((-0.8, 0),   (0,   0),   stroke: (paint: col-fn, thickness: 2.2pt))
  line((0,    0),   (1.5, 1.5), stroke: (paint: col-fn, thickness: 2.2pt))
  line((1.5,  1.5), (3.0, 1.5), stroke: (paint: col-hi, thickness: 2.2pt))

  // Breakpoints
  circle((0,   0),   radius: 0.07, fill: col-fn, stroke: none)
  circle((1.5, 1.5), radius: 0.07, fill: col-hi, stroke: none)

  // Label
  content((2.5, 1.85), text(size: 0.30cm, fill: col-fn, weight: "bold")[ReLU\*])
  content((2.5, 0.85), text(size: 0.24cm, fill: luma(90), style: "italic")[= min(1, max(0, x))])
})

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

// ── Message-passing step diagram ─────────────────────────────────────────────
#let mp-step-diagram = canvas(length: 1cm, {
  import draw: *
  let col-v = rgb("#1c3a5e")
  let col-u = rgb("#1a4f8a")
  let col-e = rgb("#7fa8cc")

  let v  = (0, 0)
  let u1 = (-1.9, 1.3)
  let u2 = (-1.9, -1.3)
  let u3 = (2.0, 0)
  let r  = 0.38

  line(u1, v, stroke: (paint: col-e, thickness: 1.2pt), mark: (end: ">", size: 0.25))
  line(u2, v, stroke: (paint: col-e, thickness: 1.2pt), mark: (end: ">", size: 0.25))
  line(u3, v, stroke: (paint: col-e, thickness: 1.2pt), mark: (end: ">", size: 0.25))

  content((-3.1, 1.5),  text(size: 0.27cm, fill: col-u)[$bold(x)_(u_1)^((t-1))$])
  content((-3.1, -1.5), text(size: 0.27cm, fill: col-u)[$bold(x)_(u_2)^((t-1))$])
  content((3.1,  0.1),  text(size: 0.27cm, fill: col-u)[$bold(x)_(u_3)^((t-1))$])

  circle(u1, radius: r, fill: col-u, stroke: none)
  content(u1, text(fill: white, size: 0.30cm, weight: "bold")[$u_1$])
  circle(u2, radius: r, fill: col-u, stroke: none)
  content(u2, text(fill: white, size: 0.30cm, weight: "bold")[$u_2$])
  circle(u3, radius: r, fill: col-u, stroke: none)
  content(u3, text(fill: white, size: 0.30cm, weight: "bold")[$u_3$])

  circle(v, radius: r * 1.35, fill: col-v, stroke: (paint: white, thickness: 1.5pt))
  content(v, text(fill: white, size: 0.32cm, weight: "bold")[$v$])

  content((0, -2.0), text(size: 0.24cm, fill: col-v)[
    $bold(x)_v^((t)) = "COM"(bold(x)_v^((t-1)),,  "AGG"({bold(x)_u^((t-1))}_u))$
  ])
})

// ── RGNN computation rounds diagram ──────────────────────────────────────────
#let rgnn-rounds-diagram = canvas(length: 1cm, {
  import draw: *
  let col-n = rgb("#1a4f8a")
  let col-a = rgb("#1e6b3c")
  let col-e = rgb("#7fa8cc")

  // Round t=0
  circle((-0.3, 0.6), radius: 0.30, fill: col-n, stroke: none)
  circle(( 0.3, 0.6), radius: 0.30, fill: col-n, stroke: none)
  line((-0.3, 0.6), (0.3, 0.6), stroke: (paint: col-e, thickness: 0.7pt))
  content((0, -0.1), text(size: 0.25cm, fill: luma(80))[$t=0$])

  line((0.6, 0.3), (1.5, 0.3),
       stroke: (paint: luma(180), thickness: 0.7pt),
       mark: (end: ">", size: 0.16))

  // Round t=1
  circle((1.8, 0.6), radius: 0.30, fill: col-n, stroke: none)
  circle((2.4, 0.6), radius: 0.30, fill: col-n, stroke: none)
  line((1.8, 0.6), (2.4, 0.6), stroke: (paint: col-e, thickness: 0.7pt))
  content((2.1, -0.1), text(size: 0.25cm, fill: luma(80))[$t=1$])

  line((2.7, 0.3), (3.2, 0.3),
       stroke: (paint: luma(180), thickness: 0.7pt),
       mark: (end: ">", size: 0.16))
  content((3.65, 0.3), text(size: 0.38cm, fill: luma(160))[...])
  line((4.1, 0.3), (4.6, 0.3),
       stroke: (paint: luma(180), thickness: 0.7pt),
       mark: (end: ">", size: 0.16))

  // Round t=t* (accepting)
  circle((4.9,  0.6), radius: 0.33, fill: col-a,
         stroke: (paint: white, thickness: 1.5pt))
  circle((5.55, 0.6), radius: 0.30, fill: col-n, stroke: none)
  line((4.9, 0.6), (5.55, 0.6), stroke: (paint: col-e, thickness: 0.7pt))
  content((5.2, -0.1), text(size: 0.25cm, fill: col-a, weight: "bold")[$t=t^ast$])

  content((4.9, 1.35), text(size: 0.23cm, fill: col-a, weight: "bold")[DONE])
  line((4.9, 1.15), (4.9, 0.94),
       stroke: (paint: col-a, thickness: 0.7pt),
       mark: (end: ">", size: 0.13))
  content((4.9, 1.75), text(size: 0.22cm, fill: col-a)[$x_v^((t^ast)) in F$])
})

// ── Large GNN message-passing diagram (dedicated slide) ───────────────────────
#let gnn-big-diagram = canvas(length: 1.1cm, {
  import draw: *
  let col-ctr  = rgb("#1c3a5e")
  let col-inn  = rgb("#1a4f8a")
  let col-out  = rgb("#5b87b3")
  let col-eedg = rgb("#7fa8cc")
  let col-oedg = rgb("#aecbe0")
  let col-msg  = rgb("#b7770d")
  let col-agg  = rgb("#dce9f7")

  let v  = (0, 0)
  let u1 = (-3.2,  2.2)
  let u2 = (-3.2, -2.0)
  let u3 = ( 3.5,  0.8)
  let w1 = (-5.8,  3.5)
  let w2 = (-6.0,  0.6)
  let w3 = (-5.8, -2.9)
  let w4 = (-0.8, -3.8)
  let w5 = ( 5.7,  2.5)
  let w6 = ( 5.9, -0.7)

  // Outer edges
  let oe = (stroke: (paint: col-oedg, thickness: 0.9pt))
  line(w1, u1, ..oe); line(w2, u1, ..oe)
  line(w3, u2, ..oe); line(w4, u2, ..oe)
  line(w5, u3, ..oe); line(w6, u3, ..oe)

  // AGG ring
  circle(v, radius: 1.75, fill: col-agg,
         stroke: (paint: col-eedg, thickness: 1.3pt, dash: "dashed"))

  // Inner edges (thick arrows u→v)
  let ie = (stroke: (paint: col-eedg, thickness: 2.5pt), mark: (end: ">", size: 0.36))
  line(u1, v, ..ie); line(u2, v, ..ie); line(u3, v, ..ie)

  // Message labels on inner edges
  content((-2.1,  1.65), text(size: 0.28cm, fill: col-msg)[$psi(bold(x)_(u_1)^((t-1)))$])
  content((-2.1, -1.45), text(size: 0.28cm, fill: col-msg)[$psi(bold(x)_(u_2)^((t-1)))$])
  content(( 2.2,  0.65), text(size: 0.28cm, fill: col-msg)[$psi(bold(x)_(u_3)^((t-1)))$])

  // Outer nodes w
  circle(w1, radius: 0.34, fill: col-out, stroke: none)
  content(w1, text(fill: white, size: 0.24cm, weight: "bold")[$w_1$])
  circle(w2, radius: 0.34, fill: col-out, stroke: none)
  content(w2, text(fill: white, size: 0.24cm, weight: "bold")[$w_2$])
  circle(w3, radius: 0.34, fill: col-out, stroke: none)
  content(w3, text(fill: white, size: 0.24cm, weight: "bold")[$w_3$])
  circle(w4, radius: 0.34, fill: col-out, stroke: none)
  content(w4, text(fill: white, size: 0.24cm, weight: "bold")[$w_4$])
  circle(w5, radius: 0.34, fill: col-out, stroke: none)
  content(w5, text(fill: white, size: 0.24cm, weight: "bold")[$w_5$])
  circle(w6, radius: 0.34, fill: col-out, stroke: none)
  content(w6, text(fill: white, size: 0.24cm, weight: "bold")[$w_6$])

  // Inner nodes u + feature labels
  circle(u1, radius: 0.58, fill: col-inn, stroke: (paint: white, thickness: 1.8pt))
  content(u1, text(fill: white, size: 0.40cm, weight: "bold")[$u_1$])
  content((-4.8,  3.0), text(size: 0.28cm, fill: col-inn)[$bold(x)_(u_1)^((t-1))$])

  circle(u2, radius: 0.58, fill: col-inn, stroke: (paint: white, thickness: 1.8pt))
  content(u2, text(fill: white, size: 0.40cm, weight: "bold")[$u_2$])
  content((-4.8, -2.8), text(size: 0.28cm, fill: col-inn)[$bold(x)_(u_2)^((t-1))$])

  circle(u3, radius: 0.58, fill: col-inn, stroke: (paint: white, thickness: 1.8pt))
  content(u3, text(fill: white, size: 0.40cm, weight: "bold")[$u_3$])
  content(( 5.1,  1.5), text(size: 0.28cm, fill: col-inn)[$bold(x)_(u_3)^((t-1))$])

  // Central node v
  circle(v, radius: 0.85, fill: col-ctr, stroke: (paint: white, thickness: 2.8pt))
  content(v, text(fill: white, size: 0.58cm, weight: "bold")[$v$])

  // Labels: own state + AGG annotation
  content((0,  2.5), text(size: 0.28cm, fill: col-ctr, style: "italic")[$bold(x)_v^((t-1))$])
  content((0, -2.2), text(size: 0.30cm, fill: rgb("#4a88b8"), style: "italic")[AGG])

  // Update formula
  content((0, -3.5), text(size: 0.34cm, fill: col-ctr)[
    $bold(x)_v^((t)) = "COM"lr((bold(x)_v^((t-1)),,  "AGG"({psi(bold(x)_u^((t-1)))}_u)))$
  ])
})

// ── Large RGNN reachability diagram (dedicated slide) ─────────────────────────
#let rgnn-big-diagram = canvas(length: 1.1cm, {
  import draw: *
  let col-0   = rgb("#1a4f8a")
  let col-1   = rgb("#1e6b3c")
  let col-e0  = rgb("#7fa8cc")
  let col-e1  = rgb("#5bb87a")
  let rv = 0.40; let ru = 0.32
  let ny = 1.1

  // Frame 0: t=0 — only p active
  let f0 = 0.0
  let vx0 = f0+0.4; let ux10 = f0+1.2; let ux20 = f0+2.0; let px0 = f0+2.8
  rect((f0, 0.0), (f0+3.2, 2.5), fill: rgb("#f0f4f9"), stroke: 0.5pt+rgb("#c5d5e5"), radius: 4pt)
  line((vx0,ny),(ux10,ny), stroke: (paint: col-e0, thickness: 1.0pt))
  line((ux10,ny),(ux20,ny), stroke: (paint: col-e0, thickness: 1.0pt))
  line((ux20,ny),(px0,ny),  stroke: (paint: col-e1, thickness: 1.0pt))
  circle((vx0, ny),  radius: rv, fill: col-0, stroke: none)
  circle((ux10,ny),  radius: ru, fill: col-0, stroke: none)
  circle((ux20,ny),  radius: ru, fill: col-0, stroke: none)
  circle((px0, ny),  radius: rv, fill: col-1, stroke: (paint: white, thickness: 1.3pt))
  content((vx0, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$v$])
  content((ux10,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_1$])
  content((ux20,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_2$])
  content((px0, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$p$])
  content((vx0, ny+0.68),  text(size: 0.27cm, fill: luma(120))[0])
  content((ux10,ny+0.56),  text(size: 0.25cm, fill: luma(120))[0])
  content((ux20,ny+0.56),  text(size: 0.25cm, fill: luma(120))[0])
  content((px0, ny+0.68),  text(size: 0.27cm, fill: col-1, weight: "bold")[1])
  content((f0+1.6,-0.38), text(size: 0.31cm, fill: luma(70))[$t=0$])

  line((f0+3.35, ny),(f0+3.85, ny), stroke: (paint: luma(160), thickness: 1.0pt), mark: (end: ">", size: 0.23))

  // Frame 1: t=1 — u2 and p active
  let f1 = 4.0
  let vx1 = f1+0.4; let ux11 = f1+1.2; let ux21 = f1+2.0; let px1 = f1+2.8
  rect((f1, 0.0), (f1+3.2, 2.5), fill: rgb("#f0f4f9"), stroke: 0.5pt+rgb("#c5d5e5"), radius: 4pt)
  line((vx1,ny),(ux11,ny),  stroke: (paint: col-e0, thickness: 1.0pt))
  line((ux11,ny),(ux21,ny), stroke: (paint: col-e1, thickness: 1.0pt))
  line((ux21,ny),(px1,ny),  stroke: (paint: col-e1, thickness: 1.0pt))
  circle((vx1, ny),  radius: rv, fill: col-0, stroke: none)
  circle((ux11,ny),  radius: ru, fill: col-0, stroke: none)
  circle((ux21,ny),  radius: ru, fill: col-1, stroke: (paint: white, thickness: 1.1pt))
  circle((px1, ny),  radius: rv, fill: col-1, stroke: (paint: white, thickness: 1.3pt))
  content((vx1, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$v$])
  content((ux11,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_1$])
  content((ux21,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_2$])
  content((px1, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$p$])
  content((vx1, ny+0.68),  text(size: 0.27cm, fill: luma(120))[0])
  content((ux11,ny+0.56),  text(size: 0.25cm, fill: luma(120))[0])
  content((ux21,ny+0.56),  text(size: 0.25cm, fill: col-1, weight: "bold")[1])
  content((px1, ny+0.68),  text(size: 0.27cm, fill: col-1, weight: "bold")[1])
  content((f1+1.6,-0.38), text(size: 0.31cm, fill: luma(70))[$t=1$])

  line((f1+3.35, ny),(f1+3.85, ny), stroke: (paint: luma(160), thickness: 1.0pt), mark: (end: ">", size: 0.23))

  // Frame 2: t=2 — u1, u2, p active
  let f2 = 8.0
  let vx2 = f2+0.4; let ux12 = f2+1.2; let ux22 = f2+2.0; let px2 = f2+2.8
  rect((f2, 0.0), (f2+3.2, 2.5), fill: rgb("#f0f4f9"), stroke: 0.5pt+rgb("#c5d5e5"), radius: 4pt)
  line((vx2,ny),(ux12,ny),  stroke: (paint: col-e1, thickness: 1.0pt))
  line((ux12,ny),(ux22,ny), stroke: (paint: col-e1, thickness: 1.0pt))
  line((ux22,ny),(px2,ny),  stroke: (paint: col-e1, thickness: 1.0pt))
  circle((vx2, ny),  radius: rv, fill: col-0, stroke: none)
  circle((ux12,ny),  radius: ru, fill: col-1, stroke: (paint: white, thickness: 1.1pt))
  circle((ux22,ny),  radius: ru, fill: col-1, stroke: (paint: white, thickness: 1.1pt))
  circle((px2, ny),  radius: rv, fill: col-1, stroke: (paint: white, thickness: 1.3pt))
  content((vx2, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$v$])
  content((ux12,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_1$])
  content((ux22,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_2$])
  content((px2, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$p$])
  content((vx2, ny+0.68),  text(size: 0.27cm, fill: luma(120))[0])
  content((ux12,ny+0.56),  text(size: 0.25cm, fill: col-1, weight: "bold")[1])
  content((ux22,ny+0.56),  text(size: 0.25cm, fill: col-1, weight: "bold")[1])
  content((px2, ny+0.68),  text(size: 0.27cm, fill: col-1, weight: "bold")[1])
  content((f2+1.6,-0.38), text(size: 0.31cm, fill: luma(70))[$t=2$])

  line((f2+3.35, ny),(f2+3.85, ny), stroke: (paint: luma(160), thickness: 1.0pt), mark: (end: ">", size: 0.23))

  // Frame t*: all active, v ACCEPTS
  let f3 = 12.0
  let vx3 = f3+0.4; let ux13 = f3+1.2; let ux23 = f3+2.0; let px3 = f3+2.8
  let f3l = f3 - 0.1; let f3r = f3 + 3.3
  rect((f3l, -0.08),(f3r, 2.62), fill: rgb("#e4f4ec"), stroke: 1.3pt+col-1, radius: 5pt)
  line((vx3,ny),(ux13,ny),  stroke: (paint: col-e1, thickness: 1.0pt))
  line((ux13,ny),(ux23,ny), stroke: (paint: col-e1, thickness: 1.0pt))
  line((ux23,ny),(px3,ny),  stroke: (paint: col-e1, thickness: 1.0pt))
  circle((vx3, ny), radius: rv*1.28, fill: col-1, stroke: (paint: rgb("#7fcda0"), thickness: 2.2pt))
  circle((ux13,ny),  radius: ru, fill: col-1, stroke: (paint: white, thickness: 1.1pt))
  circle((ux23,ny),  radius: ru, fill: col-1, stroke: (paint: white, thickness: 1.1pt))
  circle((px3, ny),  radius: rv, fill: col-1, stroke: (paint: white, thickness: 1.3pt))
  content((vx3, ny),  text(fill: white, size: 0.30cm, weight: "bold")[$v$])
  content((ux13,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_1$])
  content((ux23,ny),  text(fill: white, size: 0.24cm, weight: "bold")[$u_2$])
  content((px3, ny),  text(fill: white, size: 0.28cm, weight: "bold")[$p$])
  content((vx3, ny+0.78),  text(size: 0.29cm, fill: col-1, weight: "bold")[1])
  content((ux13,ny+0.56),  text(size: 0.25cm, fill: col-1, weight: "bold")[1])
  content((ux23,ny+0.56),  text(size: 0.25cm, fill: col-1, weight: "bold")[1])
  content((px3, ny+0.68),  text(size: 0.27cm, fill: col-1, weight: "bold")[1])
  content((f3+1.6,-0.42), text(size: 0.31cm, fill: col-1, weight: "bold")[$t=t^ast$])
  content((vx3, ny+1.50), text(size: 0.28cm, fill: col-1, weight: "bold")[ACCEPT])
  line((vx3, ny+1.33),(vx3, ny+rv*1.28+0.06),
       stroke: (paint: col-1, thickness: 0.8pt), mark: (end: ">", size: 0.15))
})

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
// SLIDE 2 — Gliederung
// ══════════════════════════════════════════════════════════════════════════════
= Gliederung

== Überblick des Vortrags

#v(0.4em)
#grid(columns: (auto, 1fr, auto), gutter: 0.6em, row-gutter: 0.55em,
  align: (right, left, left),
  tom,  [*2.1 — Graph Neural Networks*], [~8 Min.],
  [],   [Nachrichtenweiterleitung, Standard vs.\ Rekurrent, Gleitkommazahlen vs. Reelle Zahlen], [],
  kevin,[*2.2 — Logiken*], [~8 Min.],
  [],   [GML, GMSC, ω-GML und ihre Hierarchie], [],
  tom,  [*3 — Verbindung von GNNs und Logiken über Automaten*], [~18 Min.],
  [],   [Verteilte Automaten, Hauptsätze, GNN[F] vs.\ GNN[R]], [],
  kevin,[*4 — Charakterisierung von GNNs über MSO-Eigenschaften*], [~18 Min.],
  [],   [Was ist MSO? Das Kollapstheorem], [],
  [#tom#h(0.3em)#kevin], [*Fazit + Diskussion*], [~8 Min.],
)

#v(0.6em)
#block(fill: sand, stroke: (left: 3pt + navy), inset: (x: 0.9em, y: 0.7em), radius: 3pt)[
  *Paper:* Ahvonen, Heiman, Kuusisto, Lutz — NeurIPS 2024 @ahvonen2024logical
]

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 2.1 — GNNs  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
= GNNs

== GNNs #h(0.5em) #tom

#v(0.2em)
Aktualisierung von Merkmalsvektoren:

$
  x_v^(t) = "COM" (x_v^(t-1), "AGG"( \{\{ x_u^(t-1) | (v,u) in E \}\} ) )
$
#pause
- *AGG* — aggregiert die Merkmalsvektoren der Nachbarn (z.B. Summe, Maximum)
#pause
- *COM* — kombiniert den eigenen Vektor mit dem aggregierten Ergebnis (z.B. MLP)

#v(0.5em)
#pause
#remark[
  Ungewöhnliche Konvention: Vektoren werden von *ausgehenden Nachbarn* gesammelt!
]

== GNN — Visualisierung der Nachrichtenweiterleitung #h(0.5em) #tom

#align(center + horizon)[
  #gnn-big-diagram
]

== R-einfache Aggregations-Kombinations-GNNs #tom

*R-einfache Aggregations-Kombinations-GNNs:*

$
  x_v^(t) &= "COM" (x_v^(t-1), "AGG"( \{\{ x_u^(t-1) | (v,u) in E \}\} ) ) \
  &= "ReLU*" (x_v^(t-1) dot bold(C) + sum_((v,u) in E) x_u^(t-1) dot bold(A) + bold(b) )
$
$bold(A)$: Matrix, $bold(b)$: Bias-Vektor, $bold(C)$: Matrix.

*ReLU\*:* gestutzte ReLU — klemmt den Ausgang auf $[0, 1]$

#v(0.3em)
#align(center)[#relu-star-diagram]

== Knoteneigenschaften #tom

*Beispieleigenschaft:* _Ist Symbol $p$ von Knoten $v$ aus erreichbar?_

-> Wie lässt sich das über GNNs lösen?

Idee:
- Initial erhält jeder Knoten mit Label $p$ den Merkmalswert 1.
#pause
- Update: Falls ein Nachbar den Wert 1 hat, setze sich selbst auf 1.
#pause
- Akzeptierende Merkmalsvektoren $F = {1}$.

#pause
Realisierbar als *R-einfaches Aggregations-Kombinations-GNN*:
$
  x_v^(t) = "ReLU*" (x_v^(t-1) + sum_((v,u) in E) x_u^(t-1) )
$

(durch Setzen von $bold(A)=1$, $bold(b)=0$, $bold(C)=1$.)


== Konstantiterations- vs. Rekurrente GNNs #tom

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 1.0em,
  block(stroke: 1pt + blue, fill: sky, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: blue)[Konstantiterations-GNN]\
    #v(0.3em)
    - Läuft genau $N$ Runden ($N$ als Hyperparameter)
    - Nach $N$ Runden: Akzeptieren oder Ablehnen
    - $x_v^N in F$
    - *Problem:* $N$ muss vorab bekannt sein
  ],
  block(stroke: 1pt + sage, fill: mint, inset: 0.8em, radius: 3pt, width: 100%)[
    #text(weight: "bold", fill: sage)[Rekurrentes GNN]\
    #v(0.3em)
    - Läuft bis ein Knoten einen *akzeptierenden* Zustand erreicht
    - $x_v^t in F$ für *ein* $t in NN$
    - Ein spezieller $bold("DONE")$-Vektor signalisiert das Ende
    - Das GNN entscheidet *selbst*, wann es fertig ist
  ],
)

Beide können verwendet werden, um eine *Knoteneigenschaft* auszudrücken.

#pause
#v(0.4em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Reachability als Trennbeispiel:* Erreichbarkeit ist mit einem rekurrenten GNN ausdrückbar, aber mit *keinem* Konstantiterations-GNN — denn für jedes feste $N$ gibt es einen Graphen, in dem $p$ erst nach mehr als $N$ Schritten erreichbar ist. Das ist die zentrale Neuerung gegenüber Barceló et al. 2020 @barcelo2020logical.
]


// ── SLIDE: RGNN Visualization ─────────────────────────────────────────────────
== Rekurrentes GNN — Berechnungsvisualisierung #h(0.5em) #tom

#align(center + horizon)[
  #rgnn-big-diagram
  #v(0.5em)
  #text(size: 0.82em, fill: luma(90), style: "italic")[
    Beispiel: Erreichbarkeit des Labels $p$ — Zustand $1$ = „$p$ ist von diesem Knoten aus erreichbar" — GNN akzeptiert, wenn $v$ Zustand $1$ erreicht
  ]
]

// ── SLIDE: Formal definition of Recurrent GNN ────────────────────────────────
== Rekurrente GNNs — Formales Modell

Ein GNN[$RR$] erhält einen gerichteten, knoten-gelabelten Graphen als Eingabe und liefert für jeden Knoten eine *Bool'sche Klassifikation* (akzeptiert / nicht akzeptiert). Die akzeptierenden Knoten sind genau jene mit Endzustand in $F$.

#v(0.2em)
#definition([Rekurrentes GNN])[
  Ein rekurrentes $"GNN"[RR]$ über $(Pi, d)$ ist ein Tupel $cal(G) = (RR^d, pi, delta, F)$:
  - *Init* $pi: cal(P)(Pi) -> RR^d$, #h(0.8em)
    *Übergang* $delta(x,y) = "COM"(x, "AGG"(y))$, #h(0.8em)
    *Akzeptanz* $F subset.eq RR^d$

  $cal(G)$ *akzeptiert* $(G, v)$ genau dann, wenn $x_v^t in F$ für *ein* $t in NN$.
]

#v(0.3em)
Ersetze $RR$ durch Gleitkommazahlen $FF$ → $"GNN"[FF]$.

#v(0.3em)
*Der DONE-Mechanismus:* Ein ausgezeichneter Vektor $bold(d) in RR^d$ dient als Terminierungssignal.
#block(fill: sand, stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.6em), radius: 3pt)[
  $delta(x, y) = cases(
    bold(d) & "falls " x in F,
    "COM"(x\, "AGG"(y)) & "sonst"
  )$

  Sobald $x_v^t in F$, bleibt der Knoten in $bold(d)$ — *Fixpunkt signalisiert Akzeptanz.*
]

// ── SLIDE: Floats vs. Reals ───────────────────────────────────────────────────
== GNN[F] vs. GNN[R] — Warum das wichtig ist

#v(0.2em)
In der Praxis verwenden GNNs *Gleitkommazahlen* ($FF$). Die Theorie nimmt meist *reelle Zahlen* ($RR$) an.

#v(0.3em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Das Gleitkommazahlenproblem:* Gleitkommazahlenaddition ist *nicht assoziativ*:
  $(a + b) + c eq.not a + (b + c)$

  In einem 2-Dezimalsystem: $1 + (-1) + 0.01 = 0.01$, aber $(1 + 0.01) + (-1) = 1.0 + (-1) = 0$\
  da $1.01$ nicht darstellbar ist und gerundet wird.
]

#v(0.3em)
*Folgerung* (Proposition 2.3): Für jedes Gleitkommazahlensystem $FF$ gibt es ein $k in NN$, sodass für alle Multimengen $M$ von Gleitkommazahlen gilt:
$
  "SUM"_FF (M) = "SUM"_FF (M|_k)
$
Nach $k$ Kopien eines Wertes machen weitere Kopien *keinen Unterschied* — Gleitkommazahlen können nicht über eine feste Grenze hinaus zählen.

#v(0.3em)
#block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.9em, y: 0.6em), radius: 3pt)[
  *Konvention:* Im Folgenden nehmen wir GNN[$FF$] stets als *bounded* im Sinne von Prop. 2.3 an. Genau diese Beschränkung macht GNN[$FF$] strikt schwächer als GNN[$RR$].
]

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 2.2 — Logiken  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
= Logiken

== Gradierte Modallogik (GML) #h(0.5em) #kevin

#v(0.2em)
GML ist Aussagenlogik, erweitert um *Zählmodalitäten*:
$
  phi ::= top mid p mid not phi mid phi and phi mid lozenge_(>= k) phi
$

Die Schlüsselformel $lozenge_(>= k) phi$ bedeutet: *„mindestens $k$ ausgehende Nachbarn erfüllen $phi$"*

#v(0.3em)
#example[
  Auf *Graphen:*
  - $lozenge_(>= 1) p$ — „es gibt einen Nachbarn mit Label $p$"
  - $lozenge_(>= 3) (q and lozenge_(>= 2) r)$ — „mindestens 3 Nachbarn haben $q$ und jeder hat ≥2 Nachbarn mit $r$"
]

#v(0.3em)
*Klassisches Ergebnis* @barcelo2020logical: Konstantiterations-GNNs $equiv$ GML (relativ zu FO-definierbaren Eigenschaften)

// ── SLIDE: GMSC ───────────────────────────────────────────────────────────────
== Gradierter Modaler Substitutionskalkül (GMSC)

GMSC erweitert GML um *rekursive Regeln* — ein Programm $Lambda$ besteht aus zwei Klauseltypen:

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *Terminalklausel* `X(0) :− φ`\
    $phi ::= top | p | not phi | phi and phi | lozenge_(>= k) phi$\
    #text(size: 0.82em, style: "italic")[Reine GML-Formel — keine Schema-Variablen]
  ],
  block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *Iterationsklausel* `X :− ψ`\
    $psi ::= top | p | X | not psi | psi and psi | lozenge_(>= k) psi$\
    #text(size: 0.82em, style: "italic")[Darf Schema-Variable $X$ rekursiv enthalten]
  ],
)

#v(0.25em)
Die $n$-te Entfaltung $X^n$: ersetze $X$ in $psi$ durch $X^(n-1)$, beginnend mit $X^0 = phi$.

Ein Programm $Lambda$ hat eine Menge $cal(A)$ von *appointed* Variablen.
$Lambda$ akzeptiert $(G, v)$, falls $G, v tack.r.double X^n$ für *ein* $n$ und *ein* $X in cal(A)$.

#pause
#v(0.3em)
#example[
  *Erreichbarkeit von $p$:* #h(1em) `X(0) :− p` #h(1.5em) `X :− ◇X` \
  $X^i = lozenge dots.c lozenge p$ (genau $i$ Rauten) = Erreichbarkeit in $i$ Schritten
]

// ── SLIDE: GMSC extended example ─────────────────────────────────────────────
== GMSC — Komplexeres Beispiel: Erreichbarkeit via $q$-Knoten #h(0.5em) #kevin

#v(0.2em)
*Eigenschaft:* Knoten $v$ erreicht $p$ über einen Pfad, auf dem *alle Zwischenknoten* Label $q$ tragen.

#v(0.25em)
#block(fill: sand, stroke: 0.4pt + luma(200), inset: (x: 0.9em, y: 0.7em), radius: 3pt)[
  ```
  Q(0) :− p           Q :− p ∨ (q ∧ ◇Q)
  ```
  ($Q$ appointed)
]

#v(0.25em)
*Entfaltung:*
- $Q^0 = p$ — wahr genau in $p$-Knoten
#pause
- $Q^1 = p or (q and lozenge Q^0) = p or (q and lozenge p)$ — $p$-Knoten oder $q$-Knoten mit $p$-Nachbar
#pause
- $Q^n$ = erreichbar von $v$ in $<= n$ Schritten über $q$-Knoten

$(G, v) in "GMSC"$ gdw. $G, v tack.r.double Q^n$ für *ein* $n$ — d.h. Pfad zu $p$ über $q$-Knoten *existiert*.

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *Eine Variable:* einfache Erreichbarkeit\
    `Q(0) :− p` #h(0.3em) `Q :− ◇Q`\
    $Q^n = lozenge^n p$ — Abstand ≤ $n$ zu $p$
  ],
  block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *Zwei Variablen:* günstige Erreichbarkeit\
    Zwei interagierende Klauseln können komplexe Pfadbedingungen ausdrücken, die GML allein nicht kann.
  ],
)

// ── SLIDE: ω-GML and hierarchy ────────────────────────────────────────────────
== ω-GML und die Logikhierarchie

ω-GML fügt *unendliche Disjunktionen* von GML-Formeln hinzu:
$
  phi ::= psi quad | quad limits(union.big)_(psi in Psi) psi
  quad (Psi "eine abzählbare Menge von GML-Formeln")
$

#pause
#v(0.3em)
Da GNN[R] mit reellen Zahlen *beliebig viele* Werte unterscheiden kann, benötigt es diese unendliche Ausdrucksstärke.

#v(0.4em)
*Ausdrucksstärke (semantische Inklusion, nicht syntaktisch):*
$
  "GML" quad subset.neq quad "GMSC" quad subset.neq quad omega"-GML"
$

#pause
#v(0.1em)
#remark[
  GMSC $not subset$ MSO: es gibt Eigenschaften in GMSC, die MSO nicht ausdrücken kann (→ nächste Folie). GMSC und $mu$-Kalkül sind *orthogonal* — keine enthält die andere.
]

#pause
#v(0.2em)
#example[
  *Auf Zeichenketten:*\
  FO $equiv$ sternfreie reguläre Sprachen #h(1em) MSO $equiv$ alle regulären Sprachen

  *Auf Graphen:*\
  FO: „jeder Knoten hat einen Nachbarn" #h(1em) MSO: „der Graph ist bipartit", „Pfad von $a$ nach $b$"
]

// ── Centre-Point tree diagram ─────────────────────────────────────────────────
#let centre-point-diagram = canvas(length: 0.85cm, {
  import draw: *
  let col-dead = luma(155)
  let col-x1   = rgb("#1a4f8a")
  let col-x2   = rgb("#1e6b3c")
  let col-edge = rgb("#7fa8cc")
  let r = 0.30

  let v  = (2.5, 3.6)
  let u1 = (1.0, 2.1)
  let u2 = (4.0, 2.1)
  let d1 = (0.0, 0.5)
  let d2 = (1.8, 0.5)
  let d3 = (3.2, 0.5)
  let d4 = (5.0, 0.5)

  let es = (stroke: (paint: col-edge, thickness: 1.0pt), mark: (end: ">", size: 0.20))
  line(v, u1, ..es); line(v, u2, ..es)
  line(u1, d1, ..es); line(u1, d2, ..es)
  line(u2, d3, ..es); line(u2, d4, ..es)

  for (pos, lbl) in ((d1, $d_1$), (d2, $d_2$), (d3, $d_3$), (d4, $d_4$)) {
    circle(pos, radius: r, fill: col-dead, stroke: none)
    content(pos, text(fill: white, size: 0.22cm, weight: "bold")[#lbl])
  }
  content((2.5, -0.15), text(size: 0.20cm, fill: col-dead, style: "italic")[$X^0 = square bot$ (Sackgassen)])

  circle(u1, radius: r, fill: col-x1, stroke: (paint: white, thickness: 1.2pt))
  content(u1, text(fill: white, size: 0.24cm, weight: "bold")[$u_1$])
  circle(u2, radius: r, fill: col-x1, stroke: (paint: white, thickness: 1.2pt))
  content(u2, text(fill: white, size: 0.24cm, weight: "bold")[$u_2$])
  content((-0.85, 2.1), text(size: 0.20cm, fill: col-x1)[$X^1$])

  circle(v, radius: r * 1.3, fill: col-x2, stroke: (paint: rgb("#7fcda0"), thickness: 2pt))
  content(v, text(fill: white, size: 0.28cm, weight: "bold")[$v$])
  content((4.2, 3.6), text(size: 0.20cm, fill: col-x2, weight: "bold")[$X^2$: ACCEPT])
})

// ── SLIDE: Centre-Point — GMSC ⊄ MSO ─────────────────────────────────────────
== Centre-Point — GMSC ausdrückbar, MSO nicht #h(0.5em) #kevin

#v(0.15em)
#definition([Centre-Point (Bsp. 2.5 @ahvonen2024logical)])[
  $(G, w)$ hat die *Centre-Point-Eigenschaft* gdw. es ein $n in NN$ gibt, sodass *jeder* gerichtete Pfad von $w$ nach genau $n$ Schritten in einer *Sackgasse* (Knoten ohne ausgehende Nachbarn) endet.
]

#pause
#v(0.25em)
#grid(columns: (1fr, auto), gutter: 1.2em, align: (left, center + horizon),
  [
    *GMSC-Programm* ($X$ appointed):
    #v(0.15em)
    #block(fill: sand, stroke: 0.4pt + luma(200), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
      ```
      X(0) :− □⊥       // Basisfall: Sackgassen
      X    :− ◇X ∧ □X  // Schritt rückwärts
      ```
    ]
    #v(0.15em)
    - $X^0 = square bot$ — wahr in Sackgassen ($square$ über leerem Nachbar-Set = wahr)
    #pause
    - $X^(n+1) = lozenge X^n and square X^n$ gilt in $v$ gdw. $v$ ≥1 Nachbar hat *und* alle Nachbarn $X^n$ erfüllen
    #pause
    - $X^n$ gilt in $v$ gdw. alle Pfade von $v$ haben Länge exakt $n$
  ],
  [#centre-point-diagram]
)

#pause
#v(0.2em)
#remark[
  Centre-Point $in$ GMSC $without$ MSO: MSO kann globale Tiefenuniformität nicht ausdrücken. Damit ist Satz 4.3 eine echte Einschränkung — der Kollaps gilt nur *innerhalb* von MSO.
]

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 3 — GNNs und Logiken über Automaten  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
= GNNs und Logiken über Automaten

== Verteilte Automaten — CMPA #h(0.5em) #tom

#definition([Zählender Nachrichtenweiterleitungsautomat (CMPA)])[
  Ein CMPA $(Q, q_0, delta, F)$ läuft auf Graphen:
  - Jeder Knoten startet im Zustand $q_0$
  - Jeder Knoten aktualisiert seinen Zustand basierend auf seinem *eigenen Zustand* und der *Multimenge* der Nachbarzustände:
    $q_v^t = delta(q_v^(t-1),, {{q_u^(t-1) | (v,u) in E}})$
  - Knoten $v$ *akzeptiert*, wenn $q_v^t in F$ für ein $t$

  *FCMPA* — endliche Zustandsmenge $Q$ #h(2em) *CMPA* — abzählbar unendliches $Q$
]

#v(0.3em)
CMPAs sind wie GNNs, aber mit *diskreten* Zuständen. Das macht sie einfacher mit Logik zu verbinden.

// ── SLIDE: CMPA as bridge ─────────────────────────────────────────────────────
== CMPAs als Brücke: Warum der Umweg? #h(0.5em) #tom

#v(0.3em)
Eine direkte Übersetzung GNN[$FF$] → GMSC ist technisch sehr schwer. Der Umweg über FCMPA macht den Beweis handhabbar:

#pause
#v(0.5em)
#align(center)[
  #block(fill: sand, inset: (x: 2em, y: 1.2em), radius: 5pt, stroke: 0.5pt + navy)[
    #grid(columns: (1fr, auto, 1fr), align: center + horizon, gutter: 0.8em,
      [],
      block(fill: sky, inset: (x: 1em, y: 0.6em), radius: 3pt,
            stroke: 1pt + blue)[#text(weight: "bold")[GMSC]],
      [],
    )
    #v(0.5em)
    #grid(columns: (1fr, auto, 1fr), align: center + horizon, gutter: 0.8em,
      block(fill: sky, inset: (x: 0.8em, y: 0.6em), radius: 3pt,
            stroke: 1pt + blue)[#text(weight: "bold")[GNN[$FF$]]],
      text(size: 1.2em, fill: luma(120))[↗ #h(0.3em) ↖],
      block(fill: sky, inset: (x: 0.8em, y: 0.6em), radius: 3pt,
            stroke: 1pt + blue)[#text(weight: "bold")[FCMPA]],
    )
    #v(0.3em)
    #text(size: 0.8em, fill: luma(100), style: "italic")[direkter Weg: schwer #h(3em) Umweg: machbar]
  ]
]

#pause
#v(0.4em)
- *GNN[$FF$] → FCMPA:* Gleitkommazahlen sind bounded (Prop. 2.3) → endlich viele unterscheidbare Zustände
#pause
- *FCMPA → GMSC:* Diskrete Zustände + endliche Zustandsmenge → direkte logische Kodierung der Übergänge
#pause
- *GMSC → GNN[$FF$]:* Rekursive Formeln simulierbar durch iterierende Gewichtsmatrizen

// ── SLIDE: The three-way correspondence ──────────────────────────────────────
== Die Dreifachkorrespondenz

#v(0.3em)
Die Schlüsselerkenntnis: GNNs, Automaten und Logiken bilden ein *enges Dreieck*:

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

#pause
#v(0.4em)
- GNN[$FF$] $<->$ FCMPA, da Gleitkommazahlen beschränktes Zählen haben (Prop.\ 2.3)
#pause
- GNN[$RR$] $<->$ CMPA, da reelle Zahlen jede Multimengen-Größe exakt unterscheiden können
#pause
- Beide Automatenklassen verbinden sich dann mit ihrer jeweiligen Logik

// ── SLIDE: Why GNN[R] > GNN[F] ───────────────────────────────────────────────
== Warum GNN[R] streng mächtiger ist

#v(0.2em)
*Das Zählargument* (unter der Bounded-Annahme aus Prop. 2.3):

#v(0.2em)
#block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  GNN[$RR$] kann ausdrücken: *„Die Anzahl der ausgehenden Nachbarn ist eine Primzahl."*

  Für jede $U subset.eq NN$ — sogar *unentscheidbare* — kann GNN[$RR$] prüfen, ob die Nachbaranzahl in $U$ liegt.
]

#v(0.3em)
#block(fill: rgb("#fff8e1"), stroke: (left: 3pt + amber), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Weil GNN[$FF$] bounded ist (Prop. 2.3):* Ab Schranke $k$ kann GNN[$FF$] Graphen mit $k$ gegenüber $k+1$ Nachbarn *nicht* unterscheiden — die Summe der Nachbar-Features stabilisiert sich.

  Daher kann GNN[$FF$] Primalität des Grades für beliebige Grade nicht ausdrücken.
]

#v(0.3em)
*Absolutes Ergebnis:* GNN[$FF$] $<$ GNN[$RR$]. \
Die Extrastärke der reellen Zahlen liegt in Eigenschaften, die in der Praxis niemand braucht — das überraschende Ergebnis aus Abschnitt 4.

// ── SLIDE: Main Theorems ──────────────────────────────────────────────────────
== Hauptsätze

#v(0.2em)
#theorem([GNN[F] ≡ GMSC — Satz 3.2 #h(0.3em) @ahvonen2024logical])[
  Das Folgende hat die *gleiche Ausdrucksstärke* — absolut, ohne Hintergrundlogik:
  $
    "GNN"[FF] quad equiv quad "R-simple AC-GNN"[FF] quad equiv quad "GMSC" quad equiv quad "FCMPA"
  $
]

#pause
#v(0.4em)
#theorem([GNN[R] ≡ ω-GML — Satz 3.4 #h(0.3em) @ahvonen2024logical])[
  $
    "GNN"[RR] quad equiv quad "CMPA" quad equiv quad omega"-GML"
  $
  ω-GML kann *unentscheidbare* Grapheigenschaften definieren — daher ist GNN[$RR$] sehr mächtig.
]

#pause
#v(0.2em)
#remark[
  *Bemerkenswert:* Das einfache R-simple-Modell (lineare Aggregation + ReLU\*) genügt bereits. GNN[F]s mit beliebig komplexerer Architektur lassen sich in äquivalente R-simple GNN[F]s übersetzen — das zeigt die theoretische Untergrenze für GNN-Architekturen.
]

#pause
#v(0.2em)
Beide Ergebnisse sind *absolut* — keine Relativierung gegenüber einer Hintergrundlogik erforderlich.

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 4 — GNNs über MSO-Eigenschaften  [Kevin]
// ══════════════════════════════════════════════════════════════════════════════
= GNNs über MSO-Eigenschaften

== Was ist MSO? #h(0.5em) #kevin

MSO (Monadische Logik zweiter Stufe) erweitert FO um *Mengenquantifizierung*:
- FO: Quantifizierung über *Elemente* ($exists x$, $forall x$)
#pause
- MSO: zusätzlich Quantifizierung über *Mengen von Elementen* ($exists X$, $forall X$)

#pause
#v(0.4em)
#grid(columns: (1fr, 1fr), gutter: 1em,
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *Auf Graphen:*\
    #v(0.2em)
    FO kann sagen:\
    „jeder Knoten hat einen Nachbarn"\
    #v(0.3em)
    MSO kann sagen:\
    „der Graph ist bipartit"\
    „es gibt einen Pfad von $a$ nach $b$"\
    viele globale Struktureigenschaften
  ],
  block(fill: sand, inset: 0.8em, radius: 3pt, stroke: 0.4pt + luma(200))[
    *Auf Zeichenketten:*\
    #v(0.2em)
    FO $equiv$ sternfreie reguläre Sprachen\
    #v(0.3em)
    MSO $equiv$ alle regulären Sprachen\
    #v(0.3em)
    (eine klare, bekannte Korrespondenz)
  ],
)

#v(0.3em)
MSO ist gewissermaßen die *natürliche* Logik für Graphen — sie erfasst nahezu alle Eigenschaften, die in der Praxis relevant sind.

// ── SLIDE: More MSO examples ──────────────────────────────────────────────────
== MSO — Was es ausdrücken kann

#v(0.2em)
MSO-ausdrückbare Grapheigenschaften umfassen:

#grid(columns: (1fr, 1fr), gutter: 0.8em,
  list(
    [Zusammenhang],
    [$k$-Färbbarkeit],
    [Hamiltonizität],
    [Bipartitheit],
  ),
  list(
    [Planarität (bei festem Geschlecht)],
    [Existenz eines Pfades zwischen zwei markierten Knoten],
    [Viele weitere natürliche Struktureigenschaften],
  ),
)

#pause
#v(0.3em)
#example[
  *Bipartitheit* als MSO-Formel — die Mengenquantifizierung $exists X$ wählt eine Knotenmenge (eine „Farbe"):
  $
    exists X. forall y. forall z. (E(y,z) -> (X(y) <-> not X(z)))
  $
  FO kann das *nicht* ausdrücken — FO quantifiziert nur über einzelne Elemente, nicht über Mengen.
]

#pause
#v(0.2em)
#remark[
  MSO ist *nicht* die Grenze dessen, was GNNs leisten können. Abschnitt 3 zeigte, dass GNN[$RR$] weit über MSO hinausgehen kann. Aber MSO deckt alles ab, was in der Praxis relevant ist.
]

// ── SLIDE: MSO — Theorem 4.1 and Proof Ingredients ───────────────────────────
== MSO — Satz 4.1 und Beweisbausteine #h(0.5em) #kevin

#v(0.15em)
#theorem([GNN[R] ≡ GMSC über MSO — Satz 4.1 @ahvonen2024logical])[
  Für jede MSO-ausdrückbare Eigenschaft $cal(P)$:
  $cal(P) in "GNN"[RR] arrow.l.r.double cal(P) in "GMSC"$\
  Kombiniert mit Satz 3.2: GNN[$FF$] $equiv$ GNN[$RR$] $equiv$ GMSC über allen MSO-Eigenschaften.
]

#pause
#v(0.3em)
*Beweisidee (Intuition):* GMSC/ω-GML sind bisimulationsinvariant — sie sehen nur Bäume. MSO auf Bäumen wird durch Paritätsbaumautomaten (PTAs) charakterisiert. Aus einem PTA baut man ein GMSC-Programm, das per Tiefenzertifikat prüft, ob der Baum akzeptiert wird.

#pause
#v(0.3em)
*Zwei Schlüsselbeweiszutaten:*

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *1. Janin-Walukiewicz (Satz 4.6):*\
    #v(0.1em)
    GMSC / ω-GML sind *modal* — invariant unter Baumaufrollen.
    Für $cal(P) in "MSO" inter omega"-GML"$ gibt es einen PTA $cal(A)$, sodass\
    $(G, w) in cal(P) arrow.l.r U(G,w) in L(cal(A))$
  ],
  block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *2. $k$-Präfixdekorationen (Lem. 4.7):*\
    #v(0.1em)
    Eine Tiefe-$k$-Abbildung $mu: V_k -> cal(P)(Q)$ von PTA-Zuständen — *endliches Zertifikat* für $T in L(cal(A))$.\
    $T in L(cal(A)) arrow.l.r exists k in NN: T "hat eine " k"-Präfixdek."$\
    *GMSC:* Runde $k$ überprüft das Tiefe-$k$-Zertifikat.
  ],
)

// ── SLIDE: The MSO Collapse Theorem ──────────────────────────────────────────
== Das MSO-Kollapstheorem

#v(0.2em)
#theorem([MSO-Kollaps — Satz 4.3 #h(0.3em) @ahvonen2024logical])[
  Für jede in MSO ausdrückbare Eigenschaft $cal(P)$:
  $
    cal(P) "ausdrückbar als GNN"[RR] quad arrow.l.r.double quad cal(P) "ausdrückbar als GNN"[FF]
  $
  Beide werden zusätzlich durch GMSC erfasst. Dies gilt auch für Konstantiterations-GNNs.
]

#pause
#v(0.4em)
#grid(columns: (1fr, 1fr), gutter: 1em,
  block(fill: rgb("#ffebee"), stroke: 1pt + rgb("#f44336"), inset: 0.8em, radius: 3pt)[
    *Absolut:* GNN[$RR$] $>$ GNN[$FF$]\
    #v(0.2em)
    Zusätzliche Stärke: „Grad ist Primzahl", unentscheidbare Eigenschaften.
  ],
  block(fill: mint, stroke: 1pt + sage, inset: 0.8em, radius: 3pt)[
    *Relativ zu MSO:* GNN[$RR$] $=$ GNN[$FF$]\
    #v(0.2em)
    Für alle praktisch relevanten Eigenschaften sind Gleitkommazahlen *genauso gut*.
  ],
)

// ── SLIDE: Intuition for the proof ───────────────────────────────────────────
== Warum der Unterschied verschwindet — Intuition

#v(0.2em)
Der Beweis geht über *Paritätsbaumautomaten (PTAs)* — die MSO auf baumstrukturierten Graphen charakterisieren (Janin–Walukiewicz-Theorem):

#v(0.3em)
#align(center)[
  #block(fill: sand, inset: (x: 1.5em, y: 0.8em), radius: 4pt, stroke: 0.5pt + navy)[
    MSO-Eigenschaft $cal(P)$ $arrow.r$ PTA $A$ $arrow.r$ $k$-Präfixdekorationen $arrow.r$ GMSC-Programm $Lambda$
  ]
]

#pause
#v(0.4em)
*Schlüsselerkenntnis:* Die zusätzliche Stärke von GNN[$RR$] liegt vollständig *außerhalb* von MSO. \
Wenn $cal(P)$ in MSO liegt und durch GNN[$RR$] ausdrückbar ist, lässt sich stets ein GMSC-Programm — und damit ein GNN[$FF$] — dafür finden.

#pause
#v(0.3em)
#block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Praktische Konsequenz:* Theoretische Analysen mit $RR$ sind sicher — für MSO-Eigenschaften übertragen sich die Ergebnisse auf Gleitkommazahlen. Falls ein GNN eine MSO-definierbare Eigenschaft nicht lernt, liegt das Problem im Training oder der Architektur, nicht in der Gleitkommazahlgenauigkeit.
]

// ══════════════════════════════════════════════════════════════════════════════
// FAZIT  [Kevin & Tom]
// ══════════════════════════════════════════════════════════════════════════════
= Zusammenfassung

== Ergebnisse im Überblick #h(0.5em) #kevin #h(0.2em) #tom

#v(0.4em)
#table(
  columns: (auto, 1fr, 1fr, 1fr),
  align: (left, center, center, center),
  stroke: none,
  fill: (_, row) => if row == 0 { navy } else if calc.odd(row) { rgb("#f0f4f9") } else { white },
  table.hline(stroke: 0.5pt + navy),
  [#text(fill: white, weight: "bold")[Kontext]],
  [#text(fill: white, weight: "bold")[GNN[F]]],
  [#text(fill: white, weight: "bold")[GNN[R]]],
  [#text(fill: white, weight: "bold")[Automat]],
  table.hline(stroke: 0.3pt + luma(200)),
  [Absolut],              [≡ GMSC],  [≡ ω-GML],     [F: FCMPA, R: CMPA],
  [Relativ zu MSO],       [≡ GMSC],  [≡ GMSC (!!)], [≡ FCMPA],
  table.hline(stroke: 0.5pt + navy),
)

#pause
#v(0.6em)
*Fazit:*
- Absolut: GNN[$FF$] $<$ GNN[$RR$] — reelle Zahlen können unentscheidbare Eigenschaften ausdrücken
#pause
- Relativ zu MSO: GNN[$FF$] $equiv$ GNN[$RR$] — *Theorie und Praxis konvergieren*

// ── SLIDE: Open Questions ─────────────────────────────────────────────────────
== Fazit & Offene Fragen

#v(0.2em)
*Was wir gezeigt haben:*
- Exakte logische Charakterisierungen: GNN[$FF$] $equiv$ GMSC, GNN[$RR$] $equiv$ ω-GML
#pause
- Beide Ergebnisse sind *absolut* — keine Hintergrundlogik erforderlich
#pause
- Der Reell-Gleitkomma-Unterschied *verschwindet* für alle MSO-definierbaren Eigenschaften
#pause
- Gleitkommazahlen verlieren gegenüber reellen Zahlen nichts für praktisch relevante Eigenschaften

#pause
#v(0.4em)
*Offene Fragen:*
- *Terminierung:* Wie lernt ein rekurrentes GNN *wann* es stoppen soll? Nicht behandelt.
#pause
- *Globales Auslesen:* Wie ändert sich die Charakterisierung durch eine globale Pooling-Schicht?
#pause
- *Komplexität:* Ist Ausdrückbarkeit in GMSC entscheidbar?
#pause
- *Aufmerksamkeitsarchitekturen:* Wo passen GAT / Transformer in diesen Rahmen?

#pause
#v(0.3em)
#block(fill: sand, stroke: (left: 3pt + navy), inset: (x: 0.9em, y: 0.65em), radius: 3pt)[
  *Verwandte Arbeit:* Pflüger et al. (NeurIPS 2024) @pfluger2024graded — ähnliche Fragestellung, aber andere Terminierungsbedingung. Ergebnis: gradierter $mu$-Kalkül. Die Ansätze sind *orthogonal* — keine enthält die andere.
]

// ══════════════════════════════════════════════════════════════════════════════
// Referenzen
// ══════════════════════════════════════════════════════════════════════════════
= Referenzen

== Referenzen

#set text(size: 14pt)
#bibliography("refs.bib", style: "ieee", title: none)
