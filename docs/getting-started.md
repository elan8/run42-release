# Your first simulation

After [installation](installation.md), open a terminal in the unpacked Run42
directory. The commands below assume `run42` is on PATH. Otherwise use
`./run42` on Linux or `./run42.exe` in Windows PowerShell.

```sh
run42 --version
run42 login
run42 run examples/domain-rc-circuit --root DomainRc::Circuit --t-end 5s --out rc
```

Paste an Elan8 API token when prompted. Your account needs Run42 access.

The [RC model](../examples/domain-rc-circuit/rc-circuit.sysml) is entirely SysML.
It imports the supplied Elan8 electronics parts: a 5 V voltage source, a
10 kΩ resistor, a 100 µF capacitor and ground. The library binds their physics
to Modelica; you do not write or download a matching Modelica model.

The command writes `rc.csv` and `rc.run.json`. Plot `capacitor.v` against `t`
in the CSV. For these component values, the analytic reference is
`v(t) = 5 (1 - exp(-t / 1 s)) V`, about 4.966 V at 5 s. That is the reference
equation, not a substitute for executing the simulation. Numerical results
depend on the recorded solver settings; the default run uses rtol and atol 1e-6.

The run record identifies inputs, model and library fingerprints, engine,
tolerances, initial inputs and omitted connections. Keep it with the CSV.
See [results](results.md) before relying on a trajectory.

For an authored verification example:

```sh
run42 verify examples/electrical --out rc-verdicts.json
```

This older example includes its own Modelica classes and asserts that the
capacitor reaches at least 4.9 V after 5 s. See [examples](examples.md) for the
distinction and [supported scope](supported-scope.md) for current limits.
