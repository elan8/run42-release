# Command reference

## run

```sh
run42 run MODEL [LIBRARY ...] --root QUALIFIED_PART --t-end DURATION [OPTIONS]
```

Select a part definition and simulate its bound physical assembly. Additional
paths supply project libraries; the installed Elan8 domain library is included
automatically unless a supplied library already provides it.

| Option | Meaning | Default |
| --- | --- | --- |
| `--root` | Qualified or uniquely resolved part-definition name | Required |
| `--t-end` | End time, for example `5ms` or `3s` | Required |
| `--points` | Number of trajectory output points | 200 |
| `--input NAME=VALUE[UNIT]` | Explicit constant scalar input; repeatable | No invented input values |
| `--rtol` | Relative solver tolerance | 1e-6 |
| `--atol` | Absolute solver tolerance | 1e-6 |
| `--out` | Output stem for `.csv` and `.run.json` | `run42-out` |
| `--stdlib` | Explicit SysML standard-library directory | Installed library, or `SPEC42_STDLIB_ROOT` |
| `--driver` | Versioned execution-binding JSON for a SysML/Wasm driver | None |

```sh
run42 run examples/domain-rc-circuit --root DomainRc::Circuit --t-end 5s --points 61 --rtol 1e-9 --atol 1e-11 --out rc
```

## verify

```sh
run42 verify MODEL [LIBRARY ...] [--driver FILE] [--stdlib DIRECTORY] [--out FILE]
```

Run authored test cases and evaluate their assertions. The output defaults to
`verdicts.json`. A physical test's subject is composed and simulated for the sum
of its `accept after` delays, using rtol 1e-9 and atol 1e-11. A physical stimulus
cannot currently drive arbitrary time-varying inputs. An execution file supplies
explicit bindings and its own recorded solver configuration.

Read the output's verdicts as well as command errors. A case name never selects
a scenario or supplies a passing result. See [results](results.md).

## Account and information commands

| Command | Purpose |
| --- | --- |
| `run42 login` | Prompt for an API token and obtain access |
| `run42 license` | Display license status without exposing credentials |
| `run42 logout` | Remove saved credentials and cached licenses |
| `run42 --version` | Report the application and compiled-in Rumoca version |
| `run42 --help`, `run42 run --help`, `run42 verify --help` | Display command help |

`RUN42_MODELICA_ENGINE=process` selects the separate pinned engine; `RUMOCA`
selects its executable. The default is `embedded`. The run record, rather than
`--version`, identifies which backend a particular simulation actually used.
