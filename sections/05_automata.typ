#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ABSCHNITT 3 — GNNs und Logiken über Automaten  [Tom]
// ══════════════════════════════════════════════════════════════════════════════
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

// ── SLIDE: The three-way correspondence ──────────────────────────────────────
== Die Dreifachkorrespondenz #h(0.5em) #tom

#v(0.2em)
GNNs, Automaten und Logiken bilden ein *enges Dreieck*. Warum der Umweg über CMPAs? Direktübersetzung GNN[$FF$] → GMSC ist technisch schwer — CMPAs machen es handhabbar:

#v(0.15em)
#block(fill: sand, stroke: (left: 3pt + amber), inset: (x: 0.8em, y: 0.5em), radius: 3pt)[
  GNN[$FF$] bounded (Prop. 2.3) → endlich viele Zustände → FCMPA → direkte logische Kodierung → GMSC
]

#v(0.3em)
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

#v(0.3em)
- GNN[$FF$] $<->$ FCMPA — Floats sind bounded → endliche Zustandsmenge
- GNN[$RR$] $<->$ CMPA — reelle Zahlen unterscheiden jede Nachbaranzahl exakt

// ── SLIDE: Main Theorems ──────────────────────────────────────────────────────
== Hauptsätze

#v(0.2em)
#theorem([GNN[F] ≡ GMSC — Satz 3.2 #h(0.3em) @ahvonen2024logical])[
  Das Folgende hat die *gleiche Ausdrucksstärke* — absolut, ohne Hintergrundlogik:
  $
    "GNN"[FF] quad equiv quad "R-simple AC-GNN"[FF] quad equiv quad "GMSC" quad equiv quad "FCMPA"
  $
]


#v(0.4em)
#theorem([GNN[R] ≡ ω-GML — Satz 3.4 #h(0.3em) @ahvonen2024logical])[
  $
    "GNN"[RR] quad equiv quad "CMPA" quad equiv quad omega"-GML"
  $
  ω-GML kann *unentscheidbare* Grapheigenschaften definieren — daher ist GNN[$RR$] sehr mächtig.
]


#v(0.3em)
#grid(columns: (1fr, 1fr), gutter: 0.8em,
  block(fill: rgb("#ffebee"), stroke: 1pt + rgb("#f44336"), inset: 0.8em, radius: 3pt)[
    *Absolut:* GNN[$RR$] $>$ GNN[$FF$]\
    #v(0.15em)
    Beispiel: „Grad ist Primzahl" — GNN[$RR$] kann das, GNN[$FF$] nicht (bounded, Prop. 2.3).
  ],
  block(fill: mint, stroke: 1pt + sage, inset: 0.8em, radius: 3pt)[
    *Relativ zu MSO:* GNN[$RR$] $=$ GNN[$FF$]\
    #v(0.15em)
    Für alle praktisch relevanten Eigenschaften: Floats sind genauso gut. → Satz 4.3
  ],
)

#v(0.2em)
#remark[
  Das einfache R-simple-Modell (lineare Aggregation + ReLU\*) genügt — beliebig komplexere GNN[F]-Architekturen lassen sich äquivalent übersetzen.
]
