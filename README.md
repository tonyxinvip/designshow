# Tony's Trials

Things Tony Xin made. The kind that run in a browser.

**Site** https://tonyxinvip.github.io/designstudio/

| Work | Published | Notes |
|---|---|---|
| [Armature](armature/) | 2026-08-15 | A lattice of rods and ball joints at real depths. Fly through it |
| [Life Is an Ocean](letter/) | 2026-08-15 | A friend's handwritten letter, in Chinese, turned into a tunnel of its own characters. Text used with permission |
| [Kaleidoscope](kaleidoscope/) | 2026-08-15 | Mirror symmetry, recursive nesting, particle spray. Every parameter is on the panel. Exports 3840 × 3840 PNG |

## Conventions

- One directory per work. The URL is `/designstudio/<directory>/`
- Pages are self-contained: CSS, scripts and media inlined. They open offline and make no outside requests
- The footer carries two things only: `Tony Xin` and the publication date
- Run the gate before pushing. **If it fails, do not push:**

```bash
bash scripts/check-publish.sh
```

Source comments are in Chinese. They are maintenance notes, not part of the site.
