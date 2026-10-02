#!/usr/bin/env bash
# Add all JLCPCB symbol libraries to the sym-lib-table of a KiCad project.
#
# Usage: bash add_jlcpcb_libs.sh [project_dir]
# project_dir defaults to ../.. (this repo in <project>/libs/JLCPCB-Kicad-Library).
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib_table_common.sh" "${1:-}"

echo "Adding symbol libraries to $PROJECT_DIR/sym-lib-table"
for sym in "$LIB_DIR"/symbols/*.kicad_sym; do
    name="$(basename "$sym" .kicad_sym)"
    add_lib "$PROJECT_DIR/sym-lib-table" sym_lib_table "$name" \
        "\${KIPRJMOD}/$LIB_REL/symbols/$name.kicad_sym"
done
