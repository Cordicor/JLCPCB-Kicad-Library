#!/usr/bin/env bash
# Set up the JLCPCB library (used as a git submodule) in a KiCad project:
#   1. add the symbol libraries to sym-lib-table
#   2. add the footprint library to fp-lib-table
#   3. point the 3D-model paths of the footprints at the submodule
# See README_GIT_SUBMODULE.md.
#
# Usage: bash add_jlcpcb_library_to_project.sh [project_dir]
# project_dir defaults to ../.. (this repo in <project>/libs/JLCPCB-Kicad-Library).
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib_table_common.sh" "${1:-}"

if [ "$LIB_REL" != "libs/JLCPCB-Kicad-Library" ]; then
    echo "warning: library is at '$LIB_REL' inside the project, but the 3D-model paths" >&2
    echo "         in the footprints expect 'libs/JLCPCB-Kicad-Library'." >&2
fi

bash "$LIB_DIR/add_jlcpcb_libs.sh" "$PROJECT_DIR"

echo "Adding footprint library to $PROJECT_DIR/fp-lib-table"
add_lib "$PROJECT_DIR/fp-lib-table" fp_lib_table PCM_JLCPCB \
    "\${KIPRJMOD}/$LIB_REL/footprints/JLCPCB.pretty"

bash "$LIB_DIR/fix_3d_model_paths.sh"

echo "Done. Restart KiCad to load the libraries."
