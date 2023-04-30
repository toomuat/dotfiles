local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<space>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<space>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<space>hp', gs.preview_hunk)
  end
}
