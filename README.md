[![CI](https://github.com/tj-actions/semver-diff/workflows/CI/badge.svg)](https://github.com/tj-actions/semver-diff/actions?query=workflow%3ACI)
[![Update release version.](https://github.com/tj-actions/semver-diff/workflows/Update%20release%20version./badge.svg)](https://github.com/tj-actions/semver-diff/actions?query=workflow%3A%22Update+release+version.%22) 
<a href="https://github.com/search?q=tj-actions+semver-diff+path%3A.github%2Fworkflows+language%3AYAML&type=code" target="_blank" title="Public workflows that use this action."><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fapi-tj-actions.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dtj-actions%2Fsemver-diff%26badge%3Dtrue" alt="Public workflows that use this action."></a>

semver-diff
-----------

Get the difference between your previous tagged semantic version and the latest tag using [semver-tool](https://github.com/fsaintjacques/semver-tool)

```yaml
name: Get semver diff

on:
  release:
    types:
      - created
  push:
    tags:
      - v*

jobs:
  test:
    runs-on: ubuntu-latest
    name: semver-diff
    steps:
      - uses: actions/checkout@v2
      - name: Run semver-diff
        id: semver-diff
        uses: tj-actions/semver-diff@v1.2.0
      - name: Show release type
        run: |
          echo "Release type: ${{ steps.semver-diff.outputs.release_type }}"
        # Outputs: Release type: major || minor || patch || prerelease || build
```


## Inputs

|   Input       |    type    |  required     |  default                      |  description  |
|:-------------:|:-----------:|:-------------:|:----------------------------:|:-------------:|
| token         |  `string`   |    `true`    | `${{ github.token }}` | [GITHUB_TOKEN](https://docs.github.com/en/free-pro-team@latest/actions/reference/authentication-in-a-workflow#using-the-github_token-in-a-workflow) <br /> or a repo scoped <br /> [Personal Access Token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)              |
| initial_release_type | `string` | `true`    | `patch`  |  Initial release type returned <br /> when there are no existing tags. |


## Outputs

|   Output       |    type    |  description  |
|:-------------:|:-----------:|:-------------:|
| release_type | `string` | The difference between two versions by release type <br /> (major, minor, patch, prerelease, build) |


* Free software: [MIT license](LICENSE)


Credits
-------

This package was created with [Cookiecutter](https://github.com/cookiecutter/cookiecutter) using [cookiecutter-action](https://github.com/tj-actions/cookiecutter-action)

Report Bugs
-----------

Report bugs at https://github.com/tj-actions/semver-diff/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your workflow that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.
