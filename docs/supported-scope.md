# Supported scope

This statement describes the implemented, unreleased Useful beta. It is not a
claim of general SysML simulation or complete Modelica support. Read each run's
recorded settings, initialization and approximation details.

| Area | Implemented scope |
| --- | --- |
| Physical simulation | Scalar assemblies of explicitly bound Modelica components; authored scalar parameters and constant Real inputs |
| Component libraries | Modelica Standard Library 4.1.0 and the Elan8 Modelica package; the SysML-only RC example uses Elan8 electronics library 0.6.0 |
| Behaviour | Published SysML state machines, or an explicitly configured Wasm driver with fuel and memory limits |
| Coupling | Sampled coupling at discrete events and requested observations; no continuous crossing-time error bound |
| Verification | Authored assertions evaluated on executed observations; physical stimuli can wait and assertions read final-time values |
| Initial values | Authored component-state values become fixed Modelica starts with unit conversion; initialization details remain in the run record |
| Evidence | CSV trajectories, JSON run records and per-case verdict records with model and engine provenance |

The included RC and mass-spring-damper examples have analytic reference equations.
The engine also has RC/RLC, pendulum and component regressions. Passing those
examples does not establish that every class in MSL or every Elan8 domain part
is supported. Treat a component not covered by a tested example as an advanced
integration requiring its own reference result. The two older starter models
still include local `.mo` classes; the domain RC model uses only supplied parts.

Current limits:

- No continuous zero-crossing detection or plant-triggered Wasm callbacks.
  A sampled threshold transition can occur after the continuous crossing.
- No array/non-scalar SysML occurrences, array or non-Real Modelica inputs,
  or general FMI integration.
- Physical verification stimuli only wait. Assertions are checked at the end
  time; quantity comparisons currently need the Modelica variable's unit spelling.
- Avoid connection-end part names `source` and `target`; those words refer to
  the connection's own ends inside a connection.
- Supported SI prefixes and product/quotient powers convert explicitly. Unknown
  unit spellings match only themselves; this is not a general unit-algebra engine.
- Embedded execution is trusted native code without a hard timeout, memory bound
  or process-crash isolation. Process mode is an explicit alternative, requiring
  a separately installed matching Rumoca executable. No automatic fallback occurs.

Unsupported models, missing inputs and backend failures must produce errors,
not plausible replacement trajectories or passing verdicts. Retain explicit
initialization warnings and failed/inconclusive cases when assessing evidence.
