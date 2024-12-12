# open-with-cmd.yazi

This is a Yazi plugin for opening files with a prompted command.

## Setup

Create `~/.config/yazi/keymap.toml` and add:

```
prepend_keymap = [
  { on = ["e"], run = "plugin open-with-cmd --args=block", desc = "Execute command in the terminal" },
  { on = ["E"], run = "plugin open-with-cmd", desc = "Execute command" },
]
```
