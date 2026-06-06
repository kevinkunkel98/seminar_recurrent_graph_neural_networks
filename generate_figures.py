#!/usr/bin/env python3
"""
Generate publication-quality SVG/PDF figures for the GNN/GMSC seminar slides.

Outputs (saved next to this script):
  relu_star.svg/.pdf          — ReLU* (truncated ReLU) function plot
  centre_point_tree.svg/.pdf  — Centre-Point tree with X^0/X^1/X^2 layers
  gnn_reachability.svg/.pdf   — 4-frame reachability propagation
  logic_hierarchy.svg/.pdf    — GML ⊊ GMSC ⊊ ω-GML expressive power diagram

Usage:
  python3 generate_figures.py

Embed in Typst:
  #image("relu_star.svg", width: 55%)
  #image("centre_point_tree.svg", width: 75%)
  #image("gnn_reachability.svg", width: 100%)
  #image("logic_hierarchy.svg", width: 80%)
"""

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import matplotlib.patheffects as pe
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
import networkx as nx
import numpy as np

# ── Colour palette (matching slides.typ) ──────────────────────────────────────
NAVY  = "#1c3a5e"
BLUE  = "#1a4f8a"
SKY   = "#dce9f7"
SAGE  = "#1e6b3c"
MINT  = "#e4f4ec"
SAND  = "#f7f4ef"
AMBER = "#b7770d"
GRAY  = "#8fa3bb"
WHITE = "#ffffff"

plt.rcParams.update({
    "font.family":      "sans-serif",
    "font.sans-serif":  ["DejaVu Sans", "Helvetica Neue", "Arial"],
    "mathtext.fontset": "dejavusans",
    "figure.dpi":       150,
    "savefig.dpi":      300,
})


# ── 1. ReLU* ─────────────────────────────────────────────────────────────────
def plot_relu_star(path="relu_star"):
    fig, ax = plt.subplots(figsize=(5.5, 3.8))
    fig.patch.set_facecolor(SAND)
    ax.set_facecolor(SAND)

    x = np.linspace(-1.0, 2.4, 2000)
    y = np.clip(x, 0.0, 1.0)

    ax.plot(x[x < 0],              y[x < 0],              color=BLUE, lw=2.8, solid_capstyle="round")
    ax.plot(x[(x >= 0) & (x <= 1)],y[(x >= 0) & (x <= 1)],color=BLUE, lw=2.8, solid_capstyle="round")
    ax.plot(x[x > 1],              y[x > 1],              color=SAGE, lw=2.8, solid_capstyle="round")

    ax.plot(0, 0, "o", color=BLUE, ms=8, zorder=5)
    ax.plot(1, 1, "o", color=SAGE, ms=8, zorder=5)

    # Guide dashes
    ax.plot([1, 1], [0, 1], color=GRAY, lw=0.9, ls="--", alpha=0.7)
    ax.plot([0, 1], [1, 1], color=GRAY, lw=0.9, ls="--", alpha=0.7)

    # Axes as arrows
    ax.annotate("", xy=(2.5, 0), xytext=(-1.05, 0),
                arrowprops=dict(arrowstyle="->", color=NAVY, lw=1.3))
    ax.annotate("", xy=(0, 1.55), xytext=(0, -0.35),
                arrowprops=dict(arrowstyle="->", color=NAVY, lw=1.3))

    ax.text(2.56,  0.00, "$x$",             fontsize=14, color=NAVY, va="center")
    ax.text(0.06,  1.50, "$y$",             fontsize=14, color=NAVY)
    ax.text(1.00, -0.18, "$1$",             fontsize=12, color=NAVY, ha="center")
    ax.text(-0.13, 1.00, "$1$",             fontsize=12, color=NAVY, ha="right", va="center")

    ax.text(1.75, 0.72, "ReLU*",            fontsize=13, color=BLUE, weight="bold")
    ax.text(1.75, 0.54, "= min(1, max(0, x))", fontsize=9.5, color=GRAY, style="italic")

    # Region shading
    ax.axhspan(0, 1, xmin=0, xmax=1/3.5, alpha=0.07, color=BLUE)

    ax.set_xlim(-1.05, 2.55)
    ax.set_ylim(-0.35, 1.55)
    ax.axis("off")
    plt.tight_layout(pad=0.6)
    _save(fig, path)


# ── 2. Centre-Point tree ──────────────────────────────────────────────────────
def plot_centre_point_tree(path="centre_point_tree"):
    fig, ax = plt.subplots(figsize=(8.5, 5.5))
    fig.patch.set_facecolor(WHITE)
    ax.set_facecolor(WHITE)

    G = nx.DiGraph()
    G.add_edges_from([
        ("v",  "u1"), ("v",  "u2"),
        ("u1", "d1"), ("u1", "d2"),
        ("u2", "d3"), ("u2", "d4"),
    ])

    pos = {
        "v":  (4.0, 4.2),
        "u1": (2.0, 2.6), "u2": (6.0, 2.6),
        "d1": (0.8, 1.0), "d2": (3.0, 1.0),
        "d3": (5.0, 1.0), "d4": (7.2, 1.0),
    }

    NODE_COL  = {"v": SAGE, "u1": BLUE, "u2": BLUE,
                 "d1": GRAY, "d2": GRAY, "d3": GRAY, "d4": GRAY}
    NODE_SIZE = {"v": 2200, "u1": 1500, "u2": 1500,
                 "d1": 1100, "d2": 1100, "d3": 1100, "d4": 1100}

    node_order = list(G.nodes())
    colors = [NODE_COL[n]  for n in node_order]
    sizes  = [NODE_SIZE[n] for n in node_order]

    nx.draw_networkx_edges(G, pos, ax=ax,
        edge_color=SKY, arrows=True, arrowstyle="-|>",
        arrowsize=22, width=2.2,
        min_source_margin=25, min_target_margin=20)

    nx.draw_networkx_nodes(G, pos, ax=ax, nodelist=node_order,
        node_color=colors, node_size=sizes,
        linewidths=2.5, edgecolors=WHITE)

    math_labels = {"v": "$v$", "u1": "$u_1$", "u2": "$u_2$",
                   "d1": "$d_1$", "d2": "$d_2$", "d3": "$d_3$", "d4": "$d_4$"}
    nx.draw_networkx_labels(G, pos, math_labels, ax=ax,
        font_color=WHITE, font_size=12, font_weight="bold")

    # Layer annotations
    lx = -0.3
    for y_pos, label, col in [
        (4.2, "$X^2$ — ACCEPT",     SAGE),
        (2.6, "$X^1$",              BLUE),
        (1.0, "$X^0$ = □⊥ (Sackgassen)", GRAY),
    ]:
        ax.text(lx, y_pos, label, ha="right", va="center",
                fontsize=11, color=col, weight="bold",
                bbox=dict(boxstyle="round,pad=0.3", fc="white", ec=col, lw=1.1, alpha=0.85))

    # Depth rulers on right
    for y_pos, depth in [(4.2, "Tiefe 0"), (2.6, "Tiefe 1"), (1.0, "Tiefe 2")]:
        ax.text(8.2, y_pos, depth, ha="left", va="center",
                fontsize=9, color=GRAY, style="italic")

    # Accept crown above v
    vx, vy = pos["v"]
    ax.annotate("", xy=(vx, vy + 0.45), xytext=(vx, vy + 0.95),
                arrowprops=dict(arrowstyle="-|>", color=SAGE, lw=1.5))
    ax.text(vx, vy + 1.05, "akzeptiert", ha="center", fontsize=10,
            color=SAGE, weight="bold")

    ax.set_xlim(-2.2, 9.0)
    ax.set_ylim(0.1, 5.6)
    ax.axis("off")

    # Title
    fig.text(0.5, 0.97, "Centre-Point: alle Pfade von $v$ enden nach genau $n = 2$ Schritten in Sackgassen",
             ha="center", fontsize=11, color=NAVY, weight="bold")

    plt.tight_layout(pad=0.4, rect=[0, 0, 1, 0.96])
    _save(fig, path)


# ── 3. GNN Reachability propagation ──────────────────────────────────────────
def plot_gnn_reachability(path="gnn_reachability"):
    """4-frame animation of reachability propagation v → u1 → u2 → p."""

    G   = nx.DiGraph()
    G.add_edges_from([("v", "u1"), ("u1", "u2"), ("u2", "p")])
    pos = {"v": (0, 0), "u1": (1, 0), "u2": (2, 0), "p": (3, 0)}
    mlabels = {"v": "$v$", "u1": "$u_1$", "u2": "$u_2$", "p": "$p$"}

    states = [
        {"v": 0, "u1": 0, "u2": 0, "p": 1},
        {"v": 0, "u1": 0, "u2": 1, "p": 1},
        {"v": 0, "u1": 1, "u2": 1, "p": 1},
        {"v": 1, "u1": 1, "u2": 1, "p": 1},
    ]
    titles  = ["$t = 0$", "$t = 1$", "$t = 2$", "$t = t^*$"]
    t_colors = [NAVY, NAVY, NAVY, SAGE]

    fig = plt.figure(figsize=(14, 3.8))
    fig.patch.set_facecolor(WHITE)

    axes = []
    for i in range(4):
        left  = 0.03 + i * 0.245
        ax    = fig.add_axes([left, 0.12, 0.21, 0.72])
        axes.append(ax)

    for idx, (ax, state, title, tcol) in enumerate(zip(axes, states, titles, t_colors)):
        bg = MINT if idx == 3 else "#f4f8fc"
        ax.set_facecolor(bg)

        n_cols  = [SAGE if state[n] == 1 else BLUE for n in G.nodes()]
        e_cols  = [SAGE if state[u] == 1 and state[w] == 1 else SKY
                   for u, w in G.edges()]
        e_width = [2.5 if state[u] == 1 and state[w] == 1 else 1.5
                   for u, w in G.edges()]

        nx.draw_networkx_edges(G, pos, ax=ax,
            edge_color=e_cols, arrows=True, arrowstyle="-|>",
            arrowsize=22, width=e_width,
            min_source_margin=22, min_target_margin=22)

        nx.draw_networkx_nodes(G, pos, ax=ax,
            node_color=n_cols, node_size=1200,
            linewidths=2.5, edgecolors=WHITE)

        nx.draw_networkx_labels(G, pos, mlabels, ax=ax,
            font_color=WHITE, font_size=13, font_weight="bold")

        # State values above nodes
        for node in G.nodes():
            x, y = pos[node]
            val  = state[node]
            col  = SAGE if val else "#a0b4c8"
            ax.text(x, 0.52, str(val), ha="center", va="bottom",
                    fontsize=11, color=col,
                    weight="bold" if val else "normal")

        # Accept marker
        if idx == 3:
            vx, vy = pos["v"]
            ax.annotate("ACCEPT", xy=(vx, vy - 0.3), xytext=(vx, vy - 0.7),
                        ha="center", fontsize=8.5, color=SAGE, weight="bold",
                        arrowprops=dict(arrowstyle="-|>", color=SAGE, lw=1.1))

        # Green border for accept frame
        for spine in ax.spines.values():
            spine.set_visible(True)
            spine.set_linewidth(2.2 if idx == 3 else 0.8)
            spine.set_edgecolor(SAGE if idx == 3 else "#d0dce8")

        ax.set_title(title, fontsize=13, color=tcol, weight="bold", pad=6)
        ax.set_xlim(-0.7, 3.7)
        ax.set_ylim(-0.95, 0.85)
        ax.set_xticks([]); ax.set_yticks([])

    # Arrows between frames
    for i in range(3):
        x = 0.245 + i * 0.245
        fig.text(x + 0.005, 0.49, "→", fontsize=20,
                ha="center", va="center", color=GRAY)

    fig.text(0.5, 0.97,
             "Erreichbarkeit von $p$ — Propagation durch rekurrentes GNN",
             ha="center", fontsize=12, color=NAVY, weight="bold")
    fig.text(0.5, 0.03,
             r"Update: $x_v^{(t)} = \mathrm{ReLU^*}(x_v^{(t-1)} + \sum_{u} x_u^{(t-1)})$"
             r"   mit  $A = C = 1,\; b = 0$",
             ha="center", fontsize=9.5, color=GRAY, style="italic")

    _save(fig, path)


# ── 4. Logic hierarchy diagram ───────────────────────────────────────────────
def plot_logic_hierarchy(path="logic_hierarchy"):
    """Nested boxes showing GML ⊊ GMSC ⊊ ω-GML with example properties."""

    fig, ax = plt.subplots(figsize=(10, 5.5))
    fig.patch.set_facecolor(WHITE)
    ax.set_facecolor(WHITE)
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 5.5)
    ax.axis("off")

    def rounded_box(x0, y0, x1, y1, color, label, label_y=None, alpha=0.18):
        cx, cy = (x0 + x1) / 2, (y0 + y1) / 2
        width, height = x1 - x0, y1 - y0
        box = FancyBboxPatch((x0, y0), width, height,
                             boxstyle="round,pad=0.12",
                             facecolor=color, edgecolor=color,
                             alpha=alpha, linewidth=0, zorder=1)
        ax.add_patch(box)
        border = FancyBboxPatch((x0, y0), width, height,
                                boxstyle="round,pad=0.12",
                                facecolor="none", edgecolor=color,
                                alpha=0.8, linewidth=2.2, zorder=2)
        ax.add_patch(border)
        ly = label_y if label_y is not None else y1 - 0.28
        ax.text(cx, ly, label,
                ha="center", va="center", fontsize=12,
                color=color, weight="bold", zorder=3)

    # ω-GML (outermost)
    rounded_box(0.3, 0.3, 9.7, 5.1, NAVY, "ω-GML", label_y=4.75)
    # GMSC
    rounded_box(1.2, 0.7, 8.8, 4.4, BLUE, "GMSC",  label_y=4.08)
    # GML (innermost)
    rounded_box(2.2, 1.1, 7.8, 3.6, SKY,  "GML",   label_y=3.28)

    # ── Content inside GML
    gml_items = [
        "◇_{≥k} φ  —  Zählmodalitäten",
        "Konstantiterations-GNNs ≡ GML",
        "Reachability in $k$ Schritten (festes $k$)",
    ]
    for i, text in enumerate(gml_items):
        ax.text(5.0, 2.85 - i * 0.42, text, ha="center", va="center",
                fontsize=8.5, color=NAVY, zorder=4)

    # ── GMSC-only content (between GML and GMSC borders)
    gmsc_items = [
        ("$X^n$ = ◇$X^{n-1}$ ∧ □$X^{n-1}$",   3.62, 0.95),
        ("Centre-Point-Eigenschaft",              3.62, 0.65),
        ("Reachability (unbeschränkt)",            6.38, 0.65),
        ("alle Pfadlängen $n \\in \\mathbf{N}$",  6.38, 0.95),
    ]
    for text, tx, ty in gmsc_items:
        ax.text(tx, ty + 0.45, text, ha="center", va="center",
                fontsize=8.0, color=BLUE, style="italic", zorder=4)

    # ── ω-GML-only content
    omega_items = [
        ("∪_n φ_n  —  unendliche Disjunktionen", 5.0, 4.45),
        ("Primalität des Grades",                  2.6, 4.43),
        ("unentscheidbare Grapheigenschaften",      7.5, 4.43),
    ]
    for text, tx, ty in omega_items:
        ax.text(tx, ty, text, ha="center", va="center",
                fontsize=8.0, color=NAVY, style="italic", zorder=4, alpha=0.9)

    # ── Strict inclusion arrows with labels
    for x0, x1, y_ar, label in [
        (7.8,  8.8,  2.35, "⊊"),
        (8.8,  9.7,  2.35, "⊊"),
    ]:
        pass  # handled by nested boxes already

    ax.text(8.05, 0.52, "⊊", ha="center", fontsize=22, color=BLUE, weight="bold", zorder=5)
    ax.text(9.1,  0.52, "⊊", ha="center", fontsize=22, color=NAVY, weight="bold", zorder=5)
    ax.text(8.05, 0.15, "GML ⊊ GMSC",  ha="center", fontsize=8, color=GRAY)
    ax.text(9.1,  0.15, "GMSC ⊊ ω-GML", ha="center", fontsize=8, color=GRAY)

    # ── GNN equivalences
    ax.text(0.55, 2.6, "GNN[F]\n$\\equiv$ GNN[R]\n(über MSO)", ha="center",
            fontsize=8.5, color=SAGE, weight="bold",
            bbox=dict(boxstyle="round,pad=0.3", fc=MINT, ec=SAGE, lw=1.2, alpha=0.9))

    fig.text(0.5, 0.96,
             "Ausdrucksstärke-Hierarchie:  GML  ⊊  GMSC  ⊊  ω-GML",
             ha="center", fontsize=12, color=NAVY, weight="bold")

    plt.tight_layout(pad=0.3, rect=[0, 0, 1, 0.95])
    _save(fig, path)


# ── Helper ────────────────────────────────────────────────────────────────────
def _save(fig, basename):
    for ext in ("svg", "pdf"):
        out = f"{basename}.{ext}"
        fig.savefig(out, bbox_inches="tight", format=ext)
        print(f"  saved {out}")
    plt.close(fig)


# ── Main ─────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("Generating figures...")
    plot_relu_star()
    plot_centre_point_tree()
    plot_gnn_reachability()
    plot_logic_hierarchy()
    print("\nDone! Einbinden in Typst:")
    print('  #image("relu_star.svg",          width: 55%)')
    print('  #image("centre_point_tree.svg",  width: 78%)')
    print('  #image("gnn_reachability.svg",   width: 100%)')
    print('  #image("logic_hierarchy.svg",    width: 85%)')
