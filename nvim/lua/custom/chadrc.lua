---@type ChadrcConfig
local M = {}

M.ui = { theme = 'onedark' }
-- make nvim transparent for that rice
M.ui.transparency = true
-- load custom plugins and over-rides
M.plugins = "custom.plugins"
-- load custom mappings, mainly for vimtex
M.mappings = require "custom.mappings"
-- return custom config
return M

