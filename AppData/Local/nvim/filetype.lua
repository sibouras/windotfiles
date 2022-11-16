vim.filetype.add({
  extension = {
    conf = "conf",
    ejs = "ejs",
    json = "jsonc",
  },
  filename = {
    [".eslintrc"] = "jsonc",
    [".prettierrc"] = "jsonc",
    [".babelrc"] = "jsonc",
    [".stylelintrc"] = "jsonc",
  },
  pattern = {
    [".*config/git/config"] = "gitconfig",
    [".env.*"] = "sh",
  },
})
