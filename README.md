# RetroMi Packages

Pre-compiled RetroArch and libretro emulator cores for **SmartPi One** (AllWinner H3 — ARMv7 armhf).

These packages are used by the [RetroMi](https://github.com/Yumi-Lab/RetroMi) image builder to avoid compiling emulators from source during the image build, reducing build time from ~4 hours to ~15 minutes.

## Package groups

| Group | Contents | Compilation time |
|-------|----------|-----------------|
| `retroarch` | RetroArch frontend + assets | ~30 min |
| `arcade` | FinalBurn Neo, MAME 2003 Plus | ~60 min |
| `nintendo` | NES, SNES, GBA (mgba + gpsp), GB/GBC, N64 (mupen64plus + next), PC Engine | ~50 min |
| `sega` | Genesis/MD, Sega CD, 32X, Game Gear | ~20 min |
| `sony` | PlayStation 1 | ~25 min |
| `misc` | Doom, Cave Story, ScummVM, DOS, Atari 2600, C64, MSX, SMS/GG, Amiga | ~40 min |

All groups build **in parallel** → total wall time ≈ longest group (~60 min).

## Architecture

- **Target**: ARMv7 32-bit (armhf) — Debian Bookworm
- **Build environment**: Docker `debian:bookworm` with QEMU `linux/arm/v7` emulation
- **Source**: [YUMI-RETROPIE](https://github.com/Yumi-Lab/YUMI-RETROPIE)

## Building

Trigger a release via GitHub Actions:

```
Actions → Build RetroMi Packages → Run workflow → version: X.Y.Z
```

## How it works

1. GitHub Actions launches 5 parallel jobs (one per group)
2. Each job runs inside a `debian:bookworm --platform linux/arm/v7` Docker container
3. Inside the container, YUMI-RETROPIE scripts compile the emulators natively for armhf
4. Each job produces `packages-<group>-armhf.tar.gz` containing `/opt/retropie/`
5. A final job collects all artifacts and creates a GitHub Release

## Usage in RetroMi

The `retropie` module in RetroMi downloads and extracts these packages:

```bash
wget https://github.com/Yumi-Lab/RetroMi-packages/releases/latest/download/packages-retroarch-armhf.tar.gz
tar -xzf packages-retroarch-armhf.tar.gz -C /
# ... repeated for each group
```
