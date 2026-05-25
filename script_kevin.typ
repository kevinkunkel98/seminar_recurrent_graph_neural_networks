// ════════════════════════════════════════════════════════════════════════════
// Sprecherskript — Kevin Kunkel
// Recurrent Graph Neural Networks: Logical Characterizations via Modal Logic
// Seminar GNNs, Universität Leipzig, SoSe 2026
// Papier: Ahvonen, Heiman, Kuusisto, Lutz — NeurIPS 2024
// ════════════════════════════════════════════════════════════════════════════

#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
#set text(font: "Linux Libertine", size: 11pt, lang: "de")
#set par(justify: true, leading: 0.75em)

#let slide-box(title, timing, body) = block(
  width: 100%, radius: 4pt,
  stroke: (left: 4pt + rgb("#1e6b3c")),
  fill: rgb("#f3f9f5"), inset: (x: 1em, y: 0.8em),
  below: 1.5em,
)[
  #text(size: 10pt, fill: rgb("#1e6b3c"), weight: "bold")[FOLIE: #title]
  #h(1fr)
  #text(size: 9pt, fill: rgb("#888"))[⏱ #timing]
  #line(length: 100%, stroke: 0.4pt + rgb("#b0d4be"))
  #v(0.4em)
  #body
]

#let note(body) = block(
  fill: rgb("#fffbea"), stroke: 0.4pt + rgb("#c8a84b"),
  inset: (x: 0.8em, y: 0.5em), radius: 3pt, below: 0.6em,
)[
  #text(size: 9.5pt, fill: rgb("#7a5c00"))[*Hinweis:* #body]
]

#let pause = text(size: 9pt, fill: rgb("#999"), style: "italic")[(kurze Pause)]

// ── Titelseite ────────────────────────────────────────────────────────────────
#align(center)[
  #v(1em)
  #text(size: 20pt, weight: "bold")[Sprecherskript — Kevin Kunkel]
  #v(0.4em)
  #text(size: 13pt, fill: rgb("#555"))[Recurrent Graph Neural Networks: Logical Characterizations via Modal Logic]
  #v(0.2em)
  #text(size: 11pt, fill: rgb("#888"))[Seminar GNNs · Universität Leipzig · SoSe 2026]
  #v(0.5em)
  #line(length: 60%, stroke: 1pt + rgb("#1e6b3c"))
  #v(0.5em)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 1em,
    align: center,
    [*Teil 1:* Section 2.2 — Logics\ #text(size: 9pt, fill: rgb("#888"))[~5 min]],
    [*Teil 2:* Section 4 — MSO\ #text(size: 9pt, fill: rgb("#888"))[~20 min]],
    [*Teil 3:* Fazit (gemeinsam)\ #text(size: 9pt, fill: rgb("#888"))[~5 min]],
  )
  #v(2em)
]

// ════════════════════════════════════════════════════════════════════════════
// TEIL 1 — SECTION 2.2: LOGICS (~5 Minuten)
// ════════════════════════════════════════════════════════════════════════════

#text(size: 16pt, weight: "bold", fill: rgb("#1c3a5e"))[= Teil 1: Section 2.2 — Logics]
#text(size: 10pt, fill: rgb("#888"))[Übergang von Thomas nach etwa 5 Minuten GNN-Einführung]
#v(1em)

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Graded Modal Logic (GML)], [ca. 2 min])[

  #note[Erster Folienwechsel zu meinem Teil — kurz einleiten, dann direkt einsteigen.]

  Danke, Thomas. Ich übernehme jetzt mit den Logiken — also dem formalen Rahmen, den wir brauchen, um GNNs präzise zu charakterisieren.

  #v(0.4em)
  Die erste Logik ist die *Graded Modal Logic*, kurz *GML*. Man kann GML als Aussagenlogik mit Zählmodalitäten beschreiben. Die Syntax ist vertraut — Top, Atome, Negation, Konjunktion — aber es kommt ein neuer Operator dazu: der *Diamant mit Zähler k*. Dieser Ausdruck $lozenge_(>= k) phi$ liest sich als: _„Es gibt mindestens k direkte Nachfolger, die phi erfüllen."_

  #v(0.4em)
  Das ist genau die Art von lokalem Zählen, die ein GNN in einer Runde machen kann. Schauen wir auf das Beispiel: $lozenge_(>= 1) p$ sagt einfach „es gibt einen Nachbarn mit Label p". Anspruchsvoller: $lozenge_(>= 3) (q and lozenge_(>= 2) r)$ sagt „mindestens 3 Nachbarn haben Eigenschaft q, und jeder davon hat seinerseits mindestens 2 Nachbarn mit r". Man sieht, wie sich diese Formeln schachteln lassen — genau wie Runden im Message Passing.

  #v(0.4em)
  Warum ist GML überhaupt relevant? Es gibt ein klassisches Ergebnis von Barceló et al.~(2020): GNNs mit *fester* Rundenzahl sind äquivalent zu GML — aber nur relativ zu FO-definierbaren Eigenschaften. Und das ist der entscheidende Punkt: die Einschränkung „feste Runden" passt zu standard GNNs, nicht zu recurrent GNNs. Für rekurrente Netze brauchen wir mehr Ausdrucksstärke — und dafür die nächste Logik.
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Graded Modal Substitution Calculus (GMSC)], [ca. 1:30 min])[

  GMSC — das *Graded Modal Substitution Calculus* — erweitert GML um *rekursive Regeln*.

  #v(0.4em)
  Ein GMSC-Programm Lambda besteht aus zwei Teilen, die ihr auf der Folie seht. Die *Basisregel* `X(0) :− φ` gibt uns eine GML-Formel für den Anfangszustand — Runde 0. Die *Iterationsregel* `X :− ψ` beschreibt, wie wir iterativ weitermachen — wobei ψ selbst wieder X verwenden darf.

  #v(0.4em)
  Die n-te Entfaltung $X^n$ entsteht durch sukzessives Einsetzen: wir nehmen ψ und ersetzen X durch $X^(n-1)$, beginnend bei $X^0 = phi$. Lambda akzeptiert einen Knoten v im Graphen G, wenn es *irgendein* n gibt, sodass v die Formel $X^n$ erfüllt.

  #v(0.4em)
  Das Standardbeispiel illustriert das perfekt: *Erreichbarkeit von Label p*. Basisfall: die Formel p selbst — der Knoten hat p. Iterationsregel: ein Schritt weiter — der Diamant angewendet auf X. Die n-te Entfaltung ist dann $lozenge dots.c lozenge p$ mit n Diamanten — also „p ist in genau n Schritten erreichbar". Da Lambda für *irgendein* n akzeptiert, erfasst es genau die Eigenschaft „p ist von diesem Knoten aus erreichbar". Und das ist unbeschränkt — egal wie groß der Graph ist.

  #v(0.4em)
  Das entspricht exakt dem, was ein Recurrent GNN tut: es läuft, bis es die Antwort gefunden hat.
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([ω-GML und die Logikhierarchie], [ca. 1:30 min])[

  #note[Folie zeigt die drei Logiken und ihre Hierarchie — kurz auf alle drei eingehen, dann sauber zu Thomas überleiten.]

  Die dritte Logik ist *ω-GML*. Sie nimmt GML und erlaubt zusätzlich *unendliche Disjunktionen* über abzählbare Mengen von GML-Formeln.

  #v(0.4em)
  Warum brauchen wir das? Weil GNN[R] — also GNNs mit reellen Zahlen — beliebig viele verschiedene Werte unterscheiden kann. Konkret kann ein GNN[R] für jede beliebige Menge $U subset.eq NN$ prüfen, ob die Anzahl der Nachbarn in U liegt — auch für *undecidierbare* Mengen U. Um diese Ausdrucksstärke logisch zu erfassen, reichen endliche Disjunktionen nicht — wir brauchen ω-GML mit ihren unendlichen Disjunktionen.

  #v(0.4em)
  Das ergibt die Hierarchie, die ihr auf der Folie seht:
  $"GML" subset "GMSC" subset omega"-GML"$
  Jede dieser Inklusionen ist *echt* — die Logiken werden also tatsächlich stärker.

  #v(0.4em)
  Zur Einordnung: Auf Strings ist FO äquivalent zu sternfreien regulären Sprachen, MSO zu allen regulären Sprachen. Auf Graphen kann FO lokale Dinge sagen wie „jeder Knoten hat einen Nachbarn", MSO kann globale strukturelle Eigenschaften erfassen — Bipartitheit, Erreichbarkeit, und mehr.

  #v(0.4em)
  Diese drei Logiken sind die formalen Werkzeuge. Thomas zeigt euch jetzt, wie sie über Automaten mit den GNNs verbunden werden.

  #note[Übergabe an Thomas für Section 3 — ca. 20 Minuten.]
]

// ════════════════════════════════════════════════════════════════════════════
// TEIL 2 — SECTION 4: GNNs ÜBER MSO-EIGENSCHAFTEN (~20 Minuten)
// ════════════════════════════════════════════════════════════════════════════

#v(1.5em)
#text(size: 16pt, weight: "bold", fill: rgb("#1c3a5e"))[= Teil 2: Section 4 — GNNs über MSO-Eigenschaften]
#text(size: 10pt, fill: rgb("#888"))[Rückübernahme nach Thomas' Section 3 (ca. 20 Minuten)]
#v(1em)

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Was ist MSO?], [ca. 3 min])[

  #note[Direkt nach Thomas' Haupttheoreme übernehmen — kurze Einleitung und dann motivieren, warum MSO die richtige Einschränkung ist.]

  Vielen Dank, Thomas. Ich übernehme jetzt den letzten Teil — Section 4: GNNs über MSO-Eigenschaften.

  #v(0.4em)
  Wir haben gerade gesehen, dass GNN[R] und ω-GML äquivalent sind — und dass ω-GML sogar unentscheidbare Eigenschaften ausdrücken kann. Das ist theoretisch faszinierend, aber praktisch stellt sich die Frage: _Wer will schon unentscheidbare Grapheigenschaften lernen?_ In der Praxis interessieren uns Dinge wie Zusammenhang, Bipartitheit, Färbbarkeit — Eigenschaften, die wir auch verstehen und verifizieren können.

  #v(0.4em)
  Genau das erfasst *Monadische Zweistufenlogik*, kurz *MSO*. MSO erweitert Erstlogik durch *Mengenquantifikation*. In FO dürfen wir über Elemente quantifizieren — „es gibt ein x", „für alle x". In MSO dürfen wir *zusätzlich* über Mengen von Elementen quantifizieren — „es gibt eine Menge X", „für alle Mengen X". Dieser Schritt klingt klein, öffnet aber enorme Ausdrucksmacht.

  #v(0.4em)
  Schauen wir auf die Folie. Auf Graphen: FO kann sagen „jeder Knoten hat einen Nachbarn" — eine lokale, knotenweise Eigenschaft. MSO kann sagen „der Graph ist bipartit" — dafür quantifizieren wir existenziell über eine Menge X von Knoten und sagen: X und sein Komplement sind unabhängige Mengen. MSO kann auch Erreichbarkeit ausdrücken, Hamiltonizität, k-Färbbarkeit — viele fundamentale Graphprobleme.

  #v(0.4em)
  Das String-Beispiel auf der Folie zeigt, wie klassisch das ist: FO entspricht genau den sternfreien regulären Sprachen, MSO entspricht *allen* regulären Sprachen. Das ist ein sauberes, wohlbekanntes Ergebnis — und MSO auf Graphen ist das natürliche Analogon.

  #v(0.4em)
  MSO ist in gewissem Sinne die *natürliche Logik für Graphen* — sie erfasst fast alles, was man in der Praxis wirklich braucht. Und jetzt stellen wir die entscheidende Frage: Was passiert, wenn wir GNNs auf genau diese praktisch relevanten Eigenschaften einschränken?
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([MSO — Was MSO ausdrücken kann], [ca. 2 min])[

  Konkret: Was liegt in MSO? Die Folie zeigt eine Auswahl.

  #v(0.4em)
  Zusammenhang, k-Färbbarkeit, Hamiltonizität, Bipartitheit, Planarität für festes Geschlecht, Erreichbarkeit zwischen zwei markierten Knoten — das sind alles MSO-ausdrückbare Eigenschaften. Das sind fundamentale Probleme der Graphentheorie, die in maschinellem Lernen auf Graphen ständig auftauchen.

  #v(0.4em)
  Aber hier eine wichtige Klarstellung: MSO ist *nicht* die absolute Grenze dessen, was GNNs können. Thomas hat in Section 3 gezeigt: GNN[R] kann sogar *undecidierbare* Eigenschaften ausdrücken — zum Beispiel „der Grad ist eine Primzahl" für beliebig große Grade. Das liegt weit jenseits von MSO.

  #v(0.4em)
  MSO ist also eine *Einschränkung* — aber eine, die genau den praxisrelevanten Bereich abdeckt. Die Frage ist: Wenn wir uns auf MSO einschränken — verschwindet dann der Unterschied zwischen GNN[R] und GNN[F]? Die Antwort ist ja — und das ist das überraschende Ergebnis dieses Abschnitts.

  #pause
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([MSO — Theorem 4.1 und Beweiszutaten], [ca. 7 min])[

  #note[Das ist die technisch dichteste Folie — ruhig und strukturiert vorgehen. Die zwei Beweiszutaten sind der Kern, beide erklären.]

  Kommen wir zum zentralen Resultat: *Theorem 4.1*.

  #v(0.4em)
  Das Theorem besagt: Für jede MSO-ausdrückbare Eigenschaft $cal(P)$ gilt — $cal(P)$ ist in GNN[R] ausdrückbar *genau dann, wenn* $cal(P)$ in GMSC ausdrückbar ist. Kombiniert mit Theorem 3.2 von Thomas ergibt das: Über alle MSO-Eigenschaften sind GNN[F], GNN[R], und GMSC *alle äquivalent*.

  #v(0.4em)
  Moment — das ist wirklich überraschend. Wir wissen aus Section 3: absolut gesehen ist GNN[R] *stärker* als GNN[F] und GMSC. GNN[R] kann Dinge, die GNN[F] und GMSC nicht können. Aber sobald wir uns auf MSO einschränken, *kollabiert* diese Hierarchie vollständig. Wie kann das sein?

  #v(0.6em)
  Der Beweis hat *zwei Schlüsselzutaten*.

  #v(0.4em)
  *Erste Zutat: Das Janin-Walukiewicz-Theorem* (Theorem 4.6 im Papier).

  GMSC und ω-GML sind *modale* Logiken — sie sind invariant unter Baumentfaltung. Das bedeutet: Wenn zwei Knoten in verschiedenen Graphen dieselbe unendliche Baumentfaltung haben, können modale Logiken sie nicht unterscheiden. Das schränkt die Ausdrucksstärke ein.

  Das Janin-Walukiewicz-Theorem verbindet nun MSO und modale Logik: Es charakterisiert MSO auf Bäumen durch *Paritätsbaumautomaten*, kurz PTAs. Und hier ist der entscheidende Schritt — wenn eine Eigenschaft $cal(P)$ sowohl in MSO als auch in ω-GML liegt, dann gibt es einen PTA $cal(A)$, sodass gilt: $(G, w) in cal(P)$ genau dann, wenn die Baumentfaltung $U(G, w)$ in der Sprache von $cal(A)$ liegt.

  #v(0.4em)
  Wir übersetzen also das Problem: statt direkt mit GNNs zu arbeiten, schauen wir uns an, ob der entfaltete Baum vom Automaten akzeptiert wird. Das ist eine Brücke — von der Grapheigenschaft zu einem Baumautomaten.

  #pause

  #v(0.4em)
  *Zweite Zutat: k-Präfix-Dekorationen* (Lemma 4.7).

  Das ist der technische Kern des Beweises. Für einen PTA $cal(A)$ definiert man eine *Tiefe-k-Karte* μ: Sie ordnet jedem Knoten des Baums in Tiefe k eine Menge von PTA-Zuständen zu. Das ist ein *endliches Zertifikat* dafür, dass der Baum von $cal(A)$ akzeptiert wird.

  Das Lemma sagt dann: Ein Baum liegt in $L(cal(A))$ — also wird vom Automaten akzeptiert — genau dann, wenn er eine k-Präfix-Dekoration für *irgendein* k hat.

  Warum ist das so wichtig? Weil ein *GMSC-Programm* genau das überprüfen kann! Runde k des GMSC prüft, ob das Tiefen-k-Zertifikat existiert. Da GMSC für *irgendein* n akzeptiert, ist das exakt die Semantik, die wir brauchen.

  #v(0.4em)
  Die Beweisidee in einem Satz: Die MSO-Eigenschaft wird zu einem PTA, der PTA gibt uns endliche Zertifikate, und die Zertifikate werden von einem GMSC-Programm überprüft. Damit ist jede MSO-Eigenschaft in GNN[R] auch in GMSC — und da GNN[F] äquivalent zu GMSC ist, auch in GNN[F].
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Das MSO-Kollaps-Theorem], [ca. 5 min])[

  #note[Das ist das Hauptresultat — klarer Kontrast zwischen „absolut" und „relativ zu MSO" herausarbeiten. Folie hat zwei Kästen dafür.]

  *Theorem 4.3 — das MSO-Kollaps-Theorem* — ist das Herzstück von Section 4.

  #v(0.4em)
  Der Satz: Für jede MSO-ausdrückbare Eigenschaft $cal(P)$ gilt: $cal(P)$ ist durch GNN[R] ausdrückbar *genau dann, wenn* $cal(P)$ durch GNN[F] ausdrückbar ist. Und beide werden außerdem durch GMSC erfasst. Das gilt auch für GNNs mit konstanter Iterationszahl.

  #v(0.4em)
  Schauen wir uns die beiden Kästen auf der Folie an — sie zeigen den perfekten Kontrast.

  #v(0.4em)
  Links, *absolut gesehen*: GNN[R] ist strikt mächtiger als GNN[F]. Das haben wir in Section 3 gesehen. Der Unterschied liegt bei Eigenschaften wie „der Grad ist eine Primzahl" für beliebig großen Grad — GNN[R] kann das, GNN[F] nicht, weil Floats ab einem gewissen Punkt nicht mehr zählen können. Und es geht noch weiter: GNN[R] kann sogar *undecidierbare* Eigenschaften ausdrücken.

  #v(0.4em)
  Rechts, *relativ zu MSO*: GNN[R] und GNN[F] sind äquivalent. Für alle praktisch relevanten Eigenschaften — alles, was in MSO liegt — sind Fließkommazahlen *genauso gut* wie reelle Zahlen.

  #v(0.4em)
  Was bedeutet das intuitiv? Die Extramacht von GNN[R] liegt in einem Bereich, der für die Praxis vollständig irrelevant ist — bei Eigenschaften, die niemand in einem echten ML-System lernen möchte. Sobald wir uns auf den praxisrelevanten Bereich beschränken, *kollabiert* die Hierarchie.

  #v(0.4em)
  Das ist ein elegantes Ergebnis — und eines, das echte praktische Konsequenzen hat. Dazu komme ich auf der nächsten Folie.
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Warum der Unterschied verschwindet — Intuition], [ca. 3 min])[

  #note[Diese Folie fasst die Beweisidee nochmal zusammen — ruhig und klar, keine neuen technischen Details.]

  Schauen wir nochmal auf die Beweisstruktur — jetzt als Übersicht.

  #v(0.4em)
  Der Weg geht über *Paritätsbaumautomaten*. Das Janin-Walukiewicz-Theorem zeigt, dass MSO auf baumstrukturierten Graphen genau durch PTAs charakterisiert wird. Das gibt uns folgende Kette:

  Eine MSO-Eigenschaft $cal(P)$ wird in einen PTA $cal(A)$ übersetzt. Aus $cal(A)$ konstruiert man k-Präfix-Dekorationen — das sind endliche Zertifikate der Tiefe k. Und aus diesen Dekorationen baut man ein GMSC-Programm $Lambda$, das in Runde k prüft, ob das Tiefen-k-Zertifikat existiert.

  #v(0.4em)
  Der entscheidende Punkt — und das ist die Kernaussage des ganzen Abschnitts: Die Extramacht von GNN[R] liegt *vollständig außerhalb von MSO*. Wenn eine Eigenschaft $cal(P)$ in MSO ist und durch GNN[R] ausdrückbar ist, dann lässt sich immer ein GMSC-Programm — und damit ein GNN[F] — für $cal(P)$ finden.

  #v(0.4em)
  Im grünen Kasten auf der Folie steht die praktische Konsequenz, und die ist wirklich relevant: *Theoretische Analysen mit reellen Zahlen sind sicher.* Für MSO-Eigenschaften übertragen sich alle Ergebnisse auf Fließkommazahlen. Wenn ein GNN eine MSO-definierbare Eigenschaft nicht lernt — sagen wir, Bipartitheit oder Zusammenhang — dann liegt das Problem im Training oder in der Architektur. *Nicht* an der Float-Präzision. Das ist eine starke Aussage für alle, die GNNs theoretisch analysieren und die Ergebnisse auf die Praxis übertragen wollen.

  #pause
]

// ════════════════════════════════════════════════════════════════════════════
// TEIL 3 — FAZIT (GEMEINSAM MIT THOMAS, ~5 min KEVIN-ANTEIL)
// ════════════════════════════════════════════════════════════════════════════

#v(1.5em)
#text(size: 16pt, weight: "bold", fill: rgb("#1c3a5e"))[= Teil 3: Fazit (gemeinsam mit Thomas)]
#text(size: 10pt, fill: rgb("#888"))[Kevin beginnt das Fazit, Thomas ergänzt open questions nach Absprache]
#v(1em)

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Results at a Glance], [ca. 2:30 min])[

  #note[Tabelle auf der Folie zeigt alle Ergebnisse — jede Zeile kurz erläutern, dann das Gesamtbild zusammenfassen.]

  Fassen wir alle Ergebnisse zusammen.

  #v(0.4em)
  Die Tabelle auf der Folie zeigt zwei Perspektiven: oben die *absoluten* Ergebnisse, unten die Ergebnisse *relativ zu MSO*.

  #v(0.4em)
  *Absolut:* GNN[F] ist äquivalent zu GMSC — das ist Theorem 3.2. GNN[R] ist äquivalent zu ω-GML — das ist Theorem 3.4. Beide Resultate sind *absolut*, also ohne Relativierung zu einer Hintergrundlogik. Auf der Automaten-Seite: floats korrespondieren zu FCMPAs, reelle Zahlen zu CMPAs. Das sind schöne, saubere Charakterisierungen.

  #v(0.4em)
  *Relativ zu MSO:* Hier passiert das Interessante. GNN[F] bleibt äquivalent zu GMSC. GNN[R] ist *ebenfalls* äquivalent zu GMSC — mit Ausrufezeichen, weil das absolut nicht gilt. Und beide kollabieren auf der Automaten-Seite zu FCMPAs.

  #v(0.4em)
  Die zwei Kernaussagen zum Mitnehmen:
  - *Absolut:* GNN[F] ist strikt schwächer als GNN[R] — reelle Zahlen können undecidierbare Eigenschaften ausdrücken.
  - *Relativ zu MSO:* GNN[F] und GNN[R] sind *äquivalent* — Theorie und Praxis konvergieren.
]

// ────────────────────────────────────────────────────────────────────────────
#slide-box([Conclusion & Open Questions], [ca. 2:30 min])[

  #note[Abschluss — klarer Bogen vom Anfang zum Ende. Offene Fragen kann Thomas übernehmen oder aufteilen.]

  Was haben wir in diesem Vortrag gezeigt?

  #v(0.4em)
  Wir haben exakte logische Charakterisierungen für Recurrent GNNs gegeben: GNN[F] entspricht GMSC, GNN[R] entspricht ω-GML. Beide Resultate sind absolut — keine Relativierung zu einer Hintergrundlogik nötig. Und der Unterschied zwischen reellen Zahlen und Floats *verschwindet* für alle MSO-definierbaren Eigenschaften — also für alle Eigenschaften, die in der Praxis eine Rolle spielen.

  #v(0.4em)
  Das ist das zentrale Ergebnis des Papiers: Für praktische Zwecke verlieren Floats *nichts* gegenüber reellen Zahlen. Wenn ein GNN eine praxisrelevante Eigenschaft nicht lernt, ist Float-Präzision nicht schuld.

  #v(0.4em)
  Natürlich bleiben offene Fragen. Erstens: *Terminierung* — wie lernt ein recurrent GNN, *wann* es aufhören soll? Das ist im Papier nicht adressiert. Zweitens: *Global Readout* — wie ändert sich die Charakterisierung mit einem globalen Pooling-Layer? Drittens: *Entscheidbarkeit* — ist Ausdrückbarkeit in GMSC entscheidbar? Und viertens: *Attention-Architekturen* — wo passen GAT und Transformer in diesen Rahmen?

  #v(0.4em)
  Diese Fragen zeigen, dass das Papier einen wichtigen Grundstein legt — aber der Bereich ist noch offen. Vielen Dank für eure Aufmerksamkeit. Fragen?

  #note[Bei Fragen zu Section 4 übernehmen. Bei Fragen zu Section 3 an Thomas weitergeben.]
]

// ════════════════════════════════════════════════════════════════════════════
// ANHANG: PUFFER-NOTIZEN UND GESAMTTIMING
// ════════════════════════════════════════════════════════════════════════════

#v(2em)
#line(length: 100%, stroke: 0.5pt + rgb("#ccc"))
#v(0.5em)
#text(size: 12pt, weight: "bold")[Timing-Übersicht (Ziel: 30 min)]

#v(0.5em)
#table(
  columns: (auto, auto, auto),
  stroke: 0.4pt + rgb("#ccc"),
  fill: (_, row) => if row == 0 { rgb("#f0f4f9") } else { white },
  inset: (x: 0.8em, y: 0.5em),
  [*Folie*], [*Ziel*], [*Puffer*],
  [GML], [2:00], [±30s],
  [GMSC], [1:30], [±30s],
  [ω-GML + Überleitung], [1:30], [±30s],
  [#text(style: "italic")[→ Thomas Section 3]], [—], [—],
  [Was ist MSO?], [3:00], [±45s],
  [MSO — Was es ausdrücken kann], [2:00], [±30s],
  [Theorem 4.1 + Beweiszutaten], [7:00], [±1:00],
  [MSO Collapse Theorem], [5:00], [±1:00],
  [Warum der Unterschied verschwindet], [3:00], [±30s],
  [Results at a Glance (Fazit)], [2:30], [±30s],
  [Conclusion & Open Questions], [2:30], [±30s],
  [*Gesamt Kevin*], [*~30:00*], [±4:00],
)

#v(1em)
#text(size: 10pt, fill: rgb("#666"))[
  *Wenn zu schnell:* Bei den Beispielen (GMSC-Erreichbarkeit, MSO-Bipartitheit) mehr ausholen.
  Bei Theorem 4.1 die PTA-Konstruktion langsamer erklären und die Intuition wiederholen.

  *Wenn zu langsam:* MSO-Beispiel-Folie kürzen (nur zwei Beispiele nennen, nicht alle).
  Bei Theorem 4.1 die zweite Beweiszutat (k-Präfix-Dekorationen) nur als „technisches Lemma" nennen, ohne Details.
]

// ════════════════════════════════════════════════════════════════════════════
// ANNOTATIONSVERZEICHNIS
// ════════════════════════════════════════════════════════════════════════════

#pagebreak()

#v(1em)
#text(size: 16pt, weight: "bold", fill: rgb("#1c3a5e"))[Annotationsverzeichnis]
#v(0.3em)
#text(size: 10pt, fill: rgb("#888"))[Alle Abkürzungen, Variablen und griechischen Buchstaben aus dem Skript]
#v(1em)
#line(length: 100%, stroke: 0.5pt + rgb("#ccc"))

// ── Hilfsfunktion für Einträge ────────────────────────────────────────────
#let entry(symbol, explanation) = grid(
  columns: (5em, 1fr),
  gutter: 0.6em,
  align: (right + top, left + top),
  [#text(weight: "bold", fill: rgb("#1c3a5e"), size: 10.5pt)[#symbol]],
  [#text(size: 10.5pt)[#explanation]],
)

#let section-head(title) = {
  v(1em)
  text(size: 11pt, weight: "bold", fill: rgb("#1e6b3c"))[#title]
  v(0.2em)
  line(length: 100%, stroke: 0.3pt + rgb("#b0d4be"))
  v(0.3em)
}

// ── 1. Abkürzungen ────────────────────────────────────────────────────────
#section-head[1 — Abkürzungen]

#entry[GNN][*Graph Neural Network* — neuronales Netz, das direkt auf Graphen operiert und Knotenmerkmale durch iteratives Nachrichtenaustauschen aktualisiert]
#entry[GNN[ℝ]][GNN mit *reellen Zahlen* als Merkmalsvektoren — theoretisches Modell, unbeschränkte Präzision]
#entry[GNN[𝔽]][GNN mit *Fließkommazahlen* (Floats) — praktisches Modell, beschränkte Präzision und Zählkapazität]
#entry[RGNN][*Recurrent GNN* — GNN ohne feste Rundenzahl; läuft bis ein Knoten einen akzeptierenden Zustand erreicht]
#entry[GML][*Graded Modal Logic* — modale Logik mit Zähloperatoren $lozenge_(>= k)$; charakterisiert GNNs mit fixer Rundenzahl]
#entry[GMSC][*Graded Modal Substitution Calculus* — Erweiterung von GML mit rekursiven Regeln; äquivalent zu GNN[𝔽] (absolut)]
#entry[ω-GML][*omega-Graded Modal Logic* — Erweiterung von GML mit abzählbar unendlichen Disjunktionen; äquivalent zu GNN[ℝ] (absolut)]
#entry[MSO][*Monadic Second-Order Logic* (Monadische Zweistufenlogik) — Erweiterung von FO mit Mengenquantifikation ($exists X$, $forall X$); erfasst praktisch alle relevanten Grapheigenschaften]
#entry[FO][*First-Order Logic* (Erstlogik) — Quantifikation über einzelne Elemente ($exists x$, $forall x$); schwächer als MSO]
#entry[PTA][*Parity Tree Automaton* (Paritätsbaumautomat) — Baumautomat, der MSO auf Bäumen charakterisiert; zentrales Werkzeug im Beweis von Thm. 4.1]
#entry[CMPA][*Counting Message-Passing Automaton* — diskretes Gegenstück zu GNN[ℝ]; abzählbar unendliche Zustandsmenge Q]
#entry[FCMPA][*Finite CMPA* — diskretes Gegenstück zu GNN[𝔽]; endliche Zustandsmenge Q]
#entry[AGG][*Aggregation* — Funktion, die Merkmale aller Nachbarn eines Knotens zu einem einzigen Vektor zusammenfasst (z. B. Summe, Maximum)]
#entry[COM][*Combine* — Funktion, die den eigenen Zustand eines Knotens mit dem Aggregationsergebnis kombiniert (z. B. MLP, GRU)]
#entry[GAT][*Graph Attention Network* — GNN-Variante mit lernbaren Aufmerksamkeitsgewichten auf Kanten]
#entry[MLP][*Multilayer Perceptron* — klassisches vollverbundenes neuronales Netz; häufig als COM-Funktion eingesetzt]

// ── 2. Variablen und Symbole ──────────────────────────────────────────────
#section-head[2 — Variablen und Symbole]

#entry[$G$][Graph — ein geordnetes Paar $(V, E)$ aus Knotenmenge und Kantenmenge]
#entry[$V$][Knotenmenge (*vertices*) des Graphen G]
#entry[$E$][Kantenmenge (*edges*) des Graphen G; $E subset.eq V times V$]
#entry[$v, u, w$][Einzelne Knoten im Graphen; $v$ ist meist der Fokusknoten, $u$ ein Nachbar]
#entry[$cal(N)(v)$][Nachbarschaft von $v$ — Menge aller Knoten $u$ mit $(u, v) in E$]
#entry[$lambda(v)$][Label-Funktion — ordnet Knoten $v$ eine Menge von atomaren Eigenschaften zu ($lambda: V -> cal(P)(Pi)$)]
#entry[$Pi$][Menge der atomaren Eigenschaften (Propositionen), z. B. Label-Alphabet]
#entry[$bold(x)_v^((t))$][Merkmals- bzw. Zustandsvektor von Knoten $v$ nach Runde $t$]
#entry[$t$][Aktuelle Runde (Zeitschritt) der GNN-Berechnung; $t in NN_0$]
#entry[$t^ast$][Akzeptierende Runde — das erste $t$, für das $bold(x)_v^((t)) in F$ gilt]
#entry[$N$][Feste Rundenzahl bei standard GNNs — muss vorab gewählt werden]
#entry[$k$][Zählschwelle in $lozenge_(>= k)$ (GML) *oder* Tiefe einer k-Präfix-Dekoration (Thm. 4.1) — je nach Kontext]
#entry[$n$][Entfaltungstiefe in GMSC — $X^n$ ist die n-te Entfaltung des Programms]
#entry[$d$][Dimension des Merkmalsvektors; Zustandsraum ist $RR^d$ bzw. $FF^d$]
#entry[$cal(P)$][Grapheigenschaft (*property*) — eine Menge von Paaren $(G, v)$; das, was ein GNN oder eine Formel ausdrückt]
#entry[$Lambda$][GMSC-Programm — besteht aus Basisregel und Iterationsregel]
#entry[$X$][Programmvariable in einem GMSC-Programm; $X^n$ ist die n-te Entfaltung]
#entry[$X^0$][Basisfall des GMSC-Programms — die Startformel $phi$]
#entry[$cal(A)$][Paritätsbaumautomat (PTA) — akzeptiert Bäume, die eine MSO-Eigenschaft erfüllen]
#entry[$Q$][Zustandsmenge eines Automaten (CMPA oder PTA)]
#entry[$q_0$][Startzustand des Automaten]
#entry[$F$][Menge der akzeptierenden Zustände — $bold(x)_v^((t)) in F$ bedeutet: Knoten $v$ akzeptiert]
#entry[$delta$][Übergangsfunktion — berechnet neuen Zustand aus aktuellem Zustand und Nachbarmultiset]
#entry[$pi$][Initialisierungsfunktion — berechnet Startzustand aus dem Label-Set des Knotens]
#entry[$mu$][k-Präfix-Dekoration — Abbildung von Knoten der Tiefe k auf Mengen von PTA-Zuständen; endliches Akzeptanzzertifikat]
#entry[$U(G, w)$][Baumentfaltung (*tree unraveling*) von Graph $G$ am Knoten $w$ — unendlicher Baum aller Pfade von $w$ aus]
#entry[$L(cal(A))$][Sprache des Automaten $cal(A)$ — Menge aller Bäume, die $cal(A)$ akzeptiert]
#entry[$U subset.eq NN$][Beliebige Menge natürlicher Zahlen — GNN[ℝ] kann für *jedes* $U$ prüfen, ob $|cal(N)(v)| in U$]
#entry[$M|_k$][Multiset $M$ auf maximal $k$ Kopien jedes Elements beschränkt — relevant für Float-Zählschranke (Prop. 2.3)]
#entry[$RR$][Reelle Zahlen — Zahlenbereich für GNN[ℝ]]
#entry[$FF$][Fließkommazahlen (Floats) — Zahlenbereich für GNN[𝔽]; endliche Darstellung, beschränkte Zählkapazität]
#entry[$NN$][Natürliche Zahlen $\{0, 1, 2, dots\}$]

// ── 3. Griechische Buchstaben ─────────────────────────────────────────────
#section-head[3 — Griechische Buchstaben]

#entry[$phi$ (phi)][Formel — allgemein für eine logische Formel, insbesondere der Basisfall `X(0) :− φ` in GMSC]
#entry[$psi$ (psi)][Formel — Iterationsregel `X :− ψ` in GMSC; darf X rekursiv enthalten]
#entry[$delta$ (delta)][Übergangsfunktion eines GNNs oder Automaten: $delta(x, y) = "COM"(x, "AGG"(y))$]
#entry[$pi$ (pi)][Initialisierungsfunktion: $pi: cal(P)(Pi) -> RR^d$ — bildet Label-Mengen auf Startvektoren ab]
#entry[$mu$ (mu)][k-Präfix-Dekoration: Abbildung $mu: V_k -> cal(P)(Q)$ — weist Knoten in Tiefe $k$ PTA-Zustandsmengen zu]
#entry[$Lambda$ (Lambda)][GMSC-Programm, bestehend aus Basisregel und Iterationsregel]
#entry[$omega$ (omega)][Unendlichkeitssymbol — in ω-GML bezeichnet es die Erweiterung um abzählbar unendliche Disjunktionen]
#entry[$lozenge$ (lozenge)][Modaloperator (*Diamant*) — $lozenge_(>= k) phi$ bedeutet „mindestens k Nachfolger erfüllen $phi$"]
#entry[$top$ (top)][Tautologie — immer wahre Formel; Grundelement der GML-Syntax]
#entry[$Pi$ (Pi)][Alphabet atomarer Eigenschaften — Menge der möglichen Labels auf Knoten]
#entry[$Psi$ (Psi)][Abzählbare Menge von GML-Formeln — Grundlage einer unendlichen Disjunktion in ω-GML]
#entry[$inter$ (Schnitt)][Mengenschnitt — $"MSO" inter omega"-GML"$ ist die Menge aller Eigenschaften, die gleichzeitig in MSO und ω-GML liegen; Voraussetzung für Thm. 4.1]
