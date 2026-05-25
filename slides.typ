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
    $bold(x)_v^((t)) = "COM"(bold(x)_v^((t-1)),,"AGG"({bold(x)_u^((t-1))}_u))$
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

// ── SLIDE: GNN Visualization ──────────────────────────────────────────────────
== GNN — Message Passing Visualization #h(0.5em) #tom

#align(center + horizon)[
  #gnn-big-diagram
]

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

// ── SLIDE: RGNN Visualization ─────────────────────────────────────────────────
== Recurrent GNN — Computation Visualization #h(0.5em) #tom

#align(center + horizon)[
  #rgnn-big-diagram
  #v(0.5em)
  #text(size: 0.82em, fill: luma(90), style: "italic")[
    Example: Reachability of label $p$ — state $1$ = "$p$ is reachable from this node" — GNN accepts when $v$ reaches state $1$
  ]
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

// ── SLIDE: MSO — Theorem 4.1 and Proof Ingredients ───────────────────────────
== MSO — Theorem 4.1 and Proof Ingredients #h(0.5em) #kevin

#v(0.15em)
#theorem([GNN[R] ≡ GMSC over MSO — Thm. 4.1 @ahvonen2024logical])[
  For any MSO-expressible $cal(P)$:
  $cal(P) in "GNN"[RR] arrow.l.r.double cal(P) in "GMSC"$\
  Combined with Thm. 3.2: GNN[$FF$] $equiv$ GNN[$RR$] $equiv$ GMSC over all MSO properties.
]

#v(0.3em)
*Two key proof ingredients:*

#v(0.2em)
#grid(columns: (1fr, 1fr), gutter: 0.8em,
  block(fill: sky, stroke: (left: 3pt + blue), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *1. Janin-Walukiewicz (Thm. 4.6):*\
    #v(0.1em)
    GMSC / ω-GML are *modal* — invariant under tree unraveling.
    For $cal(P) in "MSO" inter omega"-GML"$, there is a PTA $cal(A)$ s.t.\
    $(G, w) in cal(P) arrow.l.r U(G,w) in L(cal(A))$
  ],
  block(fill: mint, stroke: (left: 3pt + sage), inset: (x: 0.8em, y: 0.6em), radius: 3pt)[
    *2. $k$-prefix decorations (Lem. 4.7):*\
    #v(0.1em)
    A depth-$k$ map $mu: V_k -> cal(P)(Q)$ of PTA states — *finite certificate* for $T in L(cal(A))$.\
    $T in L(cal(A)) arrow.l.r exists k in NN: T "has a " k"-prefix dec."$\
    *GMSC:* round $k$ checks the depth-$k$ certificate.
  ],
)

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
