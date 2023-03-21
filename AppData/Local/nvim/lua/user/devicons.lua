local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

devicons.set_icon({
  astro = {
    icon = "",
    color = "#ff7e33",
    name = "astro",
  },
})
