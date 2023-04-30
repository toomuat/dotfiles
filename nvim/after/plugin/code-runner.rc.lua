local status, code_runner = pcall(require, "code_runner")
if (not status) then return end

code_runner.setup {
  mode = "float",
  -- put here the commands by filetype
  filetype = {
    lua = "lua",
    c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
    cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python -u",
    sh = "bash",
    typescript = "deno run",
    javascript = "node",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
  },
  float = {
    -- Key that close the code_runner floating window
    close_key = 'q',
    -- Window border (see ':h nvim_open_win')
    border = "rounded",
  }
}

vim.keymap.set('n', '<space>r', ':RunCode<CR>', { noremap = true, silent = false })

