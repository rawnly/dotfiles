# Rex config notes

Findings from building floating panes, popups and pickers. Read before adding new actions.

## Layout of this config

```
init.lua              entry: plugins, then actions, then keys
keys.lua              all bindings (prefix ctrl+a); BOUNDS presets for floats
actions/              one rex.action per file
  quick-open.lua        run a command in a split or a float
  popup.lua             toggleable floating pane that keeps running (shell, lazygit, ...)
  edit-scrollback.lua   pane scrollback in nvim, in a float
  move-pane.lua         swap the focused split with a neighbour
lib/pane.lua          shared helpers: cwd(), float(), shell_layout(), check(), bin()
bin/                  helper scripts that run inside floats
types/rex.lua         Lua API type stubs
smart-splits.lua      unused local copy (the plugin provides smart_splits_*)
docs/                 this file
```

Conventions:
- New action: add `actions/<name>.lua`, add it to the list in `init.lua`, bind it in `keys.lua`.
- Put anything used by two actions in `lib/pane.lua`. Do not copy helpers between files.
- Keep geometry in `BOUNDS` in `keys.lua`; keep key syntax going through `prefix()`.
- Scripts that need a path to `bin/` use `pane.bin("name.sh")`.
- After any edit, run `rex config check`, then reload with `cmd+shift+r`
  (or `rex api call server.config_reload '{}'`).
- Smoke-test an action without keys: `rex do popup name=smoke`, then close what it made.

## Concepts

- Rex calls a tab a **window** and a pane a **block**.
- A **floating pane** is a *layer* (`rex.session.new_layer`, bounds are `[x, y, w, h]` as fractions of the window).
- A block can be **detached**: it leaves the window but keeps running (`session.detach_block`).
  `session.list_blocks` shows it with `placement = "detached"`.
- `rex api list` and `rex api describe METHOD --json` document every server method.
  `types/rex.lua` holds the Lua types. `rex actions` lists actions.

## The big gotcha: server focus vs. client focus

There are two separate notions of "active window":

| Layer | Changed by | Effect |
|---|---|---|
| Server (per session) | `rex window focus`, `rex window new` (focus on), `rex block focus`, `rex.session.focus_*` | `rex window ls` shows the `*`; **the app may not switch** |
| App client (what you see) | **`rex do session.select session_id=... window_id=...`**, `client.tab.goto`, `client.tab.next` | the screen switches tab |

To move the user's view, use a client action. Do not trust `rex window ls` as proof the
screen changed. It only reads the server side.

```sh
rex do session.select session_id="$REX_SESSION" window_id="$win"
```

`rex do` picks the app client automatically when only one is connected. Otherwise pass
`-C CLIENT` (see `rex client ls`). `rex -C ID actions` lists a client's actions.

## Popup toggle (`actions/popup.lua`)

tmux `display-popup`-style toggle. Bound to `F12` / `ctrl+a>d` (blank shell) and `ctrl+a>g` (lazygit, so it survives hiding).

- First press: `new_layer` with a labelled shell block (`popup:<name>:<cwd>`).
- Press again: `detach_block`. The process keeps running, hidden.
- Press again: `move_block` (beside the current pane) then `float_block` then `focus_block`.
  There is no "place a detached block as floating" call, so the block briefly appears as a split.
- Omit `cmd` for a plain shell. One popup per (name, cwd), found by label.
- If the process exits the block is gone and the next press starts a fresh one.

## Floating helper scripts

- Use `quick_open` with `floating = true` and `cmd = { "sh", "<script>" }` to run a script in a float.
  The float closes when the script exits. cwd is inherited from the focused pane.
- Inside the float, `REX_SESSION` and `REX_BLOCK` are set. `REX_BLOCK` is the **float's own** block,
  not the pane you came from. Pass the origin block id as an argument when you need it
  (see `edit_scrollback`).
- Close the float yourself with `rex block close "$REX_BLOCK"`.
- Pickers write their UI to `/dev/tty` and the result to stdout, so `f=$(bracco)` works.

## Pitfalls hit along the way

- **Background jobs die with the float.** `nohup ... &` was not enough. Don't rely on a delayed
  step after the pane's shell exits. Do the work first, then `exec` the close.
- **Debugging by logging `rex window ls` hid the real problem** (see focus section) and its delay
  made a broken version look like it worked. When something "works with logging only", suspect timing,
  then check which layer your check is reading.
- Repeated failed attempts pile up extra tabs because you re-trigger the key. Check `rex window ls`
  and clean up test windows (`rex window close LABEL`) after experiments.
- Always clean up throwaway windows you create while testing, and restore focus
  (`rex window focus <id>`).

## Ideas not yet built

Last-tab toggle, sesh-style session picker, `gh pr view -w` shortcuts, config edit/reload keys,
tab reordering, worktree helpers, per-agent status.
