return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {

      -- Required.
      'nvim-lua/plenary.nvim',
    },
    config = function(_, opts)
      require('obsidian').setup(opts)
      function OpenObsidian()
        local is_obsidian_running = vim.system({ 'pgrep', 'Obsidian' }, { text = true }):wait()
        if is_obsidian_running.code == 0 then
          vim.cmd("silent !open -g 'obsidian://open?vault=brain&file=" .. vim.fn.expand '%:.:r' .. "'")
        end
      end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = vim.fn.expand '~' .. '/SAPDevelop/github/paschdan/brain/*.md',
        callback = function()
          OpenObsidian()
        end,
      })

      vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianBacklinks<cr>', { desc = 'Obsidian Backlinks' })
      vim.keymap.set('n', '<leader>of', '<cmd>ObsidianFollowLink<cr>', { desc = 'Obsidian Follow Link' })
      -- vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Obsidian New Note" })
      vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianToday<cr>', { desc = 'Obsidian Today' })
      vim.keymap.set('n', '<leader>oy', '<cmd>ObsidianYesterday<cr>', { desc = 'Obsidian Yesterday' })
      vim.keymap.set('n', '<leader>or', '<cmd>ObsidianTomorrow<cr>', { desc = 'Obsidian Tomorrow' })
      vim.keymap.set('n', '<leader>on', ':ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>', { desc = 'Insert Note Template' })
      vim.keymap.set('n', '<leader>os', ':s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>')
    end,
    opts = {
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'journal',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, default tags to add to each new daily note created.
        default_tags = { 'daily-notes' },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = 'daily-note.md',
      },

      notes_subdir = 'notes',
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,
      follow_url_func = function(url)
        vim.fn.jobstart { 'open', url } -- Mac OS
      end,
      ui = {
        checkboxes = {
          [' '] = { char = '☐', hl_group = 'ObsidianTodo' },
          ['x'] = { char = '✔', hl_group = 'ObsidianDone' },
        },
      },
      templates = {
        folder = '~/SAPDevelop/github/paschdan/brain/_templates/',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          CURRENT_YEAR = function()
            return os.date('%Y', os.time() - 86400)
          end,
          CURRENT_MONTH = function()
            return os.date('%m', os.time() - 86400)
          end,
          CURRENT_DATE = function()
            return os.date('%d', os.time() - 86400)
          end,
          FOAM_DATE_YEAR = function()
            return os.date('%Y', os.time() - 86400)
          end,
        },
      },

      workspaces = {
        {
          name = 'notes',
          path = '~/SAPDevelop/github/paschdan/brain',
        },
      },
    },
  },
}
