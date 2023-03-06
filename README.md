[![CI](https://github.com/tj-actions/semver-diff/workflows/CI/badge.svg)](https://github.com/tj-actions/semver-diff/actions?query=workflow%3ACI)
[![Update release version.](https://github.com/tj-actions/semver-diff/workflows/Update%20release%20version./badge.svg)](https://github.com/tj-actions/semver-diff/actions?query=workflow%3A%22Update+release+version.%22)
[![Public workflows that use this action.](https://img.shields.io/endpoint?url=https%3A%2F%2Fused-by.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dtj-actions%2Fsemver-diff%26badge%3Dtrue)](https://github.com/search?o=desc\&q=tj-actions+semver-diff+path%3A.github%2Fworkflows+language%3AYAML\&s=\&type=Code)

## semver-diff

Get the difference between two semantic versions using [semver-tool](https://github.com/fsaintjacques/semver-tool)

## Example

![Screen Shot 2021-05-24 at 7 13 32 AM](https://user-images.githubusercontent.com/17484350/119339811-a6b92a80-bc5f-11eb-9f6f-475cae246545.png)

## Usage

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
        uses: tj-actions/semver-diff@v2
      - name: Show release type
        run: |
          echo "Release type: ${{ steps.semver-diff.outputs.release_type }}"
        # Outputs: Release type: major || minor || patch || prerelease || build
```

#### Using [bump2version](https://github.com/c4urself/bump2version)

```yaml
name: Upload Python Package

on:
  release:
    types: [created]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Run semver-diff
        id: semver-diff
        uses: tj-actions/semver-diff@v2

      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.6.x'

      - name: Install dependencies
        ...

      - name: Setup git
        run: |
          git config --local user.email "github-actions[bot]@users.noreply.github.com"
          git config --local user.name "github-actions[bot]"

      - name: bumpversion
        run: |
          bump2version "${{ steps.semver-diff.outputs.release_type }}"
          git switch -c main 
       
      - name: Build and publish to PyPi
        ...
        
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v3
        with:
          base: "main"
          ...
```

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|        INPUT         |  TYPE  | REQUIRED |  DEFAULT  |                            DESCRIPTION                            |
|----------------------|--------|----------|-----------|-------------------------------------------------------------------|
| initial\_release\_type | string |   true   | `"patch"` | Initial release type returned when there<br>are no existing tags. |

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->

|    OUTPUT    |  TYPE  |                                                    DESCRIPTION                                                    |
|--------------|--------|-------------------------------------------------------------------------------------------------------------------|
| new\_version  | string |                                            The current project version                                            |
| old\_version  | string |                                           The previous project version                                            |
| release\_type | string | The difference between two versions by<br> the release type (`major`, `minor`, `patch`,<br>`prerelease`, `build`) |

<!-- AUTO-DOC-OUTPUT:END -->

*   Free software: [MIT license](LICENSE)

If you feel generous and want to show some extra appreciation:

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[buymeacoffee]: https://www.buymeacoffee.com/jackton1

[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png

## Credits

This package was created with [Cookiecutter](https://github.com/cookiecutter/cookiecutter) using [cookiecutter-action](https://github.com/tj-actions/cookiecutter-action)

## Report Bugs

Report bugs at https://github.com/tj-actions/semver-diff/issues.

If you are reporting a bug, please include:

*   Your operating system name and version.
*   Any details about your workflow that might be helpful in troubleshooting.
*   Detailed steps to reproduce the bug.
