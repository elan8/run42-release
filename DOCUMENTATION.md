# Documentation publishing

The site publishes an explicitly unreleased beta guide from `docs/*.md`.
Generated pages in `site/.generated` are disposable. Keep implementation code
and internal capability/catalog administration out of this public repository.

```sh
npm ci
npm test
npm run docs:build
npm run docs:preview
```

GitHub Pages uses Actions. Pull requests build and check the site; merging into
`main` deploys it at https://elan8.github.io/run42-release/.

## Publish a binary release

1. Select a source version and run the private source repository's release
   workflow. It validates a matching version tag and builds platform archives,
   `BUILD.txt` and `SHA256SUMS.txt` into one `run42-<version>-release` artifact.
   Check every required platform build. Do not publish an unlicensed development
   executable or treat a skipped licensed package simulation as a passing check.
2. Download that exact artifact from its completed run. Verify its source
   revision, archive checksums, notices and Linux/Windows packaged numerical
   smoke results. Production access is required for a release-executable
   simulation; debug test credentials cannot validate a production release.
3. Update the current guides, examples and README for that version. Replace the
   unreleased notices only when its matching validated assets are ready. For
   later releases preserve the prior guides under `docs/<version>/` and add
   archived-version navigation before updating the current guide.
4. Review and merge the public documentation change. Tag that exact public
   documentation commit as `v<version>`. This is the public docs revision, not
   the private implementation commit recorded in `BUILD.txt`.
5. Create a draft release in **this** repository with the same version and upload
   the platform archives, `BUILD.txt` and `SHA256SUMS.txt`. Review the assets and
   supported scope, then publish the release. For the first beta use GitHub's
   prerelease designation.
6. Verify the public downloads, extracted executables, authentication and the
   deployed guide agree on the version. Only then describe it as installable.

The source workflow retains artifacts; it has no cross-repository publishing
credential. Maintainers publish the reviewed files into this repository, matching
Doc42's separation of private builds and public distribution. A documentation
deployment does not grant product access or add Run42 to any subscription.
