# GetNote CLI Setup

Use this when the current machine cannot run GetNote search.

## 1. Detect CLI

Try these in order:

```bash
command -v getnote-cli
command -v getnote
test -x "$HOME/.local/bin/getnote-cli" && echo "$HOME/.local/bin/getnote-cli"
```

If both `getnote-cli` and `getnote` exist, prefer `getnote-cli` only when that is what the user already uses. The upstream command may display itself as `getnote`; both names can be valid wrappers around the same CLI.

Set a local variable in your working notes:

```bash
GETNOTE_BIN="<resolved command>"
```

## 2. Install Guidance

If no CLI is found, ask the user to install the GetNote CLI from the official project:

```text
https://github.com/iswalle/getnote-cli
```

Recommended user-facing guidance:

1. Open the official repository or releases page.
2. Download the binary for the current OS/CPU.
3. Put it in a directory on `PATH`, such as `$HOME/.local/bin`.
4. Make it executable.

Example for a manually downloaded binary:

```bash
mkdir -p "$HOME/.local/bin"
mv ~/Downloads/getnote "$HOME/.local/bin/getnote-cli"
chmod +x "$HOME/.local/bin/getnote-cli"
export PATH="$HOME/.local/bin:$PATH"
```

Do not invent a curl installer URL unless the official repository documents one.

## 3. Authenticate

Check status first:

```bash
$GETNOTE_BIN auth status
```

If not authenticated:

```bash
$GETNOTE_BIN auth login
```

If the user has an API key:

```bash
$GETNOTE_BIN auth login --api-key <gk_live_xxx>
```

API keys are available from Get笔记 developer settings. Credentials are usually saved under:

```text
~/.getnote/config.json
```

Environment variables may override saved config:

```bash
GETNOTE_API_KEY
GETNOTE_CLIENT_ID
```

## 4. Verify Access

Run:

```bash
$GETNOTE_BIN kbs -o json
$GETNOTE_BIN search "写作风格 口音 观点" --limit 3 -o json
```

Success criteria:

- Auth status says authenticated.
- `kbs` returns at least an empty success response, not an auth error.
- Search returns note results or a valid empty result.

## 5. Continue Or Fallback

If setup succeeds, continue with author-style grounding.

If setup fails, ask whether to:

- continue with the user's provided drafts only
- continue with a generic style
- stop and fix GetNote first

Do not claim to have learned the author's style from GetNote unless search and note reading actually succeeded.
