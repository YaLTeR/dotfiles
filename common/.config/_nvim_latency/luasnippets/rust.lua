function next_line_fn()
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  local curline = vim.api.nvim_buf_get_lines(0, linenr, linenr + 1, false)[1]
  if curline == nil then
    return ''
  end

  return curline:match('fn (%S+)%(')
end

function prev_line_fn()
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  local curline = vim.api.nvim_buf_get_lines(0, linenr - 2, linenr - 1, false)[1]
  if curline == nil then
    return ''
  end

  return curline:match('fn (%S+)%(')
end

return {
  s('inst', fmt('#[instrument("{}"){}]', {
    d(1, function() return sn(nil, { i(1, next_line_fn()) }) end),
    i(2, ', skip_all'),
  })),

  s('tsp', fmt('let _span = tracy_client::span!("{}");', {
    d(1, function() return sn(nil, { i(1, prev_line_fn()) }) end),
  })),
}
