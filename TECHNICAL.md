# RetroMi-packages — Technical Reference

> Aide-mémoire complet pour maintenir ce dépôt. Destiné à un développeur ou une IA
> qui reprendrait le projet sans historique des conversations.

## Vue d'ensemble

Ce dépôt pré-compile **tous les émulateurs et outils** pour le projet [RetroMi](https://github.com/Yumi-Lab/RetroMi) (station de jeu rétro sur SmartPi One, AllWinner H3).

**Avant** : le build image RetroMi compilait RetroArch + tous les cores from source (~12h).
**Maintenant** : tout est pré-compilé ici en 20 groupes parallèles → le build image télécharge les tarballs (~15min).

## Hardware cible

| Board | SoC | Arch | GPU | Driver GPU | Statut |
|-------|-----|------|-----|------------|--------|
| SmartPi One | H3 Cortex-A7 | `armhf` | Mali-400 | Lima (Mesa/KMS) | ✅ production |
| SmartPi 4 | H618 Cortex-A53 | `arm64` | Mali-G31 | Panfrost (Mesa/KMS) | 🔵 futur |

**Point critique** : le Mali-400 utilise le driver open-source **Lima** via Mesa (EGL/KMS),
**PAS** le driver propriétaire Mali fbdev. Cette distinction est la source de 90% des bugs historiques.

## Architecture 3 couches (RetroMi)

```
Layer 1 : Armbian Bookworm server (SmartPi-armbian v1.6.0) — rarement rebuild
Layer 2 : RetroMi-packages (CE DÉPÔT) — 20 groupes pré-compilés
Layer 3 : Modules RetroMi (themes, config, controllers...) — rebuild ~15min
```

## Les 20 groupes

| Groupe | Contenu | Temps QEMU |
|--------|---------|------------|
| `retroarch` | RetroArch + SDL2 + assets (KMS/EGL, sans mali fbdev) | ~26 min |
| `arcade` | FinalBurn Neo | ~3h |
| `arcade-compat` | MAME 2003+, 2000, 2010, FBA 2012 | ~5h |
| `nintendo` | NES, SNES, GB, GBC, GBA (14 cores) | ~2h |
| `n64` | N64, PC Engine | ~1h |
| `sega` | Mega Drive, SMS, Game Gear, Sega CD, 32X, Neo Geo CD | ~1h |
| `sony` | PlayStation 1 | ~30 min |
| `psp` | PlayStation Portable | ~1h |
| `misc` | Doom, Quake, Atari, Pico-8, etc. (17 cores) | ~2h |
| `openbor` | Beat 'em up engine (SDL2, no OpenGL) | ~15 min |
| `scummvm` | Point & click adventures | ~33h (runner self-hosted) |
| `dosbox` | DOSBox Pure | ~2h |
| `portables` | NGP, Lynx, VB, WonderSwan, etc. (19 cores) | ~1h |
| `computers` | C64, MSX, ZX Spectrum, etc. (12 cores) | ~2h |
| `amiga` | Amiga 500/1200 | ~1h |
| `japan-computers` | PC-98, PC-88, X68000, X1 | ~1h |
| `heavy` | DS, Dreamcast, Saturn, 3DO, Jaguar | ~3h |
| `emulationstation` | EmulationStation frontend (compilé natif H3) | ~15 min |
| `moonlight` | PC game streaming (NVIDIA/Sunshine) | ~5 min |
| `skyscraper` | Metadata/artwork scraper (ScreenScraper API) | ~5 min |

## Fichiers clés

```
scripts/build-group.sh              # Script principal — tourne dans Docker QEMU
groups/*.txt                         # 1 fichier par groupe — liste des packages
.github/workflows/_build-group.yml   # Template réutilisable (appelé par tous les builds)
.github/workflows/build-*.yml        # 1 workflow par groupe
.github/workflows/release.yml        # Collecte les artifacts → crée la Release GitHub
```

## Comment fonctionne un build

```
GitHub Actions → Docker debian:bookworm --platform linux/arm/v7 (QEMU)
  → build-group.sh <group>
    → apt-get install deps
    → git clone Yumi-Lab/RetroPie-Setup (branche yumi-armhf)
    → pour chaque package dans groups/<group>.txt :
        __user=pi bash retropie_packages.sh <package> _source_
    → tar -czf packages-<group>-armhf.tar.gz /opt/retropie/
```

### Point clé : `_source_` obligatoire

`retropie_packages.sh <pkg>` sans argument utilise le mode `_auto_` qui tente de
télécharger un binaire pré-compilé depuis le serveur RetroPie. Ces binaires sont
compilés pour RPi (pas SmartPi/H3). Le flag `_source_` force la compilation from source.

## Le problème Mali fbdev (résolu)

### Contexte

RetroPie-Setup a été conçu pour le Raspberry Pi et les boards avec le driver Mali
propriétaire (fbdev). Sur Armbian/SmartPi, le GPU utilise **Lima** (driver open-source
Mesa) avec rendu **EGL/KMS** — pas le framebuffer Mali.

### Symptômes si mal configuré

- **SDL2 compilé avec `--enable-video-mali`** → ES écran noir (backend fbdev absent)
- **RetroArch compilé avec `--enable-mali_fbdev`** → crash au lancement des jeux
- **GLSL shaders** → incompatibles Lima/GLES 2.0 → RetroArch quitte immédiatement

### Solution en place (3 niveaux)

#### 1. RetroPie-Setup `yumi-armhf` (fix racine)

**`scriptmodules/system.sh`** — détection via apt :
```bash
function platform_armv7-mali() {
    cpu_armv7
    __platform_flags+=(mali gles)
    # Si mali-fbdev n'existe pas → Mesa/Lima → KMS/EGL
    if ! apt-cache show mali-fbdev &>/dev/null; then
        __platform_flags+=(kms mesa)
    fi
}
```

**`retroarch.sh` et `sdl2.sh`** — guards `! isPlatform "kms"` :
```bash
isPlatform "mali" && ! isPlatform "kms" && depends+=(mali-fbdev)
isPlatform "mali" && ! isPlatform "kms" && params+=(--enable-mali_fbdev)
isPlatform "mali" && ! isPlatform "kms" && conf_flags+=("--enable-video-mali" ...)
```

**`sdl2.sh`** — fix Bookworm dans `build_sdl2()` :
```bash
sed -i 's/fcitx-libs-dev//' ./debian/control
sed -i 's/libgl1-mesa-dev/libgl-dev/g' ./debian/control
```

#### 2. RetroMi-packages `build-group.sh` (QEMU)

Rien de spécial — la détection apt fonctionne aussi dans Docker (`mali-fbdev` n'existe
pas dans les repos Debian Bookworm). Pas de sed, pas de hack.

#### 3. RetroMi `start_chroot_script` (build image)

`export __platform="armv7-mali"` suffit. La détection apt dans yumi-armhf fait le reste.

### Pourquoi `apt-cache` et pas `/sys/module/lima` ?

`/sys` est en read-only (ou absent) dans Docker/QEMU. `apt-cache show mali-fbdev`
fonctionne partout : vrai hardware, QEMU chroot, Docker container.
`mali-fbdev` n'a jamais existé dans les repos Debian/Ubuntu/Armbian — le check est
fiable à 100% comme proxy "est-ce qu'on est sur du Mali propriétaire ?".

## Packages Bookworm (noms corrigés)

Debian Bookworm a renommé/supprimé certains paquets :

| Ancien (Buster/Bullseye) | Nouveau (Bookworm) | Impact |
|---|---|---|
| `fcitx-libs-dev` | Supprimé (fcitx5) | Retiré des deps SDL2 |
| `libgl1-mesa-dev` | `libgl-dev` (transitional) | Corrigé dans sdl2.sh |
| `libegl1-mesa-dev` | `libegl-dev` (transitional) | Corrigé dans sdl2.sh |
| `libgles2-mesa-dev` | `libgles-dev` (transitional) | Corrigé dans retroarch.sh |

## Frontends incompatibles H3

Ces frontends ont été testés et sont **incompatibles** avec Mali-400 (GLES 2.0 only) :

| Frontend | Flag RetroPie | Raison |
|---|---|---|
| attractmode | `!mali` | SFML → OpenGL desktop obligatoire |
| pegasus-fe | `!mali` | Qt/QML → OpenGL desktop obligatoire |
| mehstation | `nobin` | Package RetroPie cassé (dpkg Build-Depends) |

**EmulationStation** est le seul frontend viable sur H3 (utilise GLES 2.0).

## Runners self-hosted

| Runner | Où | Pour quoi |
|---|---|---|
| `yumi-usa-server` (108.175.12.160) | Debian 13 trixie | ScummVM (~33h) |
| `yumi-fr-smartpi` (vpn.yumi-lab.com) | SmartPi natif H3 | EmulationStation (natif, pas QEMU) |

## Maintenance courante

### Rebuilder un groupe
```bash
gh workflow run build-<group>.yml --repo Yumi-Lab/RetroMi-packages \
  -f version=X.Y.Z -f arch=armhf -f distro=bookworm
```

### Publier une release (prend les derniers artifacts de chaque groupe)
```bash
gh workflow run release.yml --repo Yumi-Lab/RetroMi-packages \
  -f version=X.Y.Z -f arch=armhf -f distro=bookworm
```

### Ajouter un nouveau package
1. Identifier le groupe → ajouter dans `groups/xxx.txt`
2. Ou créer un nouveau groupe : `groups/nouveau.txt` + `build-nouveau.yml`
3. Mettre à jour `release.yml` : `PKG_GROUPS`, `GROUP_COUNT`, `GROUP_LABELS`
4. Rebuilder le groupe → relancer release

### Passer à Trixie
```bash
# Tous les builds avec -f distro=trixie
# ⚠️ Tester d'abord un seul groupe (retroarch) avant de tout rebuilder
```

## Repos liés

| Repo | Rôle |
|---|---|
| [Yumi-Lab/RetroMi](https://github.com/Yumi-Lab/RetroMi) | Builder image Armbian (Layer 3) |
| [Yumi-Lab/RetroPie-Setup](https://github.com/Yumi-Lab/RetroPie-Setup) (`yumi-armhf`) | Fork RetroPie avec fixes Lima/Bookworm |
| [Yumi-Lab/SmartPi-armbian](https://github.com/Yumi-Lab/SmartPi-armbian) | Image base Armbian (Layer 1) |
| [Yumi-Lab/RetroMi-games](https://github.com/Yumi-Lab/RetroMi-games) | ROMs homebrew + ports data |
