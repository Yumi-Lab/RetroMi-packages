# RetroMi Packages

Pre-compiled RetroArch and libretro emulator cores for **SmartPi One** (AllWinner H3 — ARMv7 armhf).

These packages are used by the [RetroMi](https://github.com/Yumi-Lab/RetroMi) image builder to avoid compiling emulators from source during the image build, reducing build time from ~12 hours to ~15 minutes.

## Package groups

All 16 groups build **in parallel** → total wall time ≈ longest group.

| Group | Packages | Systems |
|-------|----------|---------|
| `retroarch` | RetroArch + assets | Frontend |
| `arcade` | lr-fbneo | Arcade / Neo Geo / CPS1-2-3 |
| `arcade-compat` | lr-mame2003-plus, lr-mame2003, lr-mame2000, lr-mame2010, lr-fbalpha2012 | Arcade (MAME compat) |
| `nintendo` | lr-fceumm, lr-nestopia, lr-mesen, lr-quicknes, lr-snes9x2010, lr-snes9x, lr-snes9x2005, lr-snes9x2002, lr-gambatte, lr-tgbdual, lr-mgba, lr-gpsp, lr-vba-next | NES / SNES / GB / GBC / GBA |
| `n64` | lr-mupen64plus, lr-mupen64plus-next, lr-parallel-n64, lr-beetle-pce-fast | N64 / PC Engine |
| `sega` | lr-genesis-plus-gx, lr-picodrive, lr-gearsystem, lr-neocd | Mega Drive / Sega CD / 32X / Master System / Game Gear / Neo Geo CD |
| `sony` | lr-pcsx-rearmed, lr-beetle-psx | PlayStation 1 |
| `psp` | lr-ppsspp | PlayStation Portable |
| `misc` | lr-prboom, lr-tyrquake, lr-nxengine, lr-stella2014, lr-stella, lr-smsplus-gx, lr-dosbox, lr-mrboom, lr-retro8, lr-xrick, lr-dinothawr, lr-tic80 | Doom / Quake / Cave Story / Atari 2600 / DOS / divers |
| `scummvm` | lr-scummvm | ScummVM (point & click adventures) |
| `dosbox` | lr-dosbox-pure | DOS (DOSBox Pure) |
| `portables` | lr-beetle-ngp, lr-beetle-lynx, lr-beetle-vb, lr-beetle-wswan, lr-beetle-supergrafx, lr-beetle-pce, lr-beetle-pcfx, lr-pokemini, lr-gw, lr-prosystem, lr-o2em, lr-vecx, lr-freechaf, lr-freeintv, lr-handy | Neo Geo Pocket / Lynx / Virtual Boy / WonderSwan / PC Engine / Pokémon Mini / Game & Watch / Atari 7800 / Odyssey² / Vectrex / Fairchild / Intellivision |
| `computers` | lr-vice, lr-bluemsx, lr-fmsx, lr-atari800, lr-caprice32, lr-fuse, lr-81, lr-theodore, lr-hatari | C64 / MSX / Atari 8-bit / Amstrad CPC / ZX Spectrum / ZX81 / Thomson MO/TO / Atari ST |
| `amiga` | lr-uae4arm, lr-puae, lr-puae2021 | Amiga |
| `japan-computers` | lr-np2kai, lr-quasi88, lr-px68k, lr-x1 | PC-98 / PC-88 / X68000 / Sharp X1 |
| `heavy` | lr-desmume2015, lr-desmume, lr-flycast, lr-flycast-dev, lr-yabause, lr-kronos, lr-beetle-saturn, lr-opera, lr-virtualjaguar | Nintendo DS / Dreamcast / Sega Saturn / 3DO / Atari Jaguar |

> ⚠️ Packages in `heavy` may run too slowly on SmartPi One (H3 armhf). Included for completeness.

## Architecture

- **Target**: ARMv7 32-bit (armhf) — Debian Bookworm
- **Build environment**: Docker `debian:bookworm` with QEMU `linux/arm/v7` emulation
- **Source**: [Yumi-Lab/RetroPie-Setup](https://github.com/Yumi-Lab/RetroPie-Setup)

## Building

Trigger a release via GitHub Actions:

```
Actions → Build RetroMi Packages → Run workflow → version: X.Y.Z
```

## How it works

1. GitHub Actions launches 16 parallel jobs (one per group)
2. Each job runs inside a `debian:bookworm --platform linux/arm/v7` Docker container
3. Inside the container, RetroPie-Setup scripts compile the emulators natively for armhf
4. Each job produces `packages-<group>-armhf.tar.gz` containing `/opt/retropie/`
5. A final job collects all artifacts and creates a GitHub Release

## Usage in RetroMi

The `retropie` module in RetroMi downloads and extracts these packages automatically.
