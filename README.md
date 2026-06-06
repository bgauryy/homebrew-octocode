# homebrew-octocode

Homebrew tap for [**Octocode**](https://octocode.ai) — the interactive CLI for
`octocode-mcp`. Configure MCP servers and Agent Skills for Claude Code, Cursor,
Claude Desktop, and 13+ other clients, manage GitHub auth, and run all 14 Octocode
research tools straight from your terminal.

## Install

```sh
brew install bgauryy/octocode/octocode
```

That's the full `brew install <user>/<tap>/<formula>` form. You can also tap once
and install by short name:

```sh
brew tap bgauryy/octocode
brew install octocode
```

Verify:

```sh
octocode --version      # → octocode v1.5.3
octocode --help
```

> **Requires** [Node](https://nodejs.org) (installed automatically as a Homebrew
> dependency) and GitHub authentication for the GitHub-backed tools — run
> `octocode login` after install.

## Upgrade

```sh
brew update
brew upgrade octocode
```

---

## What you get

The command is **`octocode`** (not `octocode-cli`). It is two things in one binary:

1. **A setup wizard** — install the Octocode MCP server and Agent Skills into your
   editor/agent, manage GitHub OAuth, and keep configs in sync across clients.
2. **A standalone tool runner** — call any of the 14 Octocode research tools
   directly from the shell, no MCP wiring required.

### Commands

| Command | What it does |
|---------|--------------|
| `octocode install` | Configure `octocode-mcp` for an IDE/agent (`--ide <client>`, `-m npx\|direct`, `--force`, `--json`) |
| `octocode auth` | Manage GitHub authentication (interactive menu) |
| `octocode login` / `logout` | Sign in / out of GitHub (OAuth device flow; `--hostname` for Enterprise) |
| `octocode status` | Octocode health — auth + installed MCPs + cache (`--sync`, `--json`) |
| `octocode token` | Print the GitHub token using the same priority as the MCP server (`--source`, `--validate`) |
| `octocode skills` | Search / install / remove / sync Agent Skills (`--targets`, `--mode copy\|symlink`) |
| `octocode mcp` | MCP marketplace: `list` / `install` / `remove` / `status` (`--id`, `--client`, `--env`) |
| `octocode sync` | Sync MCP configs across all installed IDE clients (`--dry-run`, `--status`) |
| `octocode cache` | Inspect / clean cloned repos, skills, logs, and tool caches |
| `octocode tools` | List tools, show a tool's schema, or run one with `--queries '<json>'` |
| `octocode instructions` | Print MCP instructions + every tool schema |

Top-level flags: `--version`/`-v`, `--help`/`-h`, `--json`/`-j`.

### The 14 tools (`octocode tools <name> --queries '<json>'`)

- **GitHub** — `githubSearchCode`, `githubSearchRepositories`, `githubSearchPullRequests`,
  `githubGetFileContent`, `githubViewRepoStructure`, `githubCloneRepo`
- **Local** — `localSearchCode` (ripgrep), `localFindFiles`, `localGetFileContent`,
  `localViewStructure`
- **LSP** — `lspGotoDefinition`, `lspFindReferences`, `lspCallHierarchy`
- **Package** — `packageSearch` (npm / PyPI → source repo)

### Quick start

```sh
octocode login                                   # GitHub OAuth
octocode install --ide cursor                    # wire MCP into an editor
octocode skills install --targets claude-code    # add Agent Skills
octocode tools                                    # list every tool
octocode tools localSearchCode --queries '{"path":".","pattern":"fn"}'
```

Supported install targets include Cursor, Claude Code, Claude Desktop, Windsurf,
Zed, Trae, Antigravity, Kiro, Codex, Opencode, Gemini CLI, Goose, and the VS Code
extensions Cline / Roo / Continue.

---

## Maintainer notes — releasing a new version

The formula installs from the npm registry tarball, so publish to npm first.

1. **Publish the package** (must stay a zero-dependency esbuild bundle):

   ```sh
   cd packages/octocode-cli && yarn verify && yarn build
   npm whoami        # expect: bgauryy
   npm publish
   ```

2. **Bump the formula** — `scripts/update-formula.sh` fetches the published
   tarball and rewrites `url` + the real `sha256`:

   ```sh
   ./scripts/update-formula.sh 1.5.3
   brew style Formula/octocode.rb
   ```

3. **Commit and push:**

   ```sh
   git commit -am "octocode 1.5.3"
   git push
   ```

4. **Verify the live release:**

   ```sh
   brew update
   brew install bgauryy/octocode/octocode
   brew test octocode
   octocode --version
   ```

> Do **not** add a `version` line to the published formula — Homebrew parses it
> from the `url`; an explicit one trips `brew audit` as redundant.
