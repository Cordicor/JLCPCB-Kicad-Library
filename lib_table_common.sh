# Shared helpers for add_jlcpcb_libs.sh and add_jlcpcb_library_to_project.sh.
# Meant to be sourced, not executed.

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Default project dir assumes this repo lives in <project>/libs/JLCPCB-Kicad-Library
PROJECT_DIR="$(cd "${1:-$LIB_DIR/../..}" && pwd)"
# Path of this repo as seen from the project, e.g. libs/JLCPCB-Kicad-Library
LIB_REL="$(realpath --relative-to="$PROJECT_DIR" "$LIB_DIR")"

# add_lib <table file> <sym_lib_table|fp_lib_table> <library name> <uri>
# Creates the table if it is missing and skips libraries that are already listed.
add_lib() {
    local table="$1" root="$2" name="$3" uri="$4"

    if [ ! -f "$table" ]; then
        printf '(%s\n  (version 7)\n)\n' "$root" > "$table"
    fi

    if grep -qE "\(name \"?${name}\"?\)" "$table"; then
        echo "  already present: $name"
        return
    fi

    # Insert the new entry in front of the closing parenthesis of the table
    ENTRY="  (lib (name \"$name\")(type \"KiCad\")(uri \"$uri\")(options \"\")(descr \"\"))" \
    awk '
        { lines[NR] = $0 }
        /^\)[[:space:]]*$/ { last = NR }
        END {
            if (!last) exit 1
            for (i = 1; i <= NR; i++) {
                if (i == last) print ENVIRON["ENTRY"]
                print lines[i]
            }
        }
    ' "$table" > "$table.tmp" || {
        rm -f "$table.tmp"
        echo "error: could not find the closing ')' in $table" >&2
        return 1
    }
    mv "$table.tmp" "$table"
    echo "  added: $name"
}
