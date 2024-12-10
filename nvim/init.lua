require 'config.options'
require 'config.keymaps'
require 'config.tmux'
require 'config.autocmd'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.autocompletion',
  require 'plugins.autoformat',
  require 'plugins.cmp',
  require 'plugins.copilot',
  require 'plugins.copilot-chat',
  require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.lspconfig',
  require 'plugins.mini',
  require 'plugins.misc',
  require 'plugins.neo-tree',
  require 'plugins.neogit',
  require 'plugins.none-ls',
  require 'plugins.nvim-ufo',
  require 'plugins.obsidian',
  require 'plugins.session',
  require 'plugins.snacks',
  require 'plugins.telescope',
  require 'plugins.tokyonight',
  require 'plugins.treesitter',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
