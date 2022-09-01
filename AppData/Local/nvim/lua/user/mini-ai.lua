local status_ok, ai = pcall(require, "mini.ai")
if not status_ok then
  return
end

ai.setup({})
