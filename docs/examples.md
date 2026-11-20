# Examples

The [example workspaces](../examples/README.md) are included in platform packages.

| Workspace | Root | Reference |
| --- | --- | --- |
| `examples/domain-rc-circuit` | `DomainRc::Circuit` | 5 V RC charging, τ = 1 s; SysML only, using supplied library parts |
| `examples/electrical` | `RcCharging::Circuit` | The same RC charging equation using local Modelica classes; authored verification case and Doc42 report |
| `examples/mechanical` | `Oscillator::Oscillator` | 1 kg damped oscillator, x(0) = 0.1 m, ω₀ = 10 rad/s, ζ = 0.2; local Modelica classes |

```sh
run42 run examples/mechanical --root Oscillator::Oscillator --t-end 3s --out oscillator
run42 verify examples/mechanical --out oscillator-verdicts.json
```

The mechanical reference is
`x(t) = 0.1 exp(-2t) [cos(sqrt(96)t) + 2/sqrt(96) sin(sqrt(96)t)] m`.
Its case checks displacement within ±1 mm at 3 s. Run the model to obtain the
actual values; these equations state references, not prerecorded solver output.

Start new models with library parts as in the domain RC example. A separate
Modelica file is the advanced path for a new component type the supplied library
does not provide. The electrical and mechanical examples retain local physics
while they are migrated to domain-library parts.

## Report verification with Doc42

With a Doc42 version supporting Run42 verdict evidence:

```sh
run42 verify examples/electrical --out examples/electrical/verdicts.json
doc42 build examples/electrical --doc RcReports::verificationReport --out report
```

Keep model and evidence together and rerun both commands after model changes.
A missing verdict is `not run`, never a passing result. See the
[Doc42 guide](https://elan8.github.io/doc42-release/) for document installation
and authentication; Doc42 access is separate from Run42 access.
