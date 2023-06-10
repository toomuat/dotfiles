local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    -- mode = "buffers",
    mode = "tabs",
    separator_style = 'thin',
    -- separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = true,
    show_close_icon = true,
    color_icons = true,
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    truncate_names = true,
    tab_size = 9,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    }
  },
  highlights = {
    separator = {
      fg = '#073642',
      bg = '#002b36',
    },
    separator_selected = {
      fg = '#073642',
    },
    background = {
      fg = '#657b83',
      bg = '#002b36'
    },
    buffer_selected = {
      fg = '#fdf6e3',
      bold = true,
    },
    fill = {
      bg = '#073642'
    }
  },
})

-- vim.keymap.set('n', '<CTRL-i>', 'i')
-- vim.keymap.set('n', '<TAB>', '<Cmd>BufferLineCycleNext<CR>')
-- vim.api.nvim_del_keymap('n', '<CTRL-i>')
vim.keymap.set('n', '<C-n>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<C-p>', '<Cmd>BufferLineCyclePrev<CR>', {})
