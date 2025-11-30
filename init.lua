--sudo pacman -S python-pynvim xclip

vim.api.nvim_set_keymap("n", "<C-x>", ":NvimTreeClose<CR>::qa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-t>", ":below split | resize10 | terminal<CR>i<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y | call system("xclip -selection clipboard", @")', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "dd", { noremap = true, silent = true })

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy '+',
    ['*'] = require('vim.ui.clipboard.osc52').copy '*',
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste '+',
    ['*'] = require('vim.ui.clipboard.osc52').paste '*',
  },
}

local ensure_packer = function()
 local fn = vim.fn
 local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

 if fn.empty(fn.glob(install_path)) > 0 then
 fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
 vim.cmd [[packadd packer.nvim]]
 return true
 end
 return false
end

local packer_bootstrap = ensure_packer()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require('packer').startup(function(use)
 use 'wbthomason/packer.nvim'
 use 'puremourning/vimspector'

  -- Syntax-Highlighting und Code-Analyse
  use "nvim-treesitter/nvim-treesitter"
  use "neovim/nvim-lspconfig"

  -- Datei- und Projektmanagement
  use "nvim-telescope/telescope.nvim"
  use "nvim-tree/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "ibhagwan/fzf-lua"

  -- Statusleiste und Git-Integration
  use "nvim-lualine/lualine.nvim"
  use "lewis6991/gitsigns.nvim"

 if packer_bootstrap then
 require('packer').sync()
 end
end)

local function plugin_available(plugin_name)
 local status_ok, _ = pcall(require, plugin_name)
 return status_ok
end

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

if plugin_available("nvim-tree") then
 require("nvim-tree").setup({
 -- Konfiguration für Nvim-Tree
 })
 vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname == "" or bufname == vim.fn.getcwd() then
    vim.cmd "NvimTreeOpen"
  end
 end,
})
end

if plugin_available("bufferline") then
 require("bufferline").setup({
 -- Konfiguration für Nvim Buffer
 })
end
