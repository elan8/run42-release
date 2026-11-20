# Installation

**No beta package is published yet.** When the first validated release is
available, download its archive and `SHA256SUMS.txt` from
[Releases](https://github.com/elan8/run42-release/releases). The instructions
below apply to those complete packages, not to a source checkout.

| Platform | Archive name | Runtime |
| --- | --- | --- |
| Linux x86_64 | `run42-<version>-linux-x64.tar.gz` | glibc 2.35 or later |
| Windows x86_64 | `run42-<version>-windows-x64.zip` | 64-bit Windows |

The build pipeline also prepares macOS packages. They are not part of the
initial Linux/Windows beta installation promise until validated releases exist.

On Linux, compare the archive's hash with its line in `SHA256SUMS.txt`, then
extract it:

```sh
sha256sum --check --ignore-missing SHA256SUMS.txt
tar -xzf run42-<version>-linux-x64.tar.gz
cd run42-<version>-linux-x64
./run42 --version
```

On Windows PowerShell:

```powershell
Get-FileHash run42-<version>-windows-x64.zip -Algorithm SHA256
Expand-Archive run42-<version>-windows-x64.zip
```

Compare the printed hash with `SHA256SUMS.txt`, open the extracted Run42
directory, then run `./run42.exe --version`. Replace `<version>` with the
downloaded version in each command.

Keep `engines/`, `modelica/`, `sysml-stdlib/`, `domain-library/`, `licenses/` and
the notices beside the executable. Move the whole directory when relocating it.
Add that directory to PATH to use `run42` from any workspace. Rust, Python and
a separate Rumoca executable are not needed for the default embedded engine.

Then [log in](authentication.md) and [run the first example](getting-started.md).
