-- custom fuction
local exports = {}

-- search current buffer fzf
exports.curr_buf_fzf = function()
    local opts = {
      sorting_strategy = 'ascending',
      layout_config = { prompt_position = 'top' }
    }
    require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

return exports
