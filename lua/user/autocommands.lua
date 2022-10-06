-- autocmd! remove all autocommands, if entered under a group it will clear that group
--[[ vim.api.nvim_create_autocmd('BufWritePre', { ]]
--[[   group = vim.api.nvim_create_augroup('PreSave', {clear=true}) ]]
--[[   callback= function() ]]
--[[      ]]
--[[   end ]]
--[[ }) ]]
--[[ vim.api.nvim_create_autocmd('BufWritePre', {}) ]]
vim.cmd[[
  " Helper functions need to be in scope
  " Trim trailing whitespace and extra lines
  function! s:TrimTrailingWhitespace()
    let l:pos = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:pos)
  endfunction

  " Trims blank lines
  function! s:TrimBlankLines()
    let l:pos = getpos('.')
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', l:pos)
  endfunction

  " when editing a file, alwayws jump ot h the last known cursor position.
  " don't do it for commit messages, when the position is invalid, or when
  " inside an event handler
  augroup vimrcEx
    autocmd!
    autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
  augroup END

  augroup vimTrim
    autocmd!
    autocmd BufWritePre * call s:TrimTrailingWhitespace()
    " autocmd BufWritePre * call s:TrimBlankLines()
  augroup END

  " " Auto format on save
  " augroup fmt
  "   autocmd!
  "   autocmd BufWritePre * undojoin | Neoformat
  " augroup END
]]
