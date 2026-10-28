--- source: https://www.superlogical.com/rex/docs/reference/lua.md

---@meta
---@diagnostic disable: missing-fields -- stubs only declare the shape of what Rex injects

-- Types for the Lua API Rex injects into init.lua and `rex do` scripts.
-- Editor metadata only: do not require this file from init.lua.
-- https://www.superlogical.com/rex/docs/reference/lua
--
-- Action names, their arguments, and most API results vary by client and server version, so they are typed
-- loosely. Results this configuration reads have their own shapes; run `rex api describe METHOD` for the rest.

---@class Rex
_G.rex = {}

---@alias rex.Direction "left" | "right" | "up" | "down"

---@class rex.Context
---@field session_id? string The session the action applies to
---@field block_id?   string The block the action applies to, usually the focused one
---@field client_id?  string The client that asked for the action
---@field origin?     "key" | "palette" | "cli" | "api" | "script" | "timer" How the action was run
---@field server?     string The server that owns `session_id` and `block_id`, when it isn't this one

---@class rex.KeyEvent
---@field keybinding string    The key that was pressed; for a sequence, its last key
---@field prefix?    string[]  For a sequence, the keys before `keybinding`

-- Key bindings

--- Binds a key, a sequence written with `>`, or either prefixed with `mode/`, to an action by name.
--- A function binding returns `true` when it handled the key; otherwise the key falls through to the next
--- function bound to it, then to the focused terminal. Function bindings are not allowed in a mode.
---@param key    string
---@param action string
---@param args?  table<string, any>
---@overload fun(key: string, fn: fun(ctx: rex.Context, ev: rex.KeyEvent): boolean?)
function rex.bind(key, action, args) end

---@class rex.Binding
---@field key    string                The key or sequence, without its mode
---@field mode?  string
---@field action? string               `nil` for a function binding
---@field fn?    function              `nil` for an action binding
---@field args?  table<string, any>
---@field source string                Where it was bound, such as `keys.lua:3`

--- Removes the bindings of a key, limited to those targeting `target` when given, and returns how many of this
--- file's bindings it removed. `rex.unbind("mode/key")` also blocks the key in that mode.
---@param key     string
---@param target? string | function
---@return integer
---@overload fun(binding: rex.Binding): integer
---@overload fun(mode: { mode: string })
function rex.unbind(key, target) end

---@param name     string Lowercase letters, digits, underscores, and hyphens
---@param options? { exclusive?: boolean }
function rex.mode(name, options) end

---@param filter? { key?: string, mode?: string, action?: string }
---@return rex.Binding[]
function rex.bindings(filter) end

---@return { name: string, exclusive: boolean, source: string }[]
function rex.modes() end

-- Actions

---@class rex.ActionDefinition
---@field name         string  Lowercase letters, digits, and underscores
---@field title        string  Shown in the command palette
---@field run          fun(ctx: rex.Context, args: table<string, any>): any  The action's result; `nil` or `true` means none
---@field description? string
---@field category?    string  A palette group; defaults to `Actions`
---@field keywords?    string
---@field args?        table<string, any> Argument types such as `"string?"`, or a JSON Schema
---@field repeats?     boolean Run again while the key is held

---@class config.PopupArgs Arguments of the `popup` action (actions/popup.lua); the action's `args` JSON Schema mirrors this
---@field name?   string    Popup identity together with `cwd`; defaults to `cmd[1]`, else `"shell"`
---@field cmd?    string[]  Command to run, one element per argv entry; a plain shell when omitted
---@field bounds? number[]  `[x, y, w, h]` as fractions of the window; defaults to `{ 0.1, 0.1, 0.8, 0.8 }`
---@field cwd?    string    Working directory; defaults to the focused pane's cwd

---@param definition rex.ActionDefinition
function rex.action(definition) end

--- Runs an action and returns its result, or `nil` and an error message.
---@param name  string
---@param args? table<string, any>
---@return any result
---@return string? error
function rex.invoke(name, args) end

rex.client = {}

--- Asks the client to perform one of its own actions, such as `pane.zoom`. In the configuration file this only
--- works inside an action; queued actions run after `run` returns. Raises an error when there is no client.
---@param name  string
---@param args? table<string, any>
function rex.client.queue(name, args) end

-- Calling Rex

---@alias rex.Bounds number[] | { x: number, y: number, w: number, h: number } `[x, y, w, h]` as fractions of the window's width and height

---@class rex.ViewBlock
---@field block_id      string
---@field creator_name? string
---@field flavor?       string
---@field host_id?      string
---@field label?        string
---@field owner?        string

---@class rex.ViewSplit
---@field split_id  string
---@field direction "horizontal" | "vertical" `horizontal` puts `before` on the left, `vertical` puts it on top
---@field ratio     number                    The share `before` gets
---@field before    rex.ViewLayoutNode
---@field after     rex.ViewLayoutNode

--- How a layer divides its space between blocks, as a tree of splits.
---@class rex.ViewLayoutNode
---@field rect      number[]      `[x, y, w, h]` as fractions of the window
---@field block_id? string        Set on a leaf
---@field split?    rex.ViewSplit Set on a split

---@class rex.ViewLayer
---@field layer_id string
---@field kind     "tiled" | "floating" | string `tiled` fills the window; treat an unknown kind as `floating`
---@field bounds   number[]                     `[x, y, w, h]` as fractions of the window
---@field layout   rex.ViewLayoutNode           A layer's layout; `null` when the layer is empty
---@field blocks   rex.ViewBlock[]

---@class rex.ViewWindow
---@field window_id         string
---@field label?            string
---@field focused_block_id? string
---@field zoomed_block_id?  string
---@field layers            rex.ViewLayer[]

---@class rex.SessionView
---@field session_id       string
---@field revision         integer Structural revision; changes with the layout and focus
---@field active_window_id string?
---@field label?           string
---@field windows?         rex.ViewWindow[]

---@class rex.Revision
---@field revision integer The session's revision after the call

---@class rex.BlockInfo
---@field block_id      string
---@field label         string
---@field placement     "placed" | "detached" | string Treat an unknown value as `detached`
---@field window_id?    string
---@field creator_name? string
---@field flavor?       string
---@field host_id?      string
---@field owner?        string

---@class rex.ClientPrincipal
---@field display      string
---@field kind         string
---@field transport    string
---@field gid?         integer
---@field uid?         integer
---@field pid?         integer
---@field login_name?  string
---@field node?        string
---@field path?        string[]
---@field remote_addr? string
---@field sid?         string
---@field tags?        string[]
---@field user_id?     string

---@class rex.ClientInfo
---@field client_id           string
---@field connected_at        string
---@field connection_lost_at? string
---@field connection_state?   string
---@field info?               { kind?: string, label?: string, name?: string, platform?: string, version?: string }
---@field principal           rex.ClientPrincipal

-- Session method arguments and results. `session_id` is filled in when left out; other IDs are not.

---@class rex.NewWindowArgs
---@field layout        rex.Layout The blocks to create and how to arrange them
---@field window_label? string
---@field focus?        boolean    Make the window active; defaults to true
---@field session_id?   string

---@class rex.NewWindowResult: rex.Revision
---@field window_id string
---@field block_ids string[]

---@class rex.NewSplitArgs
---@field direction   "horizontal" | "vertical" `horizontal` is side by side, `vertical` is one above the other
---@field side        "before" | "after"        `before` is the left or top part, `after` the right or bottom part
---@field layout      rex.Layout                The blocks to create beside the anchor, built with `rex.layout.*`
---@field anchor_id?  string                    A block or split ID whose space to split; defaults to the focused block. Not with `window_id`
---@field window_id?  string                    Split this window's focused block; only when `anchor_id` is left out
---@field focus?      boolean                   Focus the first new block and activate its window; defaults to false
---@field ratio?      number                    Share the `before` part gets, above 0 and below 1; defaults to 0.5
---@field session_id? string                    Filled in when left out

---@class rex.NewSplitResult: rex.Revision
---@field anchor_id  string?   The block or split that was split
---@field block_ids  string[]? The new blocks' IDs, in layout order
---@field split_ids  string[]? The splits created: the one at the anchor, then the layout's own

---@class rex.NewBlockArgs
---@field flavor      string   Such as `com.superlogical.terminal.shell`; `block_creator.list` lists them
---@field label?      string
---@field options?    table    In the shape of the flavor's `options_schema`
---@field session_id? string

---@class rex.NewBlockResult: rex.Revision
---@field block_id string

---@class rex.NewLayerArgs
---@field bounds      rex.Bounds Where the floating layer sits; it must fit inside the window
---@field layout      rex.Layout
---@field focus?      boolean
---@field window_id?  string     Defaults to the active window
---@field session_id? string

---@class rex.NewLayerResult: rex.Revision
---@field layer_id  string
---@field block_ids string[]

---@class rex.CloseWindowArgs
---@field window_id?  string Defaults to the active window
---@field session_id? string

---@class rex.LayerArgs
---@field layer_id    string
---@field session_id? string

---@class rex.BlockArgs
---@field block_id    string
---@field session_id? string

---@class rex.MoveBlockArgs
---@field block_id        string  The block to move, or a detached block to place
---@field anchor_block_id string  The block to place it beside; it must be placed in a window
---@field direction?      "horizontal" | "vertical" Defaults to `horizontal`
---@field side?           "before" | "after"        Defaults to `after`
---@field ratio?          number  Share the `before` part gets, above 0 and below 1; defaults to 0.5
---@field session_id?     string

---@class rex.MoveBlockResult: rex.Revision
---@field created_split_id  string
---@field removed_split_id? string

---@class rex.SwapBlocksArgs
---@field block_id       string
---@field other_block_id string
---@field session_id?    string

---@class rex.FloatBlockArgs
---@field block_id    string
---@field bounds      rex.Bounds
---@field session_id? string

---@class rex.FloatBlockResult: rex.Revision
---@field layer_id string

---@class rex.ZoomBlockArgs
---@field block_id?   string  The block to zoom; defaults to the focused block of `window_id` or the active window
---@field window_id?  string  Only when `block_id` is left out; the active window doesn't change
---@field zoom?       boolean `true` zooms, `false` restores; leave out to toggle
---@field session_id? string

---@class rex.ZoomBlockResult: rex.Revision
---@field block_id string
---@field zoomed   boolean

---@class rex.ResizePaneArgs
---@field before_block_id string  A block on the left of the border, or above it when `direction` is `vertical`
---@field after_block_id  string  A block on the right of the border, or below it when `direction` is `vertical`
---@field direction       "horizontal" | "vertical"
---@field ratio           number  Share the `before` part gets, above 0 and below 1
---@field session_id?     string

---@class rex.ResizeLayerArgs
---@field layer_id    string
---@field bounds      rex.Bounds
---@field session_id? string

---@class rex.LayerOrderArgs
---@field layer_id           string
---@field relative_layer_id? string Another floating layer in the same window to sit just above (raise) or below (lower); left out moves it to the front (raise) or back (lower)
---@field session_id?        string

---@class rex.MoveWindowArgs
---@field window_id        string
---@field before_window_id? string Place it just before this window; left out moves it to the end
---@field session_id?      string

---@class rex.FocusWindowArgs
---@field window_id   string
---@field session_id? string

---@class rex.FocusDirectionArgs
---@field direction   rex.Direction
---@field wrap?       boolean Continue from the opposite edge when no block lies that way; defaults to false
---@field session_id? string

---@class rex.FocusCycleArgs
---@field wrap?       boolean
---@field session_id? string

---@class rex.SetLabelArgs
---@field label?      string Up to 128 characters; empty or missing restores the server's label
---@field session_id? string

---@class rex.SetWindowLabelArgs
---@field window_id   string
---@field label?      string
---@field session_id? string

---@class rex.SetBlockLabelArgs
---@field block_id    string
---@field label?      string
---@field session_id? string

---@class rex.SessionIdArgs
---@field session_id? string

---@class rex.DescribeBlockResult
---@field block rex.BlockInfo
---@field api?  { events?: table, methods?: table } The methods and events the block provides

---@class rex.AttachResult
---@field client_id string
---@field view      rex.SessionView

---@class rex.Session
---@field view                  fun(args?: rex.SessionIdArgs): rex.SessionView?, string?
---@field list_blocks           fun(args?: rex.SessionIdArgs): { blocks: rex.BlockInfo[] }?, string?
---@field list_clients          fun(args?: rex.SessionIdArgs): { clients: rex.ClientInfo[] }?, string?
---@field describe_block        fun(args: rex.BlockArgs): rex.DescribeBlockResult?, string?
---@field new_window            fun(args: rex.NewWindowArgs): rex.NewWindowResult?, string?
---@field new_split             fun(args: rex.NewSplitArgs): rex.NewSplitResult?, string?
---@field new_block             fun(args: rex.NewBlockArgs): rex.NewBlockResult?, string?
---@field new_layer             fun(args: rex.NewLayerArgs): rex.NewLayerResult?, string?
---@field close_window          fun(args?: rex.CloseWindowArgs): rex.Revision?, string?
---@field close_layer           fun(args: rex.LayerArgs): rex.Revision?, string?
---@field move_block            fun(args: rex.MoveBlockArgs): rex.MoveBlockResult?, string?
---@field swap_blocks           fun(args: rex.SwapBlocksArgs): rex.Revision?, string?
---@field detach_block          fun(args: rex.BlockArgs): rex.Revision?, string?
---@field float_block           fun(args: rex.FloatBlockArgs): rex.FloatBlockResult?, string?
---@field zoom_block            fun(args?: rex.ZoomBlockArgs): rex.ZoomBlockResult?, string?
---@field resize_pane           fun(args: rex.ResizePaneArgs): rex.Revision?, string?
---@field resize_layer          fun(args: rex.ResizeLayerArgs): rex.Revision?, string?
---@field raise_layer           fun(args: rex.LayerOrderArgs): rex.Revision?, string?
---@field lower_layer           fun(args: rex.LayerOrderArgs): rex.Revision?, string?
---@field move_window           fun(args: rex.MoveWindowArgs): rex.Revision?, string?
---@field focus_block           fun(args: rex.BlockArgs): rex.Revision?, string?
---@field focus_window          fun(args: rex.FocusWindowArgs): rex.Revision?, string?
---@field focus_direction       fun(args: rex.FocusDirectionArgs): rex.Revision?, string?
---@field focus_next_pane       fun(args?: rex.FocusCycleArgs): rex.Revision?, string?
---@field focus_previous_pane   fun(args?: rex.FocusCycleArgs): rex.Revision?, string?
---@field focus_next_window     fun(args?: rex.FocusCycleArgs): rex.Revision?, string?
---@field focus_previous_window fun(args?: rex.FocusCycleArgs): rex.Revision?, string?
---@field set_label             fun(args?: rex.SetLabelArgs): rex.Revision?, string?
---@field set_window_label      fun(args: rex.SetWindowLabelArgs): rex.Revision?, string?
---@field set_block_label       fun(args: rex.SetBlockLabelArgs): rex.Revision?, string?
---@field attach                fun(args?: rex.SessionIdArgs): rex.AttachResult?, string?
---@field detach                fun(args?: rex.SessionIdArgs): table?, string?
---@field help                  fun(args?: rex.SessionIdArgs): table?, string?

--- Session methods. Each returns a result table, or `nil` and an error message, and never raises an error.
--- `session_id` is filled in when left out; other IDs, such as `block_id`, are not.
---@type rex.Session
rex.session = {}

--- Calls any server method by its full name, such as `session.list`.
---@param method string
---@param args?  table
---@return table? result
---@return string? error
function rex.call(method, args) end

---@class rex.Process
---@field pid       integer
---@field name      string
---@field argv0?    string
---@field path?     string
---@field user?     string
---@field user_id?  integer
---@field cwd?      string

---@class rex.TerminalProcess
---@field child?      rex.Process
---@field foreground? rex.Process
---@field ancestors?  rex.Process[]
---@field last_exit?  table
---@field home?       string

rex.block = {}

---@alias rex.TerminalMethod
---| "format"         Return the screen as text, HTML, or VT sequences
---| "process"        Describe the terminal's child and foreground processes
---| "pwd"            Return the working directory the terminal last reported
---| "title"          Return the terminal's title
---| "size"           Return the terminal's size in cells and pixels
---| "write"          Write bytes to the terminal as if they were typed
---| "reset"          Reset the terminal
---| "resize"         Request a size for the terminal
---| "set_theme"      Replace the terminal's default colors
---| "program_status" Return the status records programs have reported
---| "list_dir"       List the directories under a path

--- Calls a method on a block. `block_id` is filled in from the current block when left out.
---@param creator "com.superlogical.terminal" | string The full name of the kind of block
---@param method  rex.TerminalMethod | string
---@param args?   { block_id?: string, [string]: any }
---@return table? result
---@return string? error
---@overload fun(creator: "com.superlogical.terminal", method: "process", args?: { block_id?: string }): rex.TerminalProcess?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "pwd", args?: { block_id?: string }): { pwd?: string }?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "title", args?: { block_id?: string }): { title?: string }?, string?
function rex.block.call(creator, method, args) end

---@class rex.Layout A layout table built by `rex.layout.*`, accepted by `new_window`, `new_split` and `new_layer`

---@class rex.TerminalOptions
---@field command?       string[]  The program and its arguments; without it, an interactive shell starts
---@field shell?         string    `"none"` starts `command` directly
---@field cwd?           string
---@field initial_input? string
---@field exit?          { on_completion?: boolean } `false` keeps the terminal open after its program exits

rex.layout = {}

--- `flavor` names what to create, such as `com.superlogical.terminal.shell`.
---@param block { flavor: string, options?: rex.TerminalOptions | table }
---@return rex.Layout
function rex.layout.block(block) end

---@param ratio number The share given to `a`, from 0 to 1
---@param a     rex.Layout
---@param b     rex.Layout
---@return rex.Layout
function rex.layout.horizontal(ratio, a, b) end

---@param ratio number The share given to `a`, from 0 to 1
---@param a     rex.Layout
---@param b     rex.Layout
---@return rex.Layout
function rex.layout.vertical(ratio, a, b) end

-- Events (scripts only)

--- Calls `fn` each time `event` happens. Scripts only.
---@param event string
---@param fn    fun(ctx: rex.Context, ev: table)
function rex.on(event, fn) end

--- Blocks until `event` happens, returning `ev` and `ctx`, or `nil` and `"timeout"`. Scripts only.
---@param event    string
---@param filter?  table | fun(ev: table, ctx: rex.Context): boolean
---@param timeout? number Seconds
---@return table? ev
---@return rex.Context | "timeout" | nil ctx
---@overload fun(event: string, timeout: number): table?, (rex.Context | "timeout" | nil)
function rex.wait(event, filter, timeout) end

--- Scripts only.
---@param seconds number
function rex.sleep(seconds) end

--- Ends the script immediately; `rex do` exits with `code`, or 0. Scripts only.
---@param code? integer
function rex.stop(code) end

-- Hosts and other servers

---@class rex.HostDefinition
---@field label      string
---@field endpoints? string[] Addresses, tried in order (required unless `endpoint` is given)
---@field endpoint?  string   A single address, in place of `endpoints`
---@field id?        string   A stable ID, so the host keeps its identity when renamed
---@field icon?      string

--- Declares another Rex server. Configuration file only.
---@param definition rex.HostDefinition
function rex.host(definition) end

---@return string[]
function rex.servers() end

---@class rex.Server
---@field session rex.Session
---@field block   { call: fun(creator: string, method: string, args?: table): table?, string? }
---@field call    fun(method: string, args?: table): table?, string?

--- Raises an error for an unknown label. Calls through it don't fill in a `session_id` or `block_id`.
---@param label string
---@return rex.Server
function rex.server(label) end

-- Other functions

---@class rex.ExecOptions
---@field cwd?       string
---@field env?       table<string, string | false> `false` removes a variable
---@field clear_env? boolean
---@field stdin?     string
---@field timeout?   number Seconds until `SIGTERM`, then `SIGKILL` two seconds later
---@field stdout?    false
---@field stderr?    false
---@field text?      boolean

---@class rex.ExecResult
---@field code      integer `-1` if a signal ended the command
---@field signal?   string
---@field stdout    string
---@field stderr    string
---@field timed_out boolean
---@field ok        boolean `code` is 0 and the command didn't time out

---@class rex.ExecStartOptions: rex.ExecOptions
---@field stdin?  string | boolean `true` keeps standard input open for `h:write`
---@field stdout? false | fun(data: string)
---@field stderr? false | fun(data: string)
---@field detach? boolean Let the command outlive the work that started it

---@class rex.ExecHandle
---@field pid integer
local ExecHandle = {}

---@param seconds? number
---@return rex.ExecResult? result
---@return "timeout"? error
function ExecHandle:wait(seconds) end

---@param data string
---@return true? ok
---@return string? error
function ExecHandle:write(data) end

function ExecHandle:close_stdin() end

---@param signal? string | integer
function ExecHandle:kill(signal) end

---@return boolean
function ExecHandle:running() end

---@class rex.Exec
---@overload fun(argv: string[], opts?: rex.ExecOptions): rex.ExecResult?, string?
---@field start fun(argv: string[], opts?: rex.ExecStartOptions): rex.ExecHandle?, string?

--- Runs a command and waits for it to exit. Returns `nil` and an error message only when it never ran.
---@type rex.Exec
rex.exec = {}

---@class rex.Timer
local Timer = {}

function Timer:cancel() end

---@return boolean
function Timer:active() end

--- Scripts only.
---@param seconds number
---@param fn      fun(ctx: rex.Context)
---@return rex.Timer
function rex.after(seconds, fn) end

--- Scripts only.
---@param seconds number
---@param fn      fun(ctx: rex.Context)
---@return rex.Timer
function rex.every(seconds, fn) end

rex.json = {}

---@param value any
---@param opts? { indent?: boolean }
---@return string? text
---@return string? error
function rex.json.encode(value, opts) end

---@param text string
---@return any value
---@return string? error
function rex.json.decode(text) end

---@param level   "debug" | "info" | "warn" | "error"
---@param message string
---@overload fun(message: string)
function rex.log(level, message) end

-- Script values (scripts only)

---@type table<string, any>
rex.args = {}

---@type string
rex.session_id = ""

---@type string?
rex.block_id = nil
