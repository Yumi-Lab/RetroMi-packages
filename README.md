# RetroMi Packages

Pre-compiled RetroArch and libretro emulator cores for **SmartPi One** (AllWinner H3 — ARMv7 armhf).

These packages are used by the [RetroMi](https://github.com/Yumi-Lab/RetroMi) image builder to avoid compiling emulators from source during the image build, reducing build time from ~4 hours to ~15 minutes.

## Package groups

| Group | Contents | Est. compile time |
|-------|----------|-------------------|
| `retroarch` | RetroArch frontend + assets | ~30 min |
| `arcade` | lr-fbneo, lr-mame2003-plus, lr-mame2000, lr-fbalpha2012 | ~60 min |
| `nintendo` | NES (fceumm, nestopia, mesen, quicknes), SNES (snes9x2010), GB/GBC (gambatte, tgbdual), GBA (mgba, gpsp, vba-next), N64 (mupen64plus, mupen64plus-next), PC Engine (beetle-pce-fast) | ~60 min |
| `sega` | Genesis/MD/CD/GG (genesis-plus-gx), Sega CD/32X (picodrive) | ~20 min |
| `sony` | PS1 (pcsx-rearmed, beetle-psx), PSP (ppsspp) | ~50 min |
| `misc` | Doom, Quake, Cave Story, ScummVM, DOS, Atari 2600, Neo Geo Pocket, Atari Lynx, Virtual Boy, Pokemon Mini, Game & Watch, Atari 7800, Odyssey², Vectrex, Fairchild, SMS/GG | ~40 min |
| `computers` | Amiga (uae4arm), C64 (vice), MSX (bluemsx), Atari 8-bit (atari800), Amstrad CPC (caprice32), ZX Spectrum (fuse), ZX81 (lr-81), Thomson (theodore) | ~35 min |
| `heavy` | Nintendo DS (desmume2015), Dreamcast (flycast), Saturn (yabause, kronos, beetle-saturn) | ~90 min |

> ⚠️ Packages in `heavy` may run too slowly on SmartPi One (H3 armhf). Included for completeness.

All 8 groups build **in parallel** → total wall time ≈ longest group (~90 min for `heavy`).

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

1. GitHub Actions launches 8 parallel jobs (one per group)
2. Each job runs inside a `debian:bookworm --platform linux/arm/v7` Docker container
3. Inside the container, YUMI-RETROPIE scripts compile the emulators natively for armhf
4. Each job produces `packages-<group>-armhf.tar.gz` containing `/opt/retropie/`
5. A final job collects all artifacts and creates a GitHub Release

## Usage in RetroMi

The `retropie` module in RetroMi downloads and extracts these packages automatically.
