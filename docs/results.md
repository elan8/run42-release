# Results and verification

`run42 run --out rc` writes two files:

- `rc.csv`: trajectory samples, with time followed by named component variables.
- `rc.run.json`: the run's model/publication identity, source and library
  fingerprints, actual engine/backend, solver settings, input values,
  initialization information, omitted connections and execution provenance.

Keep both. A plot without its run record loses the information needed to assess
and reproduce it. Changing a source file during execution invalidates the run.

`run42 verify` writes per-case verdict records. `pass` means the executed
observations satisfied the authored assertions; `fail` means they did not.
An unsupported or failed execution is `error`, and cases that cannot be judged
must remain explicit. Inspect all records and their details; do not infer
success merely from an output file existing.

For a physical case, the record includes the observed values, units, final time,
composition and engine. Assertions currently evaluate at the final time and
require matching unit spellings. A passing assertion such as `v >= 4.9 V` is
evidence for that modeled condition and configuration, not proof of every
operating condition or hardware behaviour.

Sampled coupling records the observation boundaries and absence of a continuous
crossing-time error bound. Embedded engine execution has no hard timeout or
crash isolation. See the full [supported scope](supported-scope.md).
