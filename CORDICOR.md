# JLCPCB-KiCad-Library as a GIT Submodule

We will assume your project looks like:

```
my_kicad_project
├── .git
├── my_kicad_project-backups
├── my_kicad_project.kicad_pcb
├── my_kicad_project.kicad_prl
├── my_kicad_project.kicad_pro
├── my_kicad_project.kicad_sch
├── fp-info-cache
├── fp-lib-table
├── libs
│   ├── JLCPCB-Kicad-Library
│   └── some_other_lib
├── README.md
└── sym-lib-table
```

and you have successfully added the `JLCPCB-Kicad-Library` into `my_kicad_project/libs/JLCPCB-Kicad-Library` as a git-submodule with branch `cordicor`. 
To make everything work, you need to do three steps, which are automated by running `bash add_jlcpcb_library_to_project.sh`. To do it manually, follow the next steps.

# Steps for every to work as usual

1. add the symbolic libraries
2. add the footprint library
3. change the path to the 3D-models within the footprint library

## Add the symbolic libraries 

Within your KiCAD project, go to `preferences -> Manage Symbol Libraries -> Project Specific Libraries` and add all libraries as in the following table,
or run `add_jlcpcb_libs.sh` which does the same thing.

| KiCAD Symbol Library Name | Path |
|---|---|
| JLCPCB-Analog | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Analog.kicad_sym |
| JLCPCB-Capacitors | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Capacitors.kicad_sym |
| JLCPCB-Connectors_Buttons | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Connectors_Buttons.kicad_sym |
| JLCPCB-Crystals | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Crystals.kicad_sym |
| JLCPCB-Diode-Packages | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Diode-Packages.kicad_sym |
| JLCPCB-Diodes | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Diodes.kicad_sym |
| JLCPCB-Extended | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Extended.kicad_sym |
| JLCPCB-ICs | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-ICs.kicad_sym |
| JLCPCB-Inductors | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Inductors.kicad_sym |
| JLCPCB-Interface | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Interface.kicad_sym |
| JLCPCB-Manufacturing | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Manufacturing.kicad_sym |
| JLCPCB-MCUs | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-MCUs.kicad_sym |
| JLCPCB-Memory | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Memory.kicad_sym |
| JLCPCB-Optocouplers | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Optocouplers.kicad_sym |
| JLCPCB-Power | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Power.kicad_sym |
| JLCPCB-Resistors | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Resistors.kicad_sym |
| JLCPCB-Transformers | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Transformers.kicad_sym |
| JLCPCB-Transistor-Packages | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Transistor-Packages.kicad_sym |
| JLCPCB-Transistors | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Transistors.kicad_sym |
| JLCPCB-Variable-Resistors | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/symbols/JLCPCB-Variable-Resistors.kicad_sym |

## Add the footprint library

Now within KiCAD, go to `preferences -> Manage Footprint Libraries -> Project Specific Libraries` and add

| KiCAD Symbol Library Name | Path |
|---|---|
| PCM_JLCPCB | ${KIPRJMOD}/libs/JLCPCB-Kicad-Library/footprints/JLCPCB.pretty |


## Change the path to the 3D-models within the footprint library

Now, this part is already done in the `git_submodule`, so you don't have to do this. But it is:

```
cd my_kicad_project/libs/JLCPCB-Kicad-Library
```

and 

```
find footprints -name "*.kicad_mod" -exec sed -i 's|${KICAD8_3RD_PARTY}/3dmodels/com_github_CDFER_JLCPCB-Kicad-Library/JLCPCB.3dshapes|${KIPRJMOD}/libs/JLCPCB-Kicad-Library/3dmodels/JLCPCB.3dshapes|g' {} +
```

After re-starting KiCAD, you should be able to use the libraries as usual.

