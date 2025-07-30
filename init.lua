#sudo pacman -S python-pynvim

vim.api.nvim_set_keymap("n", "<C-x>", ":qa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.g.vimspector_enable_mappings = 'HUMAN'

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
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require('packer').startup(function(use)
 use 'wbthomason/packer.nvim'
 use 'puremourning/vimspector'

  -- Syntax-Highlighting und Code-Analyse
  use "nvim-treesitter/nvim-treesitter"
  use "neovim/nvim-lspconfig"

  -- Datei- und Projektmanagement
  use "nvim-telescope/telescope.nvim"
  use "nvim-tree/nvim-tree.lua"

  -- Statusleiste und Git-Integration
  use "nvim-lualine/lualine.nvim"
  use "lewis6991/gitsigns.nvim"

 if packer_bootstrap then
 require('packer').sync()
 end
end)
