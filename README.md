# homebrew-octocode

Homebrew tap for [Octocode](https://octocode.ai) — the interactive CLI installer
for `octocode-mcp` (configure MCP servers and skills for Claude Code, Cursor,
Claude Desktop, and more).

## Install

```sh
brew install bgauryy/octocode/octocode
```

That's the full form `brew install <user>/<tap>/<formula>`. You can also tap once
and install by short name:

```sh
brew tap bgauryy/octocode
brew install octocode
```

## Usage

The command is `octocode` (not `octocode-cli`):

```sh
octocode --help
octocode --version
octocode install --ide cursor
octocode tools
```

## Upgrade

```sh
brew update
brew upgrade octocode
```

## Maintainer notes — releasing a new version

The formula installs from the npm registry tarball, so publish to npm first.

1. Publish the package:

   ```sh
   cd packages/octocode-cli
   npm publish
   ```

2. Bump `url`/`version` and refresh `sha256` in `Formula/octocode.rb`. To compute
   the sha256 of the published tarball (replace the version):

   ```sh
   VER=1.5.0
   curl -fsSL "https://registry.npmjs.org/octocode-cli/-/octocode-cli-$VER.tgz" \
     | shasum -a 256
   ```

3. Commit and push:

   ```sh
   git commit -am "octocode $VER"
   git push
   ```

4. Verify locally:

   ```sh
   brew install --build-from-source ./Formula/octocode.rb
   brew test octocode
   brew audit --strict --online octocode
   ```
