# Troubleshooting

| Symptom | What to check |
| --- | --- |
| Command is not found | Add the unpacked directory to PATH, or run the executable by its full path. In PowerShell use `./run42.exe`. |
| No API token or product access | Run `run42 login`, then `run42 license`. Confirm the account has Run42 access. `ELAN8_TOKEN` overrides saved login. |
| Standard or domain library missing | Restore the complete archive. Keep `sysml-stdlib/`, `domain-library/`, `modelica/` and `engines/` beside the executable. |
| Names become ambiguous | Do not add a second copy of the domain library. Supply extra paths only for project libraries the model needs. |
| Unbound or missing Modelica input | Supply a compatible `--input` or an explicit driver binding. A synthesized zero is not an authored default. |
| Unit mismatch | Compare the authored quantity and compiler-reported unit; physical verification comparisons currently require the same unit spelling. |
| A case returns error | Read its diagnostic and evidence. Unsupported execution and missing observations are not failed assertions or successful verification. |
| Engine fails or initialization is inconsistent | Retain the diagnostic, run settings and model. Do not loosen tolerances or invent starts just to obtain a plausible result. |
| Process engine is missing | Default embedded mode needs no executable. Explicit process mode needs separately installed Rumoca 0.10.4, selected with `RUMOCA`. |

When reporting a problem, include `run42 --version`, the command and settings,
diagnostic text and a minimal model you can share. Remove tokens and sensitive
model data. Review the [supported scope](supported-scope.md) first.
