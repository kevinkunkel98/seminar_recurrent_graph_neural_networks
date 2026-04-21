# Seminar Recurrent Graph Neural Networks
Seminar paper and slides for the **Graph Neural Networks** seminar at Universität Leipzig (Summer Semester 2026).

Supervisor: Prof. Carsten Lutz
Authors: Kevin Kunkel & Thomas Mohr

## Topic

Logical characterizations of recurrent GNNs — covering the equivalence of GNN[F] with GMSC, GNN[R] with ω-GML, and the MSO collapse result. Based on [Ahvonen et al. 2024](https://arxiv.org/abs/2405.14606).

## Files

| File | Description |
|------|-------------|
| `main.typ` | Seminar paper (Typst) |
| `slides.typ` | Presentation slides (Typst + Touying) |
| `refs.bib` | Bibliography |
| `rgnns.pdf` | Source paper |

## Build

```bash
typst compile main.typ      # paper
typst compile slides.typ    # slides
typst watch slides.typ      # live recompile
```

Present with `zathura slides.pdf` → `F5` for fullscreen.
