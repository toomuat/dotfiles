local status, mason = pcall(require, "mason")
if (not status) then return end

mason.setup({})

-- LSPサーバーのインストールリスト
local servers = {
  -- "bashls",
  "clangd",
  -- "docker_compose_language_service",
  -- "dockerls",
  -- "erlangls",
  -- "eslint_d",
  -- "jdtls",
  -- "lua_ls",
  -- "metals",
  -- "pyright",
  -- "rust_analyzer",
  -- "tailwindcss",
  -- "terraformls",
  -- "tsserver",
  -- "cssls",
  -- "html",
  -- "gopls",
  -- "emmet_ls",
  -- "ocamllsp",
  -- "clojure_lsp",
}

-- LSPサーバーのインストール
local registry = require("mason-registry")
for _, server in ipairs(servers) do
  if not registry.is_installed(server) then
    vim.cmd("MasonInstall " .. server)
  end
end

-- LSPサーバーの設定ファイルを読み込む
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    local server = nil

    -- ファイルタイプに基づいてサーバーを決定
    if ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
      server = "tsserver"
    elseif ft == "c" or ft == "cpp" then
      server = "clangd"
    elseif ft == "python" then
      server = "pyright"
    elseif ft == "java" then
      server = "jdtls"
    elseif ft == "dockerfile" then
      server = "dockerls"
    elseif ft == "docker-compose" then
      server = "docker_compose_language_service"
    elseif ft == "sh" or ft == "bash" then
      server = "bashls"
    elseif ft == "terraform" then
      server = "terraformls"
    elseif ft == "erlang" then
      server = "erlangls"
    elseif ft == "scala" then
      server = "metals"
    elseif ft == "css" or ft == "scss" or ft == "less" then
      server = "cssls"
    elseif ft == "html" then
      server = "html"
    elseif ft == "go" then
      server = "gopls"
    elseif ft == "ocaml" then
      server = "ocamllsp"
    elseif ft == "clojure" then
      server = "clojure_lsp"
    elseif ft == "rust" then
      server = "rust_analyzer"
    elseif ft == "lua" then
      server = "lua_ls"
    end

    -- サーバーが決定されたら設定を読み込む
    if server then
      local ok, config = pcall(require, "after/lsp/" .. server)
      if ok then
        vim.lsp.start(config)
      end
    end
  end
})
