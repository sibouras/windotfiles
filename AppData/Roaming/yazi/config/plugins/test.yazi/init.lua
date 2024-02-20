return {
  entry = function()
    state.i = state.i or 0
    ya.err('i = ' .. state.i)

    state.i = state.i + 1
  end,
}
