---@diagnostic disable: undefined-global

-- gif: https://old.reddit.com/r/neovim/comments/zs0fsu/luasnips_are_fun/
local ts_function_fmt = [[
{doc}
{type} {async}{name}({params}): {ret} {{
	{body}
}}
]]

local ts_function_snippet = function(type)
  return fmt(ts_function_fmt, {
    doc = f(function(args)
      local params_str = args[1][1]
      local return_type = args[2][1]
      local nodes = { "/**" }
      for _, param in ipairs(vim.split(params_str, ",", true)) do
        local name = param:match("([%a%d_-]+):?")
        local t = param:match(": ?([%S^,]+)")
        if name then
          local str = " * @param " .. name
          if t then
            str = str .. " {" .. t .. "}"
          end
          table.insert(nodes, str)
        end
      end
      vim.list_extend(nodes, { " * @returns " .. return_type, " */" })
      return nodes
    end, { 3, 4 }),
    type = t(type),
    async = c(1, { t("async "), t("") }),
    name = i(2, "funcName"),
    params = i(3),
    ret = d(4, function(args)
      local async = string.match(args[1][1], "async")
      if async == nil then
        return sn(nil, {
          r(1, "return_type", i(nil, "void")),
        })
      end
      return sn(nil, {
        t("Promise<"),
        r(1, "return_type", i(nil, "void")),
        t(">"),
      })
    end, { 1 }),
    body = i(0),
  }, {
    stored = {
      ["return_type"] = i(nil, "void"),
    },
  })
end

return {
  s("public", ts_function_snippet("public")),
  s("private", ts_function_snippet("private")),
}
