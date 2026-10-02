#!/usr/bin/env bash
# Point the 3D-model paths of all footprints at the git-submodule location
# (<project>/libs/JLCPCB-Kicad-Library) instead of the KiCad PCM install folder.
# Safe to run repeatedly.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

find footprints -name "*.kicad_mod" -exec sed -i -E \
    's|\$\{KICAD[0-9]+_3RD_PARTY\}/3dmodels/com_github_CDFER_JLCPCB-Kicad-Library/JLCPCB\.3dshapes|${KIPRJMOD}/libs/JLCPCB-Kicad-Library/3dmodels/JLCPCB.3dshapes|g' {} +
