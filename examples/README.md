# Example models

Two small SysML v2 models that Run42 simulates. Each folder is a complete
workspace: a SysML model that composes parts, and the Modelica file that holds
the parts' equations. Both have analytic solutions that Run42's numerical
regressions check against actual simulation results.

| Folder | Model | What it shows |
| --- | --- | --- |
| `electrical` | `RcCharging::Circuit` | A 5 V source charging a 100 µF capacitor through 10 kΩ. The capacitor voltage rises as 5 V · (1 − e^(−t / 1 s)). |
| `mechanical` | `Oscillator::Oscillator` | A 1 kg mass on a spring and damper, pulled 0.1 m out and released. It oscillates at about 1.6 Hz and the motion dies out within a few seconds. |

Each model also states a requirement and a test case that checks it against a
simulation:

| Folder | Requirement | Assertion |
| --- | --- | --- |
| `electrical` | `chargesInFiveSeconds` | after 5 s, `capacitorVoltage >= 4.9 [V]` (it reaches 4.97 V) |
| `mechanical` | `settlesInThreeSeconds` | after 3 s, `displacement` is within ±1 mm (it is −0.15 mm) |

`domain-rc-circuit` is different: it contains no Modelica at all. It is built from parts of the
Elan8 domain library, which a Run42 release includes, so it runs with no library path. The two
folders above still bring their own Modelica; they move onto domain-library parts next.

## Run them

Keep the unpacked Run42 installation intact, then run from its directory:

```bash
run42 run examples/electrical --root RcCharging::Circuit --t-end 5s --out rc
run42 run examples/mechanical --root Oscillator::Oscillator --t-end 3s --out oscillator
```

Check the requirements:

```bash
run42 verify examples/electrical --out rc-verdicts.json
run42 verify examples/mechanical --out oscillator-verdicts.json
```

Each run writes `<out>.csv`, with one column per variable (for example
`capacitor.v` or `spring.extension`), and `<out>.run.json`, which records the
model, engine and settings that produced it. `verify` writes one record per
test case with its verdict (`pass`, `fail` or `error`), the requirements it
verifies, the simulated values the assertions read, and the same provenance.

## Report the verdict with Doc42

`examples/electrical/Report.sysml` is a [Doc42](https://elan8.com/products/doc42)
verification report. It shows each requirement with the verdict of the case that
verifies it, and the case results with their time and detail. Write the verdicts
next to it, then build the report:

```bash
run42 verify examples/electrical --out examples/electrical/verdicts.json
doc42 build examples/electrical --doc RcReports::verificationReport --out report
```

Run42 ignores the report view, so one folder holds the model and its document. A
case with no record in `verdicts.json` shows `not run` in the report, never `pass`.
Rerun both commands after changing the model: the report shows what the last
`run42 verify` recorded. The requirement column `verified-by / verdict` needs a
Doc42 release with Run42 verdict-evidence support.

## How a model connects to its equations

- A `part def` names its Modelica model with `@ModelicaModel { className; resourceUri; }`.
  The path is relative to the SysML file.
- Attribute names match Modelica parameter names, and each value carries its
  unit, for example `10 [kilo * ohm]`. Run42 checks the unit against the Modelica
  parameter's unit and converts between them.
- Port names match Modelica connector names. A SysML `connect` between two ports
  becomes a Modelica `connect` between the matching connectors.

## How a test case reads simulated values

The case's subject is the assembly itself, here `subject circuit : Circuit;`. Because
`Circuit` has no state machine, `run42 verify` composes and simulates it:

- The stimulus may only wait: `action switchOn { accept after 5 [s]; }` runs the
  simulation for 5 s.
- An assertion reads attributes of the assembly. Each one it reads must either
  have a value or be bound to a component variable, for example
  `bind capacitorVoltage = capacitor.v;`. The component declares that attribute
  (`attribute v : ElectricPotentialValue;`), and the name matches the Modelica
  variable.
- The value carries the Modelica variable's unit, so declare one
  (`Real v(unit = "V")`) and compare with the same spelling (`4.9 [V]`).
- A case whose assertion fails is `fail`. A case that cannot be run or judged,
  for example because an attribute is not bound, is `error`, never `pass`.

## Limits

- Do not name a part `source` or `target`. Inside a `connect`, those names refer
  to the connection's own ends.
