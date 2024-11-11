-- custom_mappings.lua
local M = {}

-- start compilation with vimtex
M.vimtex = {
  n = {
    ["<leader>ll"] = {"<cmd> VimtexCompile <CR>"}
  }
}

return M


