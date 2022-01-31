local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  return
end

local highlights = require("neo-tree.ui.highlights")

neotree.setup({
  -- The default_source is the one used when calling require('neo-tree').show()
  -- without a source argument.
  default_source = "filesystem",
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  filesystem = {
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["l"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["C"] = "close_node",
        ["h"] = "close_node",
        ["<bs>"] = "navigate_up",
        ["u"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["I"] = "toggle_gitignore",
        ["R"] = "refresh",
        ["/"] = "filter_as_you_type",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["bd"] = "buffer_delete",
      },
    },
  },
  buffers = {
    show_unloaded = true,
    window = {
      position = "left",
      mappings = {
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["l"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["<bs>"] = "navigate_up",
        ["u"] = "navigate_up",
        ["."] = "set_root",
        ["R"] = "refresh",
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["C"] = "close_node",
        ["R"] = "refresh",
        ["d"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
  search_limit = 50, -- max number of search results when using filters
  filters = {
    show_hidden = false,
    respect_gitignore = true,
  },
  bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
  before_render = function(state)
    -- This function is called after the file system has been scanned,
    -- but before the tree is rendered. You can use this to gather extra
    -- data that can be used in the renderers.
    local utils = require("neo-tree.utils")
    state.git_status_lookup = utils.get_git_status()
  end,
  -- The components section provides custom functions that may be called by
  -- the renderers below. Each componment is a function that takes the
  -- following arguments:
  --      config: A table containing the configuration provided by the user
  --              when declaring this component in their renderer config.
  --      node:   A NuiNode object for the currently focused node.
  --      state:  The current state of the source providing the items.
  --
  -- The function should return either a table, or a list of tables, each of which
  -- contains the following keys:
  --    text:      The text to display for this item.
  --    highlight: The highlight group to apply to this text.
  components = {
    hello_node = function(config, node, state)
      local text = "Hello " .. node.name
      if state.search_term then
        text = string.format("Hello '%s' in %s", state.search_term, node.name)
      end
      return {
        text = text,
        highlight = config.highlight or highlights.FILE_NAME,
      }
    end,
  },
  -- This section provides the renderers that will be used to render the tree.
  -- The first level is the node type.
  -- For each node type, you can specify a list of components to render.
  -- Components are rendered in the order they are specified.
  -- The first field in each component is the name of the function to call.
  -- The rest of the fields are passed to the function as the "config" argument.
  renderers = {
    directory = {
      { "current_filter" },
      { "name" },
      {
        "clipboard",
        highlight = "NeoTreeDimText",
      },
      {
        "icon",
        folder_closed = "",
        folder_open = "",
        padding = " ",
      },
      --{ "git_status" },
    },
    file = {
      --{ "hello_node", highlight = "Normal" }, -- For example, don't actually
      -- use this!
      { "name" },
      {
        "clipboard",
        highlight = "NeoTreeDimText",
      },
      {
        "git_status",
        highlight = "NeoTreeDimText",
      },
      {
        "icon",
        default = "*",
        padding = " ",
      },
    },
  },
})
