#import "../helpers.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// SLIDE — Gliederung
// ══════════════════════════════════════════════════════════════════════════════
== Gliederung

#v(0.3em)
#grid(
  columns: (auto, 1fr, auto),
  gutter: 0.6em,
  row-gutter: 0.5em,
  align: (right, left, left),
  [#tom#h(0.3em)#kevin], [*1 — Einführung*], [],
  [], [], [],
  tom, [*2.1 — Graph Neural Networks*], [~5 Min.],
  [], [Nachrichtenweiterleitung, Rekurrenz, GNN[F] vs.\ GNN[R]], [],
  kevin, [*2.2 — Logiken*], [~5 Min.],
  [], [GML, GMSC, ω-GML und ihre Hierarchie], [],
  tom, [*3 — Verbindung von GNNs und Logiken über Automaten*], [~20 Min.],
  [], [Verteilte Automaten, Hauptsätze, GNN[F] vs.\ GNN[R] — warum mächtiger?], [],
  kevin, [*4 — Charakterisierung über MSO-Eigenschaften*], [~20 Min.],
  [], [Was ist MSO? Warum fallen GNN[F] und GNN[R] zusammen?], [],
  [#tom#h(0.3em)#kevin], [*Fazit + Diskussion*], [~10 Min.],
)

