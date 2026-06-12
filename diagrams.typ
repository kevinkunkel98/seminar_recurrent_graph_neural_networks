#import "@preview/cetz:0.3.4": canvas, draw
#import "helpers.typ": navy

// ── ReLU* (truncated ReLU) diagram ───────────────────────────────────────────
#let relu-star-diagram = canvas(length: 1cm, {
  import draw: *
  let col-ax  = luma(100)
  let col-fn  = rgb("#1a4f8a")
  let col-hi  = rgb("#1e6b3c")

  line((-0.8, 0), (3.2, 0), stroke: (paint: col-ax, thickness: 0.8pt),
       mark: (end: ">", size: 0.18))
  line((0, -0.5), (0, 2.0), stroke: (paint: col-ax, thickness: 0.8pt),
       mark: (end: ">", size: 0.18))

  content((3.35, 0),   text(size: 0.28cm, fill: col-ax)[$x$])
  content((0.15, 2.1), text(size: 0.28cm, fill: col-ax)[$y$])

  line((1.5, -0.08), (1.5, 0.08), stroke: (paint: col-ax, thickness: 0.6pt))
  content((1.5, -0.30), text(size: 0.25cm, fill: col-ax)[$1$])
  line((-0.08, 1.5), (0.08, 1.5), stroke: (paint: col-ax, thickness: 0.6pt))
  content((-0.28, 1.5), text(size: 0.25cm, fill: col-ax)[$1$])

  line((1.5, 0), (1.5, 1.5),
       stroke: (paint: luma(200), thickness: 0.6pt, dash: "dashed"))
  line((0, 1.5), (1.5, 1.5),
       stroke: (paint: luma(200), thickness: 0.6pt, dash: "dashed"))

  line((-0.8, 0),   (0,   0),   stroke: (paint: col-fn, thickness: 2.2pt))
  line((0,    0),   (1.5, 1.5), stroke: (paint: col-fn, thickness: 2.2pt))
  line((1.5,  1.5), (3.0, 1.5), stroke: (paint: col-hi, thickness: 2.2pt))

  circle((0,   0),   radius: 0.07, fill: col-fn, stroke: none)
  circle((1.5, 1.5), radius: 0.07, fill: col-hi, stroke: none)

  content((2.5, 1.85), text(size: 0.30cm, fill: col-fn, weight: "bold")[ReLU\*])
  content((2.5, 0.85), text(size: 0.24cm, fill: luma(90), style: "italic")[\= min(1, max(0, x))])
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

  circle((-0.3, 0.6), radius: 0.30, fill: col-n, stroke: none)
  circle(( 0.3, 0.6), radius: 0.30, fill: col-n, stroke: none)
  line((-0.3, 0.6), (0.3, 0.6), stroke: (paint: col-e, thickness: 0.7pt))
  content((0, -0.1), text(size: 0.25cm, fill: luma(80))[$t=0$])

  line((0.6, 0.3), (1.5, 0.3),
       stroke: (paint: luma(180), thickness: 0.7pt),
       mark: (end: ">", size: 0.16))

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

// ── Large GNN message-passing diagram ────────────────────────────────────────
#let gnn-big-diagram = canvas(length: 1.1cm, {
  import draw: *
  let col-ctr  = rgb("#1c3a5e")
  let col-inn  = rgb("#1a4f8a")
  let col-out  = rgb("#5b87b3")
  let col-eedg = rgb("#7fa8cc")
  let col-oedg = rgb("#aecbe0")

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

  let oe = (stroke: (paint: col-oedg, thickness: 0.9pt))
  line(w1, u1, ..oe); line(w2, u1, ..oe)
  line(w3, u2, ..oe); line(w4, u2, ..oe)
  line(w5, u3, ..oe); line(w6, u3, ..oe)

  let ie = (stroke: (paint: col-eedg, thickness: 2.5pt), mark: (end: ">", size: 0.36))
  line(u1, v, ..ie); line(u2, v, ..ie); line(u3, v, ..ie)

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

  circle(u1, radius: 0.58, fill: col-inn, stroke: (paint: white, thickness: 1.8pt))
  content(u1, text(fill: white, size: 0.40cm, weight: "bold")[$u_1$])

  circle(u2, radius: 0.58, fill: col-inn, stroke: (paint: white, thickness: 1.8pt))
  content(u2, text(fill: white, size: 0.40cm, weight: "bold")[$u_2$])

  circle(u3, radius: 0.58, fill: col-inn, stroke: (paint: white, thickness: 1.8pt))
  content(u3, text(fill: white, size: 0.40cm, weight: "bold")[$u_3$])

  circle(v, radius: 0.85, fill: col-ctr, stroke: (paint: white, thickness: 2.8pt))
  content(v, text(fill: white, size: 0.58cm, weight: "bold")[$v$])

  content((3.5, -1.7), text(size: 0.5cm, fill: col-ctr)[
    $bold(v) <- "COM"lr((bold(v),  "AGG"({{bold(u_1), bold(u_2), bold(u_3)}})))$
  ])
})

#let reachability-example = canvas(length: 1.1cm, {
  import draw: *

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

  let oe = (stroke: (thickness: 0.9pt))
  line(w1, u1, ..oe); line(w2, u1, ..oe)
  line(w3, u2, ..oe); line(w4, u2, ..oe)
  line(w5, u3, ..oe); line(w6, u3, ..oe)

  let ie = (stroke: (thickness: 2.5pt), mark: (end: ">", size: 0.36))
  line(u1, v, ..ie); line(u2, v, ..ie); line(u3, v, ..ie)

  circle(w1, radius: 0.34, fill: white, stroke: black)
  content(w1, text(fill: black, size: 0.4cm, weight: "bold")[☕])
  circle(w2, radius: 0.34, fill: white, stroke: black)
  content(w2, text(fill: white, size: 0.24cm, weight: "bold")[$w_2$])
  circle(w3, radius: 0.34, fill: white, stroke: black)
  content(w3, text(fill: white, size: 0.24cm, weight: "bold")[$w_3$])
  circle(w4, radius: 0.34, fill: white, stroke: black)
  content(w4, text(fill: white, size: 0.24cm, weight: "bold")[$w_4$])
  circle(w5, radius: 0.34, fill: white, stroke: black)
  content(w5, text(fill: white, size: 0.24cm, weight: "bold")[$w_5$])
  circle(w6, radius: 0.34, fill: white, stroke: black)
  content(w6, text(fill: black, size: 0.4cm, weight: "bold")[☕])

  circle(u1, radius: 0.58, fill: white, stroke: (paint: black, thickness: 1.8pt))
  content(u1, text(fill: white, size: 0.40cm, weight: "bold")[$u_1$])

  circle(u2, radius: 0.58, fill: white, stroke: (paint: black, thickness: 1.8pt))
  content(u2, text(fill: white, size: 0.40cm, weight: "bold")[$u_2$])

  circle(u3, radius: 0.58, fill: white, stroke: (paint: black, thickness: 1.8pt))
  content(u3, text(fill: white, size: 0.40cm, weight: "bold")[$u_3$])

  circle(v, radius: 0.85, fill: white, stroke: (paint: black, thickness: 2.8pt))
  content(v, text(fill: black, size: 0.58cm, weight: "bold")[$v$])
  circle(v, radius: 1.1, fill: none,
         stroke: (paint: rgb(210, 200, 255), thickness: 2.8pt, dash: "dashed")
  )
})

// ── Large RGNN reachability diagram ──────────────────────────────────────────
#let rgnn-big-diagram = canvas(length: 1.1cm, {
  import draw: *
  let col-0   = rgb("#1a4f8a")
  let col-1   = rgb("#1e6b3c")
  let col-e0  = rgb("#7fa8cc")
  let col-e1  = rgb("#5bb87a")
  let rv = 0.40; let ru = 0.32
  let ny = 1.1

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
