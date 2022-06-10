-- source: https://github.com/tamton-aquib/essentials.nvim
local M = {}
local line = vim.fn.line
local map = vim.api.nvim_buf_set_keymap

-------- Run code according to filetypes ---------
function M.run_file(height)
  local fts = {
    rust = "cargo run",
    python = "python %",
    javascript = "npm start",
    c = "make",
    cpp = "make",
  }

  local cmd = fts[vim.bo.ft]
  if cmd ~= nil then
    vim.cmd("w")
    local ht = type(height) == "number" and height or math.floor(vim.api.nvim_win_get_height(0) / 3)
    vim.cmd(ht .. "split | terminal " .. cmd)
  else
    -- vim.notify("No command Specified for this filetype!")
  end
end
--------------------------------------------------

-------- VSCode like rename function -------
function M.post(rename_old)
  vim.cmd([[stopinsert!]])
  local new = vim.api.nvim_get_current_line()
  vim.schedule(function()
    vim.api.nvim_win_close(0, true)
    vim.lsp.buf.rename(vim.trim(new))
  end)
  -- vim.notify(rename_old .. " -> " .. new)
end

function M.rename()
  local rename_old = vim.fn.expand("<cword>")
  local noice_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(noice_buf, true, {
    relative = "cursor",
    style = "minimal",
    border = "single",
    row = 1,
    col = 1,
    width = 15,
    height = 1,
  })
  vim.cmd([[startinsert]])
  map(
    noice_buf,
    "i",
    "<CR>",
    '<cmd>lua require"user.essentials".post("' .. rename_old .. '")<CR>',
    { noremap = true, silent = true }
  )
end

-- source: https://gist.github.com/RaafatTurki/64d89abf326e9fce6eb717f7c1f8a97e
function M.lspRename()
  local curr_name = vim.fn.expand("<cword>")
  local value = vim.fn.input("LSP Rename: ", curr_name)
  local lsp_params = vim.lsp.util.make_position_params()

  if not value or #value == 0 or curr_name == value then
    return
  end

  -- request lsp rename
  lsp_params.newName = value
  vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx, _)
    if not res then
      return
    end

    -- apply renames
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

    -- print renames
    local changed_files_count = 0
    local changed_instances_count = 0

    if res.documentChanges then
      for _, changed_file in pairs(res.documentChanges) do
        changed_files_count = changed_files_count + 1
        changed_instances_count = changed_instances_count + #changed_file.edits
      end
    elseif res.changes then
      for _, changed_file in pairs(res.changes) do
        changed_instances_count = changed_instances_count + #changed_file
        changed_files_count = changed_files_count + 1
      end
    end

    -- compose the right print message
    print(
      string.format(
        "renamed %s instance%s in %s file%s. %s",
        changed_instances_count,
        changed_instances_count == 1 and "" or "s",
        changed_files_count,
        changed_files_count == 1 and "" or "s",
        changed_files_count > 1 and "To save them run ':wa'" or ""
      )
    )
  end)
end
--------------------------------------------

---------- comment function ---------
local comment_map = {
  javascript = "//",
  typescript = "//",
  javascriptreact = "//",
  c = "//",
  java = "//",
  rust = "//",
  cpp = "//",
  python = "#",
  sh = "#",
  conf = "#",
  dosini = "#",
  yaml = "#",
  lua = "--",
  autohotkey = ";",
}

function M.toggle_comment(visual)
  local starting, ending = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]

  local leader = comment_map[vim.bo.ft]
  local current_line = vim.api.nvim_get_current_line()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local noice = visual and starting .. "," .. ending or ""

  vim.cmd(
    current_line:find("^%s*" .. vim.pesc(leader)) and noice .. "norm ^" .. ("x"):rep(#leader + 1)
      or noice .. "norm I" .. leader .. " "
  )

  vim.api.nvim_win_set_cursor(0, cursor_position)
  -- if visual then vim.cmd [[norm gv]] end
end
-------------------------------------

---------- git links -----------
local function git_stuff(args)
  return require("plenary.job"):new({ command = "git", args = args }):sync()[1]
end

local function git_url()
  return git_stuff({ "config", "--get", "remote.origin.url" })
end
local function git_branch()
  return git_stuff({ "branch", "--show-current" })
end
local function git_root()
  return git_stuff({ "rev-parse", "--show-toplevel" })
end

local function parse_url()
  local url = git_url()
  if not url then
    error("No git remote found!")
    return
  end

  return url:match("https://github.com/(.+)$") or url:match("git@github.com:(.+).git$")
end

function M.get_git_url()
  local final = parse_url()
  local git_file = vim.fn.expand("%:p"):match(git_root() .. "(.+)")
  local starting, ending = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]

  local noice = ("https://github.com/%s/blob/%s%s#L%s-L%s"):format(final, git_branch(), git_file, starting, ending)

  vim.fn.setreg("+", noice)
  print("link copied to clipboard!")
  -- os.execute('xdg-open '..noice)
end
--------------------------------

--------- clean folds ----------
function M.simple_fold()
  local fs, fe = vim.v.foldstart, vim.v.foldend
  local start_line = vim.fn.getline(fs):gsub("\t", ("\t"):rep(vim.o.tabstop))
  local end_line = vim.trim(vim.fn.getline(fe))
  local spaces = (" "):rep(vim.o.columns - start_line:len() - end_line:len() - 7)

  return start_line .. "  " .. end_line .. spaces
end
-- set this: vim.opt.foltext = 'v:lua.require("essentials").simple_fold()'
---------------------------------

-------- Swap booleans ----------
function M.swap_bool()
  local c = vim.api.nvim_get_current_line()
  local subs = c:match("true") and c:gsub("true", "false") or c:gsub("false", "true")
  vim.api.nvim_set_current_line(subs)
end
---------------------------------

----- Go to last edited place -----
function M.last_place()
  -- if vim.api.nvim_win_is_valid(0) and vim.api.nvim_buf_is_loaded(0) then
  if vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
    if not vim.tbl_contains({ "help", "packer", "toggleterm" }, vim.bo.ft) then
      if line([['"]]) > 1 and line([['"]]) <= line("$") then
        vim.cmd([[norm '"]]) -- g'" for including column
      end
    end
  end
end
-----------------------------------

-------  Go To URL ---------
function M.go_to_url(cmd)
  local url = vim.api.nvim_get_current_line():match([[%[.*]%((.*)%)]]) -- To work on md links
  if url == nil then
    url = vim.fn.expand("<cWORD>")
    if not string.match(url, "http") then
      url = "https://github.com/" .. url
    end
    if string.match(url, [[(.+)[,:]$]]) then
      url = url:sub(1, -2)
    end -- to check commas at the end
  end

  -- vim.notify("Going to " .. url, "info", { title = "Opening browser..." })
  vim.cmd(":silent !" .. (cmd or "xdg-open") .. " " .. url .. " 1>/dev/null")
end
----------------------------

return M
