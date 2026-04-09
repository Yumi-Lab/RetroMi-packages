# RetroMi Packages

Pre-compiled RetroArch and libretro emulator cores for **SmartPi One** (AllWinner H3 — ARMv7 armhf).

These packages are used by the [RetroMi](https://github.com/Yumi-Lab/RetroMi) image builder to avoid compiling emulators from source during the image build, reducing build time from ~12 hours to ~15 minutes.

## Package groups

All 19 groups build **in parallel** → total wall time ≈ longest group.

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
| `misc` | lr-prboom, lr-tyrquake, lr-nxengine, lr-stella2014, lr-stella, lr-smsplus-gx, lr-dosbox, lr-mrboom, lr-retro8, lr-xrick, lr-dinothawr, lr-tic80, lr-fake08, lr-wasm4, lr-easyrpg, lr-onscripter, lr-freej2me | Doom / Quake / Cave Story / Atari 2600 / DOS / Pico-8 / WASM-4 / EasyRPG / Visual novels / Java games |
| `scummvm` | lr-scummvm | ScummVM (point & click adventures) |
| `dosbox` | lr-dosbox-pure | DOS (DOSBox Pure) |
| `portables` | lr-beetle-ngp, lr-beetle-lynx, lr-beetle-vb, lr-beetle-wswan, lr-beetle-supergrafx, lr-beetle-pce, lr-beetle-pcfx, lr-pokemini, lr-gw, lr-prosystem, lr-o2em, lr-vecx, lr-freechaf, lr-freeintv, lr-handy, lr-sameduck, lr-potator, lr-uzem, lr-ardens | Neo Geo Pocket / Lynx / Virtual Boy / WonderSwan / PC Engine / Pokémon Mini / Game & Watch / Atari 7800 / Odyssey² / Vectrex / Fairchild / Intellivision / Mega Duck / Supervision / Uzebox / Arduboy |
| `computers` | lr-vice, lr-bluemsx, lr-fmsx, lr-atari800, lr-caprice32, lr-fuse, lr-81, lr-theodore, lr-hatari, lr-applewin, lr-b2 | C64 / MSX / Atari 8-bit / Amstrad CPC / ZX Spectrum / ZX81 / Thomson MO/TO / Atari ST / Apple II / BBC Micro |
| `amiga` | lr-uae4arm, lr-puae, lr-puae2021 | Amiga |
| `japan-computers` | lr-np2kai, lr-quasi88, lr-px68k, lr-x1 | PC-98 / PC-88 / X68000 / Sharp X1 |
| `heavy` | lr-desmume2015, lr-desmume, lr-flycast, lr-flycast-dev, lr-yabause, lr-kronos, lr-beetle-saturn, lr-opera, lr-virtualjaguar | Nintendo DS / Dreamcast / Sega Saturn / 3DO / Atari Jaguar |
| `openbor` | openbor | Beat 'em up engine (OpenBOR) |
| `emulationstation` | emulationstation | EmulationStation frontend |

> ⚠️ Packages in `heavy` may run too slowly on SmartPi One (H3 armhf). Included for completeness.

---

## Source repositories

| Package | Source repo | Notes |
|---------|-------------|-------|
| **retroarch** | [libretro/RetroArch](https://github.com/libretro/RetroArch) | Frontend for all libretro cores |
| **lr-fbneo** | [libretro/FBNeo](https://github.com/libretro/FBNeo) | Arcade / Neo Geo / CPS |
| **lr-mame2003-plus** | [libretro/mame2003-plus-libretro](https://github.com/libretro/mame2003-plus-libretro) | MAME 2003 Plus |
| **lr-mame2003** | [libretro/mame2003-libretro](https://github.com/libretro/mame2003-libretro) | MAME 2003 |
| **lr-mame2000** | [libretro/mame2000-libretro](https://github.com/libretro/mame2000-libretro) | MAME 2000 |
| **lr-mame2010** | [libretro/mame2010-libretro](https://github.com/libretro/mame2010-libretro) | MAME 2010 |
| **lr-fbalpha2012** | [libretro/fbalpha2012](https://github.com/libretro/fbalpha2012) | FBAlpha 2012 |
| **lr-fceumm** | [libretro/libretro-fceumm](https://github.com/libretro/libretro-fceumm) | NES |
| **lr-nestopia** | [libretro/nestopia](https://github.com/libretro/nestopia) | NES |
| **lr-mesen** | [libretro/Mesen](https://github.com/libretro/Mesen) | NES (accuracy) |
| **lr-quicknes** | [libretro/QuickNES_Core](https://github.com/libretro/QuickNES_Core) | NES (lightweight) |
| **lr-snes9x** | [libretro/snes9x](https://github.com/libretro/snes9x) | SNES |
| **lr-snes9x2010** | [libretro/snes9x2010](https://github.com/libretro/snes9x2010) | SNES (2010) |
| **lr-snes9x2005** | [libretro/snes9x2005](https://github.com/libretro/snes9x2005) | SNES (2005) |
| **lr-snes9x2002** | [libretro/snes9x2002](https://github.com/libretro/snes9x2002) | SNES (2002, lightest) |
| **lr-gambatte** | [libretro/gambatte-libretro](https://github.com/libretro/gambatte-libretro) | GB / GBC |
| **lr-tgbdual** | [libretro/tgbdual-libretro](https://github.com/libretro/tgbdual-libretro) | GB (link cable) |
| **lr-mgba** | [libretro/mgba](https://github.com/libretro/mgba) | GBA |
| **lr-gpsp** | [libretro/gpsp](https://github.com/libretro/gpsp) | GBA (lightweight) |
| **lr-vba-next** | [libretro/vba-next](https://github.com/libretro/vba-next) | GBA |
| **lr-mupen64plus** | [RetroPie/mupen64plus-libretro](https://github.com/RetroPie/mupen64plus-libretro) | N64 |
| **lr-mupen64plus-next** | [libretro/mupen64plus-libretro-nx](https://github.com/libretro/mupen64plus-libretro-nx) | N64 |
| **lr-parallel-n64** | [RetroPie/parallel-n64](https://github.com/RetroPie/parallel-n64) | N64 |
| **lr-beetle-pce-fast** | [libretro/beetle-pce-fast-libretro](https://github.com/libretro/beetle-pce-fast-libretro) | PC Engine (fast) |
| **lr-genesis-plus-gx** | [libretro/Genesis-Plus-GX](https://github.com/libretro/Genesis-Plus-GX) | Mega Drive / Master System / Game Gear / SG-1000 |
| **lr-picodrive** | [libretro/picodrive](https://github.com/libretro/picodrive) | Mega Drive / 32X / Sega CD |
| **lr-gearsystem** | [drhelius/Gearsystem](https://github.com/drhelius/Gearsystem) | Master System / Game Gear |
| **lr-neocd** | [libretro/neocd_libretro](https://github.com/libretro/neocd_libretro) | Neo Geo CD |
| **lr-pcsx-rearmed** | [libretro/pcsx_rearmed](https://github.com/libretro/pcsx_rearmed) | PlayStation 1 (ARM optimized) |
| **lr-beetle-psx** | [libretro/beetle-psx-libretro](https://github.com/libretro/beetle-psx-libretro) | PlayStation 1 (accuracy) |
| **lr-ppsspp** | [hrydgard/ppsspp](https://github.com/hrydgard/ppsspp) | PlayStation Portable |
| **lr-prboom** | [libretro/libretro-prboom](https://github.com/libretro/libretro-prboom) | Doom |
| **lr-tyrquake** | [libretro/tyrquake](https://github.com/libretro/tyrquake) | Quake |
| **lr-nxengine** | [libretro/nxengine-libretro](https://github.com/libretro/nxengine-libretro) | Cave Story |
| **lr-stella2014** | [libretro/stella2014-libretro](https://github.com/libretro/stella2014-libretro) | Atari 2600 (2014) |
| **lr-stella** | [stella-emu/stella](https://github.com/stella-emu/stella) | Atari 2600 |
| **lr-smsplus-gx** | [libretro/smsplus-gx](https://github.com/libretro/smsplus-gx) | Master System / Game Gear |
| **lr-dosbox** | [libretro/dosbox-libretro](https://github.com/libretro/dosbox-libretro) | DOS (DOSBox) |
| **lr-mrboom** | [libretro/mrboom-libretro](https://github.com/libretro/mrboom-libretro) | Mr. Boom (Bomberman clone) |
| **lr-retro8** | [libretro/retro8](https://github.com/libretro/retro8) | PICO-8 (open impl.) |
| **lr-fake08** | [jtothebell/fake-08](https://github.com/jtothebell/fake-08) | PICO-8 (compatible player) |
| **lr-xrick** | [libretro/xrick-libretro](https://github.com/libretro/xrick-libretro) | Rick Dangerous |
| **lr-dinothawr** | [libretro/Dinothawr](https://github.com/libretro/Dinothawr) | Dinothawr (puzzle platformer) |
| **lr-tic80** | [libretro/TIC-80](https://github.com/libretro/TIC-80) | TIC-80 fantasy console |
| **lr-wasm4** | [aduros/wasm4](https://github.com/aduros/wasm4) | WASM-4 fantasy console |
| **lr-easyrpg** | [EasyRPG/Player](https://github.com/EasyRPG/Player) | RPG Maker 2000/2003 games |
| **lr-onscripter** | [libretro/onscripter-libretro](https://github.com/libretro/onscripter-libretro) | NScripter visual novels |
| **lr-freej2me** | [hex007/freej2me](https://github.com/hex007/freej2me) | Java mobile games |
| **lr-scummvm** | [libretro/scummvm](https://github.com/libretro/scummvm) | Point & click adventures |
| **lr-dosbox-pure** | [libretro/dosbox-pure](https://github.com/libretro/dosbox-pure) | DOS (DOSBox Pure) |
| **lr-beetle-ngp** | [libretro/beetle-ngp-libretro](https://github.com/libretro/beetle-ngp-libretro) | Neo Geo Pocket / Color |
| **lr-beetle-lynx** | [libretro/beetle-lynx-libretro](https://github.com/libretro/beetle-lynx-libretro) | Atari Lynx |
| **lr-beetle-vb** | [libretro/beetle-vb-libretro](https://github.com/libretro/beetle-vb-libretro) | Virtual Boy |
| **lr-beetle-wswan** | [libretro/beetle-wswan-libretro](https://github.com/libretro/beetle-wswan-libretro) | WonderSwan / Color |
| **lr-beetle-supergrafx** | [libretro/beetle-supergrafx-libretro](https://github.com/libretro/beetle-supergrafx-libretro) | PC Engine SuperGrafx |
| **lr-beetle-pce** | [libretro/beetle-pce-libretro](https://github.com/libretro/beetle-pce-libretro) | PC Engine (accuracy) |
| **lr-beetle-pcfx** | [libretro/beetle-pcfx-libretro](https://github.com/libretro/beetle-pcfx-libretro) | PC-FX |
| **lr-pokemini** | [libretro/pokemini](https://github.com/libretro/pokemini) | Pokémon Mini |
| **lr-gw** | [libretro/gw-libretro](https://github.com/libretro/gw-libretro) | Game & Watch |
| **lr-prosystem** | [libretro/prosystem-libretro](https://github.com/libretro/prosystem-libretro) | Atari 7800 |
| **lr-o2em** | [libretro/libretro-o2em](https://github.com/libretro/libretro-o2em) | Odyssey² / Videopac |
| **lr-vecx** | [libretro/libretro-vecx](https://github.com/libretro/libretro-vecx) | Vectrex |
| **lr-freechaf** | [libretro/FreeChaF](https://github.com/libretro/FreeChaF) | Fairchild Channel F |
| **lr-freeintv** | [libretro/FreeIntv](https://github.com/libretro/FreeIntv) | Intellivision |
| **lr-handy** | [libretro/libretro-handy](https://github.com/libretro/libretro-handy) | Atari Lynx (Handy) |
| **lr-sameduck** | [libretro/SameDuck](https://github.com/libretro/SameDuck) | Mega Duck |
| **lr-potator** | [libretro/potator](https://github.com/libretro/potator) | Watara Supervision |
| **lr-uzem** | [libretro/libretro-uzem](https://github.com/libretro/libretro-uzem) | Uzebox |
| **lr-ardens** | [tiberiusbrown/ardens](https://github.com/tiberiusbrown/ardens) | Arduboy |
| **lr-vice** | [libretro/vice-libretro](https://github.com/libretro/vice-libretro) | Commodore 64 / VIC-20 / C128 / PET |
| **lr-bluemsx** | [libretro/blueMSX-libretro](https://github.com/libretro/blueMSX-libretro) | MSX / MSX2 / ColecoVision / SG-1000 |
| **lr-fmsx** | [libretro/fmsx-libretro](https://github.com/libretro/fmsx-libretro) | MSX / MSX2 |
| **lr-atari800** | [libretro/libretro-atari800](https://github.com/libretro/libretro-atari800) | Atari 800 / 5200 |
| **lr-caprice32** | [libretro/libretro-cap32](https://github.com/libretro/libretro-cap32) | Amstrad CPC |
| **lr-fuse** | [libretro/fuse-libretro](https://github.com/libretro/fuse-libretro) | ZX Spectrum |
| **lr-81** | [libretro/81-libretro](https://github.com/libretro/81-libretro) | ZX81 |
| **lr-theodore** | [Zlika/theodore](https://github.com/Zlika/theodore) | Thomson MO/TO |
| **lr-hatari** | [libretro/hatari](https://github.com/libretro/hatari) | Atari ST |
| **lr-applewin** | [audetto/AppleWin](https://github.com/audetto/AppleWin) | Apple II |
| **lr-b2** | [tom-seddon/b2](https://github.com/tom-seddon/b2) | BBC Micro |
| **lr-uae4arm** | [Chips-fr/uae4arm-rpi](https://github.com/Chips-fr/uae4arm-rpi) | Amiga (ARM optimized) |
| **lr-puae** | [libretro/libretro-uae](https://github.com/libretro/libretro-uae) | Amiga |
| **lr-puae2021** | [libretro/libretro-uae](https://github.com/libretro/libretro-uae) `2.6.1` | Amiga (2021) |
| **lr-np2kai** | [AZO234/NP2kai](https://github.com/AZO234/NP2kai) | PC-98 |
| **lr-quasi88** | [libretro/quasi88-libretro](https://github.com/libretro/quasi88-libretro) | PC-88 |
| **lr-px68k** | [libretro/px68k-libretro](https://github.com/libretro/px68k-libretro) | Sharp X68000 |
| **lr-x1** | [libretro/xmil-libretro](https://github.com/libretro/xmil-libretro) | Sharp X1 |
| **lr-desmume2015** | [libretro/desmume2015](https://github.com/libretro/desmume2015) | Nintendo DS (2015, lightweight) |
| **lr-desmume** | [libretro/desmume](https://github.com/libretro/desmume) | Nintendo DS |
| **lr-flycast** | [libretro/flycast](https://github.com/libretro/flycast) | Sega Dreamcast / NAOMI |
| **lr-flycast-dev** | [flyinghead/flycast](https://github.com/flyinghead/flycast) | Sega Dreamcast (dev branch) |
| **lr-yabause** | [libretro/yabause](https://github.com/libretro/yabause) | Sega Saturn |
| **lr-kronos** | [libretro/yabause](https://github.com/libretro/yabause) `kronos` | Sega Saturn (Kronos) |
| **lr-beetle-saturn** | [libretro/beetle-saturn-libretro](https://github.com/libretro/beetle-saturn-libretro) | Sega Saturn (accuracy) |
| **lr-opera** | [libretro/opera-libretro](https://github.com/libretro/opera-libretro) | 3DO |
| **lr-virtualjaguar** | [libretro/virtualjaguar-libretro](https://github.com/libretro/virtualjaguar-libretro) | Atari Jaguar |
| **openbor** | [DCurrent/openbor](https://github.com/DCurrent/openbor) | Beat 'em up engine — SDL2, no OpenGL |
| **emulationstation** | [RetroPie/EmulationStation](https://github.com/RetroPie/EmulationStation) | ES frontend — compiled natively on H3 runner |

---

## Architecture

- **Target**: ARMv7 32-bit (armhf) — Debian Bookworm
- **Build environment**: Docker `debian:bookworm` with QEMU `linux/arm/v7` emulation
- **RetroPie layer**: [Yumi-Lab/YUMI-RETROPIE](https://github.com/Yumi-Lab/YUMI-RETROPIE) (fork of RetroPie-Setup)

## Building

Trigger a release via GitHub Actions:

```
Actions → Build RetroMi Packages → Run workflow → version: X.Y.Z
```

## How it works

1. GitHub Actions launches 19 parallel jobs (one per group)
2. Each job runs inside a `debian:bookworm --platform linux/arm/v7` Docker container
3. Inside the container, YUMI-RETROPIE scripts compile the emulators natively for armhf
4. Each job produces `packages-<group>-armhf.tar.gz` containing `/opt/retropie/`
5. A final job collects all artifacts and creates a GitHub Release

## Usage in RetroMi

The `retropie` module in RetroMi downloads and extracts these packages automatically.
