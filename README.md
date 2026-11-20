# Run42

Run42 simulates SysML v2 models and checks authored verification cases against
their observed results. Component physics comes from Modelica libraries;
model execution and result files stay on your machine.

This public repository holds binary releases, examples and the
[user guide](https://elan8.github.io/run42-release/). Run42 is proprietary
software by [Elan8](https://www.elan8.com).

**Useful beta preparation:** no binary release has been published yet. The
documentation describes the implemented beta scope, rather than a stable
release. Installation becomes available when validated packages appear in
[Releases](https://github.com/elan8/run42-release/releases).

Start with the [supported scope](docs/supported-scope.md), then
[installation](docs/installation.md) and [your first simulation](docs/getting-started.md).
The [examples](examples/README.md) include electrical and mechanical models with
analytic reference equations. `examples/domain-rc-circuit` uses only SysML parts
from the library included in a Run42 package.

Run42 requires an Elan8 account with Run42 access for simulation and verification.
Use `run42 login` with an API token; see [authentication](docs/authentication.md).
Help and version reporting require no token.
