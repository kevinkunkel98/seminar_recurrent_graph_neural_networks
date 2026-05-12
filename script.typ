#set document(
  title: "Rekurrente GNNs – Seminar Notizen",
  author: "Seminar Graph Neural Networks"
)

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  numbering: "1",
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "de",
)

#set heading(numbering: "1.")

#set par(
  justify: true,
  leading: 0.8em,
)

#show heading.where(level: 1): it => {
  v(1.2em)
  block(
    fill: rgb("#1a1a2e"),
    inset: (x: 12pt, y: 8pt),
    radius: 4pt,
    width: 100%,
    text(fill: white, weight: "bold", size: 14pt, it.body)
  )
  v(0.6em)
}

#show heading.where(level: 2): it => {
  v(0.8em)
  text(fill: rgb("#16213e"), weight: "bold", size: 12pt, it.body)
  v(0.3em)
  line(length: 100%, stroke: 0.5pt + rgb("#16213e"))
  v(0.4em)
}

#show heading.where(level: 3): it => {
  v(0.5em)
  text(fill: rgb("#0f3460"), weight: "bold", size: 11pt, "▸ "); it.body
  v(0.2em)
}

// Callout boxes
#let info-box(title: "", body) = block(
  fill: rgb("#e8f4fd"),
  stroke: (left: 4pt + rgb("#2196F3")),
  inset: (x: 14pt, y: 10pt),
  radius: (right: 4pt),
  width: 100%,
)[
  #if title != "" { text(weight: "bold", fill: rgb("#1565C0"), title + "\n") }
  #body
]

#let key-box(body) = block(
  fill: rgb("#f3e5f5"),
  stroke: (left: 4pt + rgb("#9C27B0")),
  inset: (x: 14pt, y: 10pt),
  radius: (right: 4pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#6A1B9A"), "💡 Kernaussage\n")
  #body
]

#let warning-box(body) = block(
  fill: rgb("#fff8e1"),
  stroke: (left: 4pt + rgb("#FF9800")),
  inset: (x: 14pt, y: 10pt),
  radius: (right: 4pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#E65100"), "⚠ Achtung\n")
  #body
]

#let theorem-box(title: "Theorem", body) = block(
  fill: rgb("#e8f5e9"),
  stroke: (left: 4pt + rgb("#4CAF50")),
  inset: (x: 14pt, y: 10pt),
  radius: (right: 4pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1B5E20"), title + "\n")
  #body
]

// Title Page
#align(center)[
  #v(3cm)
  #block(
    fill: rgb("#1a1a2e"),
    inset: (x: 30pt, y: 20pt),
    radius: 8pt,
    width: 90%,
  )[
    #text(fill: white, size: 22pt, weight: "bold")[
      Rekurrente Graph Neural Networks
    ]
    #v(0.4em)
    #text(fill: rgb("#a0aec0"), size: 13pt)[
      Logische Charakterisierungen mit Reellen Zahlen und Floats
    ]
  ]
  #v(1cm)
  #text(size: 12pt, fill: rgb("#4a5568"))[
    Ahvonen, Heiman, Kuusisto, Lutz · NeurIPS 2024
  ]
  #v(0.3cm)
  #text(size: 11pt, fill: rgb("#718096"))[
    Seminar "Graph Neural Networks" · Universität Leipzig · Carsten Lutz
  ]
  #v(3cm)
  #line(length: 60%, stroke: 0.5pt + rgb("#cbd5e0"))
  #v(0.5cm)
  #text(size: 10pt, fill: rgb("#718096"))[
    Persönliche Seminar-Notizen
  ]
]

#pagebreak()

// Table of Contents
#outline(
  title: "Inhaltsverzeichnis",
  depth: 2,
  indent: 1.5em,
)

#pagebreak()

// ============================================================
= Die zentrale Frage
// ============================================================

#info-box(title: "Einstiegsfrage für den Vortrag")[
  _"Ihr trainiert einen GNN wochenlang und er lernt die Eigenschaft nicht. Liegt es am Training — oder ist es prinzipiell unmöglich für dieses Modell?"_
]

Das ist keine rhetorische Frage. In der Praxis weiß man das oft nicht. Und genau das ist das Problem, das dieses Paper löst.

**Was das Paper tut:** Es charakterisiert exakt, was rekurrente GNNs ausdrücken können — und was nicht. Die Antwort kommt in Form von Logiken, weil Logik das präziseste Werkzeug ist um Ausdrucksstärke zu messen.

**GNNs sind hier nicht das Ziel, sondern das Objekt der Untersuchung.** Das Paper fragt nicht "wie trainiere ich einen guten GNN?" sondern "was ist die fundamentale Ausdrucksstärke von rekurrenten GNNs?".

#key-box[
  Wenn GNN ≡ Logik, dann weiß ich exakt was der GNN kann und was nicht. GNNs sind das *Was*, Logik ist das *Womit man es misst*.
]

== Warum wollen wir das wissen?

- **Debugging:** Wenn ein GNN eine Eigenschaft nicht lernt — liegt es am Training oder ist es prinzipiell ausgeschlossen? Ohne Theorie weiß man das nicht.
- **Modellwahl:** Die Theorie sagt dir welches GNN-Modell du überhaupt wählen sollst. Brauchst du rekurrente Iteration? Reichen Floats?
- **Effizienz:** Wenn du weißt dass dein Modell eine Eigenschaft prinzipiell nicht ausdrücken kann, verschwendest du keine Zeit mit Training.

== Die drei Erkenntnisse des Papers

#grid(
  columns: (1fr, 2fr),
  gutter: 12pt,
  block(fill: rgb("#e3f2fd"), inset: 10pt, radius: 4pt)[*Erwartet*],
  [GNN[R] ist mächtiger als GNN[F]. Reelle Zahlen können mehr als Floats.],
  block(fill: rgb("#e8f5e9"), inset: 10pt, radius: 4pt)[*Interessant*],
  [Man kann beiden GNN-Typen exakt eine Logik zuordnen: GNN[F] ↔ GMSC, GNN[R] ↔ ω-GML],
  block(fill: rgb("#f3e5f5"), inset: 10pt, radius: 4pt)[*Überraschend*],
  [Relativ zu MSO verschwinden alle Unterschiede zwischen GNN[R] und GNN[F] komplett.],
)

#pagebreak()

// ============================================================
= GNN Grundlagen
// ============================================================

== Was ist ein GNN?

Ein GNN läuft auf einem Graphen. Jeder Knoten hat einen **Feature-Vektor** — eine Liste von Zahlen die seinen aktuellen Zustand beschreibt.

In jeder Runde passiert folgendes für jeden Knoten $v$:

+ **AGGREGATE:** Sammle die Feature-Vektoren aller Nachbarn von $v$ → ergibt ein Multiset
+ **COMBINE:** Kombiniere deinen eigenen Vektor mit dem aggregierten Nachbar-Vektor → neuer Feature-Vektor

Formal:

$ x_v^t = "COM"(x_v^(t-1),\ "AGG"({ x_u^(t-1) | (v,u) in E })) $

Das wird Runde für Runde wiederholt. Am Ende schaut man ob der Knoten in einem "accepting" Zustand ist.

== Normaler vs. Rekurrenter GNN

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  block(
    stroke: 1pt + rgb("#2196F3"),
    inset: 12pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1565C0"))[Normaler GNN]\
    \
    - Läuft genau *N Runden* (N fest vorgegeben)
    - N ist ein Hyperparameter
    - Nach N Runden: accepting oder nicht?
    - Problem: N muss man im Voraus wissen
  ],
  block(
    stroke: 1pt + rgb("#4CAF50"),
    inset: 12pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1B5E20"))[Rekurrenter GNN (RGNN)]\
    \
    - Kein festes N
    - Läuft bis ein Knoten einen *accepting feature vector* erreicht
    - Der GNN entscheidet selbst wann er fertig ist
    - Terminierungsbedingung: $x_v^t in F$ für irgendein $t$
  ],
)

=== Formale Definition

Ein rekurrenter GNN[R] über $(Pi, d)$ ist ein Tupel $cal(G) = (RR^d, pi, delta, F)$ wobei:
- $pi: cal(P)(Pi) -> RR^d$ die Initialisierungsfunktion ist
- $delta: RR^d times cal(M)(RR^d) -> RR^d$ die Übergangsfunktion
- $F subset.eq RR^d$ die Menge der accepting feature vectors

Der RGNN *akzeptiert* $(G, v)$ wenn $x_v^t in F$ für *irgendein* $t in NN$.

=== Konkretes Beispiel: Erreichbarkeit

Erreichbarkeit von Label $p$: "Gibt es einen Weg von $v$ zu einem Knoten mit $p$?"

#info-box[
  R-simple RGNN über $(Pi, 1)$ mit $C = A = 1$, $b = 0$:
  - *Runde 0:* Zustand von $w$ ist 1 wenn $p in lambda(w)$, sonst 0
  - *Runde t:* Zustand ist 1 wenn $w$ selbst 1 hat ODER ein Nachbar 1 hat
  - Das propagiert durch den ganzen Graphen — egal wie groß er ist!
]

GMSC-Programm dafür: `X(0) :− p` und `X :− ◇X`

#pagebreak()

// ============================================================
= GNN[R] vs. GNN[F]
// ============================================================

== Der Unterschied auf einen Blick

#table(
  columns: (auto, 1fr, 1fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#1a1a2e") } else if calc.odd(row) { rgb("#f7fafc") } else { white },
  inset: 10pt,
  [#text(fill: white, weight: "bold")[Merkmal]],
  [#text(fill: white, weight: "bold")[GNN[R]]],
  [#text(fill: white, weight: "bold")[GNN[F]]],
  [Zahlen], [Echte reelle Zahlen $RR$], [Floating-Point (wie Computer)],
  [Präzision], [Beliebig genau], [Begrenzt, gerundet],
  [Aggregation], [Unbeschränkt], [Bounded (ab Bound $k$ egal)],
  [Ausdrucksstärke], [Stärker], [Schwächer],
  [Praxis-relevanz], [Theoretisch], [Praktisch (echter Code)],
)

== Das Float-Problem: Warum Reihenfolge wichtig ist

Floating-Point Addition ist **nicht assoziativ**:
$ (a + b) + c eq.not a + (b + c) $

#warning-box[
  Konkretes Beispiel aus dem Paper (Zahlensystem mit 2 Dezimalstellen, Basis 10):

  $ 1 + (-1) + 0.01 = 0 + 0.01 = 0.01 $

  Aber:

  $ (1 + 0.01) + (-1) = 1.0 + (-1) = 0 $

  weil $1.01$ in diesem System nicht darstellbar ist und gerundet wird!
]

Das bedeutet: Ein GNN[F] der Nachbarn summiert bekommt **unterschiedliche Ergebnisse je nach Reihenfolge der Summation** — das verletzt Isomorphie-Invarianz.

=== Die Lösung: Aufsteigende Sortierung

Um Isomorphie-Invarianz zu retten sortiert man Floats vor der Summation (aufsteigend). Das ist in der Praxis üblich und genau definiert.

**Aber:** Dadurch entsteht Proposition 2.3:

#theorem-box(title: "Proposition 2.3")[
  Für jedes Floating-Point System $S$ gibt es ein $k in NN$ sodass für alle Multisets $M$ über Floats in $S$ gilt:
  $ "SUM"_S (M) = "SUM"_S (M|_k) $

  Das heißt: Ab $k$ Kopien eines Wertes macht eine weitere Kopie keinen Unterschied mehr.
]

**Konsequenz:** GNN[F] kann nicht beliebig genau zählen. Ab Bound $k$ verliert er die Information.

== Warum GNN[R] absolut stärker ist

#info-box[
  Ein GNN[R] kann ausdrücken: *"Die Anzahl der direkten Nachbarn ist eine Primzahl."*

  Für jeden beliebigen Test $U subset.eq NN$ — egal wie kompliziert, sogar *unentscheidbar* — kann ein GNN[R] prüfen ob die Nachbarzahl in $U$ liegt.

  Ein GNN[F] mit Bound $k$ kann Graphen mit $k$ und $k+1$ Nachbarn nicht unterscheiden.
]

#key-box[
  *Absolut gilt: GNN[F] < GNN[R]*

  Die Extramacht liegt aber in einem Bereich den man in der Praxis nie braucht — das ist das überraschende Resultat am Ende.
]

#pagebreak()

// ============================================================
= Logische Charakterisierungen
// ============================================================

== Warum Logik?

Logik ist das präziseste Werkzeug für Ausdrucksstärke:
- Wenn GNN ≡ Logik → ich weiß exakt was der GNN kann
- Ich kann Logik-Beweise nutzen um über GNNs nachzudenken
- Ich kann entscheiden ob eine Eigenschaft ausdrückbar ist oder nicht

== Graded Modal Logic (GML)

GML ist eine Modallogik die *zählen* kann. Syntax:
$ phi ::= top | p | not phi | phi and phi | lozenge_(>= k) phi $

Die zentrale Formel $lozenge_(>= k) phi$ bedeutet:
#info-box[
  "Mindestens $k$ Nachbarn erfüllen $phi$"
]

*Beispiele:*
- $lozenge_(>= 3) p$ = "Dieser Knoten hat mindestens 3 Nachbarn mit Eigenschaft $p$"
- $lozenge_(>= 1) (p and lozenge_(>= 2) q)$ = "Es gibt einen Nachbar mit $p$ der selbst ≥2 Nachbarn mit $q$ hat"

GML ist eine Erweiterung normaler Modallogik um dieses Zählen.

== Graded Modal Substitution Calculus (GMSC)

GMSC erweitert GML um **rekursive Regeln**. Ein GMSC-Programm:

#block(
  fill: rgb("#f8f9fa"),
  stroke: 1pt + rgb("#e2e8f0"),
  inset: 14pt,
  radius: 4pt,
)[
  ```
  X(0) :− φ        // Terminierungsklausel: Startzustand von X
  X    :− ψ        // Iterationsklausel: Update-Regel für X
  ```
  wobei $phi$ eine GML-Formel ist und $psi$ ein Schema das $X$ enthalten kann (Rekursion!).
]

Die $n$-te Iterationsformel $X^n$ von $X$ ist definiert als:
- $X^0 = phi$ (Terminierungsklausel)
- $X^(n+1) = psi$ wobei jedes $X$ in $psi$ durch $X^n$ ersetzt wird

GMSC akzeptiert $(G, v)$ wenn $G, v tack.r.double X^n$ für *irgendein* $n in NN$.

=== Beispiele für GMSC-Programme

*Erreichbarkeit von $p$:*
#block(fill: rgb("#f8f9fa"), stroke: 1pt + rgb("#e2e8f0"), inset: 12pt, radius: 4pt)[
  `X(0) :− p` #h(2em) `X :− ◇X`

  $X^i = lozenge dots.c lozenge p$ (genau $i$ Diamonds) = Erreichbarkeit in $i$ Schritten
]

*Zentrumspunkt-Eigenschaft* (nicht in MSO ausdrückbar!):
#block(fill: rgb("#f8f9fa"), stroke: 1pt + rgb("#e2e8f0"), inset: 12pt, radius: 4pt)[
  `X(0) :− ⊥` #h(2em) `X :− ◇X ∧ □X`

  "Es gibt ein $n$ sodass jeder gerichtete Pfad von $w$ in genau $n$ Schritten zu einem Knoten ohne Nachfolger führt."
]

== ω-GML (für GNN[R])

ω-GML ist einfacher zu erklären:
$ phi ::= psi | limits(union.big)_(psi in Psi) psi $

Es sind GML-Formeln plus **unendliche Disjunktionen** von GML-Formeln. Da GNN[R] mit reellen Zahlen beliebig viel unterscheiden kann, braucht man diese unendliche Ausdrucksstärke.

#info-box[
  *Proposition 2.6:* GMSC ist in ω-GML ausdrückbar, aber nicht umgekehrt.

  GMSC-Programme terminieren immer (zyklisches Wiederholen). ω-GML kann unentscheidbare Eigenschaften ausdrücken.
]

== Die zwei Haupttheoreme

#theorem-box(title: "Theorem 3.2 — GNN[F] ≡ GMSC")[
  Die folgenden drei haben dieselbe Ausdrucksstärke:
  - GNN[F]s
  - GMSC
  - R-simple aggregate-combine GNN[F]s

  *Absolut* — ohne Einschränkung auf eine Hintergrundlogik.
]

#v(0.5em)

#theorem-box(title: "Theorem 3.4 — GNN[R] ≡ ω-GML")[
  GNN[R]s haben dieselbe Ausdrucksstärke wie ω-GML.

  *Absolut.* Da ω-GML unentscheidbare Eigenschaften ausdrücken kann, ist GNN[R] sehr mächtig — aber jetzt wissen wir exakt wie mächtig.
]

== Die Brücke: Distributed Automata (CMPAs)

Die Beweise gehen über eine Zwischenstufe: **Counting Message Passing Automata (CMPAs)**. Das sind verteilte Automaten die wie GNNs funktionieren — jeder Knoten updatet seinen Zustand basierend auf dem Multiset der Nachbar-Zustände.

#align(center)[
  #block(fill: rgb("#f8f9fa"), stroke: 1pt + rgb("#e2e8f0"), inset: 14pt, radius: 4pt)[
    GNN[F] $<->$ bounded FCMPA $<->$ GMSC \
    GNN[R] $<->$ CMPA $<->$ ω-GML
  ]
]

#pagebreak()

// ============================================================
= MSO und das Überraschungsresultat
// ============================================================

== Was ist MSO?

MSO = Monadic Second-Order Logic. Erweiterung von First-Order Logic:
- FO: Quantifizierung über einzelne Elemente ($exists x$, $forall x$)
- MSO: zusätzlich Quantifizierung über *Mengen* von Elementen ($exists X$, $forall X$)

=== Was kann MSO ausdrücken?

MSO kann sehr viele natürliche Grapheigenschaften ausdrücken:

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  list(
    [Zusammenhängigkeit],
    [$k$-Färbbarkeit],
    [Existenz eines Hamiltonpfades],
  ),
  list(
    [Bipartitheit],
    [Planare Graphen (für festes Geschlecht)],
    [Viele weitere natürliche Eigenschaften],
  ),
)

MSO ist in gewissem Sinne die "Grenze" dessen was man sinnvoll über Graphen sagen will. Es ist die *natürliche* Logik für Graphen.

== Das überraschende Resultat

#theorem-box(title: "Theorem 4.3 — Das Hauptresultat")[
  Sei $P$ eine Eigenschaft die in MSO ausdrückbar ist. Dann:

  $ P "ausdrückbar als GNN[R]" <=> P "ausdrückbar als GNN[F]" $

  Das gilt auch für constant-iteration GNNs.
]

=== Was bedeutet das intuitiv?

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  block(fill: rgb("#ffebee"), stroke: 1pt + rgb("#f44336"), inset: 12pt, radius: 4pt)[
    *Absolut gesehen:*\
    GNN[R] > GNN[F]\
    \
    Die Extramacht liegt bei Eigenschaften wie "Nachbarzahl ist Primzahl" oder sogar unentscheidbare Eigenschaften.
  ],
  block(fill: rgb("#e8f5e9"), stroke: 1pt + rgb("#4CAF50"), inset: 12pt, radius: 4pt)[
    *Relativ zu MSO:*\
    GNN[R] = GNN[F]\
    \
    Für alles was MSO beschreiben kann — also alle praktisch relevanten Eigenschaften — sind beide gleich stark.
  ],
)

#key-box[
  Die Extramacht von GNN[R] liegt komplett *außerhalb von MSO*. Da man in der Praxis nur MSO-definierbare Eigenschaften braucht: Floats reichen immer.
]

== Die Beweisidee (vereinfacht)

Der Beweis nutzt *Parity Tree Automata (PTAs)* — Automaten die MSO auf Baumgraphen charakterisieren (Janin-Walukiewicz Theorem).

#align(center)[
  #block(fill: rgb("#f8f9fa"), stroke: 1pt + rgb("#e2e8f0"), inset: 14pt, radius: 4pt, width: 80%)[
    MSO-Eigenschaft $P$ \
    $arrow.b$ Theorem 4.6 \
    PTA $A$ \
    $arrow.b$ Lemma 4.7 \
    $k$-Prefix Dekorationen von $T$ \
    $arrow.b$ Lemma C.4 \
    GMSC-Programm $Lambda$
  ]
]

Das zeigt: Wenn $P$ in MSO und als GNN[R] ausdrückbar ist, dann auch in GMSC, und damit auch als GNN[F].

#pagebreak()

// ============================================================
= Das große Bild
// ============================================================

== Zusammenfassung aller Resultate

#block(
  fill: rgb("#1a1a2e"),
  inset: 20pt,
  radius: 6pt,
  width: 100%,
)[
  #text(fill: white, weight: "bold")[Absolut:]
  #v(0.3em)
  #text(fill: rgb("#90cdf4"))[GNN[F] ≡ GMSC < GNN[R] ≡ ω-GML]
  #v(0.8em)
  #text(fill: white, weight: "bold")[Relativ zu MSO:]
  #v(0.3em)
  #text(fill: rgb("#9ae6b4"))[GNN[F] ≡ GMSC ≡ GNN[R] ≡ ω-GML ≡ CMPA]
]

#v(0.5em)

#table(
  columns: (auto, 1fr, 1fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#1a1a2e") } else if calc.odd(row) { rgb("#f7fafc") } else { white },
  inset: 10pt,
  [#text(fill: white, weight: "bold")[Setting]],
  [#text(fill: white, weight: "bold")[GNN[F]]],
  [#text(fill: white, weight: "bold")[GNN[R]]],
  [Absolut], [≡ GMSC (finit)], [≡ ω-GML (infinit)],
  [Relativ zu MSO], [≡ GMSC], [≡ GMSC (!!)],
  [Constant-iteration], [≡ GML], [≡ depth-bounded ω-GML],
)

== Praktische Implikationen

#grid(
  columns: (auto, 1fr),
  gutter: 12pt,
  row-gutter: 10pt,
  text(fill: rgb("#4CAF50"), size: 16pt)[✓],
  [*Modellwahl:* Wenn dein Problem in MSO ausdrückbar ist (fast immer der Fall), reicht GNN[F]. Du brauchst kein theoretisch stärkeres Modell.],
  text(fill: rgb("#4CAF50"), size: 16pt)[✓],
  [*Theoretische Analysen:* Forscher arbeiten oft mit reellen Zahlen weil es mathematisch einfacher ist. Für MSO-Eigenschaften ist das kein Problem — die Ergebnisse gelten auch für Floats.],
  text(fill: rgb("#4CAF50"), size: 16pt)[✓],
  [*Debugging:* Wenn ein GNN eine MSO-definierbare Eigenschaft nicht lernt, liegt es nicht am Modell (Float vs Real) sondern am Training oder der Architektur.],
)

== Offene Fragen

Das Paper lässt bewusst einige Fragen offen:

- *Terminierung:* Wie lernt ein RGNN im Training wann er terminieren soll? Das ist noch offen und praktisch sehr wichtig.
- *Globale Readouts:* Appendix D zeigt dass die Charakterisierung auf GNNs mit globalem Readout erweiterbar ist (GMSC + counting global modality).

#pagebreak()

// ============================================================
= Vortrag Checkliste
// ============================================================

#block(
  fill: rgb("#f8f9fa"),
  stroke: 1pt + rgb("#e2e8f0"),
  inset: 16pt,
  radius: 6pt,
  width: 100%,
)[
  *30 Minuten Vortrag — Zeitplan:*

  #table(
    columns: (auto, 1fr, auto),
    stroke: none,
    inset: (x: 8pt, y: 6pt),
    [☐], [Einstieg mit provokanter Frage über Training-Debugging], [*3 min*],
    [☐], [GNN kurz wiederholen (Publikum kennt es)], [*2 min*],
    [☐], [RGNN: *ein* klares Bild, *ein* Satz Unterschied], [*3 min*],
    [☐], [Float-Problem: Zahlenbeispiel konkret rechnen (1 + (-1) + 0.01)], [*5 min*],
    [☐], [GMSC und ω-GML: nur Intuition, keine formalen Beweise], [*5 min*],
    [☐], [Theorem 3.2 und 3.4 als Ergebnis präsentieren], [*3 min*],
    [☐], [MSO erklären: was kann es ausdrücken?], [*3 min*],
    [☐], [Theorem 4.3: der Twist, Floats reichen für alles Praktische], [*4 min*],
    [☐], [Fazit und Implikationen], [*2 min*],
  )
]

#v(1em)

== Key Takeaways

#block(fill: rgb("#e8f5e9"), stroke: 1pt + rgb("#4CAF50"), inset: 14pt, radius: 4pt)[
  #text(weight: "bold")[GNN[F] ↔ GMSC]\
  Floats entsprechen einer finiten Regellogik mit Zählmodaliäten.
]

#v(0.5em)

#block(fill: rgb("#e3f2fd"), stroke: 1pt + rgb("#2196F3"), inset: 14pt, radius: 4pt)[
  #text(weight: "bold")[GNN[R] ↔ ω-GML]\
  Reelle Zahlen entsprechen unendlicher Disjunktionslogik (sehr mächtig, sogar unentscheidbar).
]

#v(0.5em)

#block(fill: rgb("#f3e5f5"), stroke: 1pt + rgb("#9C27B0"), inset: 14pt, radius: 4pt)[
  #text(weight: "bold")[Relativ zu MSO: alles gleich]\
  Die Extramacht liegt wo man sie in der Praxis nie braucht.
]

#v(0.5em)

#block(fill: rgb("#fff8e1"), stroke: 1pt + rgb("#FF9800"), inset: 14pt, radius: 4pt)[
  #text(weight: "bold")[Praktische Implikation]\
  Theoretische Analysen mit $RR$ sind trotzdem praxisrelevant — für MSO-Eigenschaften gilt alles auch für Floats.
]