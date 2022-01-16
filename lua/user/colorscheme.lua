-- local colorscheme = "material"
local colorscheme = "tokyonight"
-- local colorscheme = "darkspace"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found")
  return
else
  -- color scheme variants
  -- vim.g.material_style= "deep ocean"
  -- vim.g.material_style= "oceanic"
  -- vim.g.material_style= "palenight"
  -- vim.g.material_style= "lighter"
  -- vim.g.material_style= "darker"

end
