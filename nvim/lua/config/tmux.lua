-- tmux
tmux_pane_function = function(dir)
  -- NOTE: variable that controls the auto-cd behavior
  local auto_cd_to_new_dir = false
  -- if no dir is passed, use the current file's directory
  local file_dir = dir or vim.fn.expand '%:p:h'
  local pane_width = 60
  -- Simplified this, was checking if a pane with a width of 60 existed, so if I
  -- resized my pane, shit broke
  local has_panes = vim.fn.system('tmux list-panes | wc -l'):gsub('%s+', '') ~= '1'
  -- Check if the current pane is zoomed (maximized)
  local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub('%s+', '') == '1'
  -- Escape the directory path for shell
  -- Escape single quotes in the directory, otherwise my apple icloud dir won't work
  local escaped_dir = file_dir:gsub("'", "'\\''")
  -- If any additional pane exists
  if has_panes then
    if is_zoomed then
      -- Compare the stored pane directory with the current file directory
      if auto_cd_to_new_dir and vim.g.tmux_pane_dir ~= escaped_dir then
        -- If different, cd into the new dir
        vim.fn.system('tmux send-keys -t :.+ \'cd "' .. escaped_dir .. '"\' Enter')
        -- Update the stored directory to the new one
        vim.g.tmux_pane_dir = escaped_dir
        -- print("Directories do NOT match!")
      else
        -- print("Directories match!")
      end
      -- If zoomed, unzoom and switch to right pane
      vim.fn.system 'tmux resize-pane -Z'
      -- Simulate pressing Ctrl-l to move to the right
      vim.fn.system 'tmux send-keys C-l'
    else
      -- If not zoomed, zoom current pane
      vim.fn.system 'tmux resize-pane -Z'
    end
  else
    -- Store the initial directory in a Neovim variable
    if vim.g.tmux_pane_dir == nil then
      vim.g.tmux_pane_dir = escaped_dir
      -- print("Stored tmux pane dir: " .. vim.g.tmux_pane_dir)
    end
    -- If the right pane doesn't exist, open it with zsh and DISABLE_PULL variable
    vim.fn.system('tmux split-window -h -l ' .. pane_width .. ' \'cd "' .. escaped_dir .. '" && DISABLE_PULL=1 zsh\'')
    -- Simulate pressing Ctrl-l to move to the right
    vim.fn.system 'tmux send-keys C-l'
    -- I have a really strange issue, when opening a tmux pane for the FIRST TIME
    -- zsh-vi-mode can only move out of that pane if I press escape and then get to insert mode
    -- So when opening the pane for the first time, I'm sending Escape and 'i'
    vim.fn.system 'tmux send-keys Escape i'
  end
end
-- If I execute the function without an argument, it will open the dir where the
-- current file lives
vim.keymap.set('n', '<M-t>', function()
  tmux_pane_function()
end, { desc = 'Terminal on tmux pane on the right' })
