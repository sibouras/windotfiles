--- @sync entry
return {
  entry = function()
    local cur = cx.active.current
    local files = cur.files

    -- Find first non directory index
    for i = 1, #files do
      if not files[i].cha.is_dir then
        ya.emit('reveal', { files[i].url })
        return
      end
    end

    ya.notify({
      title = 'Goto first file',
      content = 'No files here',
      level = 'warn',
      timeout = 3,
    })
  end,
}
