# Run42 user guide

Run42 executes SysML v2 behaviour and simulates assemblies of scalar Modelica
components. `run42 run` writes a trajectory and a reproducible run record;
`run42 verify` evaluates authored assertions against executed observations.

**Unreleased beta.** These guides describe the implemented beta scope. There is
no published binary release yet. Read the [supported scope](supported-scope.md)
before interpreting results.

- [Installation](installation.md): unpack a complete platform package.
- [Your first simulation](getting-started.md): run a SysML-only RC circuit.
- [Examples](examples.md): electrical and mechanical reference models.
- [Authentication](authentication.md): accounts, API tokens and offline use.
- [Command reference](cli.md): `run`, `verify` and account commands.
- [Results and verification](results.md): trajectories, evidence and verdicts.
- [Troubleshooting](troubleshooting.md): diagnose missing inputs and libraries.

The beta uses embedded Rumoca 0.10.4, Modelica Standard Library 4.1.0 and Elan8
domain library 0.6.0. Keeping the package intact supplies these libraries without
a separate checkout. Writing Modelica is an advanced extension path for a
component type absent from the supplied libraries.
