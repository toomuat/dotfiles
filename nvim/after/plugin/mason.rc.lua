local status, mason = pcall(require, "mason")
if (not status) then return end

mason.setup({})

-- LSPサーバーのインストールリスト
local servers = {
  "bash-language-server",
  "clangd",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "eslint_d",
  "lua-language-server",
  "pyright",
  "rust-analyzer",
  "tailwindcss-language-server",
  "terraform-ls",
  "typescript-language-server",
  "css-lsp",
  "html-lsp",
  "gopls",
  "emmet-ls",
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
      server = "typescript-language-server"
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
      -- パスの構造を確認して表示
      -- vim.notify("LSP server detected: " .. server .. ", searching for config", vim.log.levels.INFO)
      -- vim.notify("LSP config paths search order: 1. lsp/" .. server .. ".lua", vim.log.levels.DEBUG)

      -- 直接ファイルパスを指定して読み込み
      local lsp_config_file = vim.fn.stdpath("config") .. "/lsp/" .. server .. ".lua"
      local config = nil
      local ok = false

      if vim.fn.filereadable(lsp_config_file) == 1 then
        -- vim.notify("Found LSP config file: " .. lsp_config_file, vim.log.levels.INFO)
        ok, config = pcall(dofile, lsp_config_file)
        if not ok then
          vim.notify("Failed to load LSP config from file: " .. lsp_config_file .. ". Error: " .. tostring(config), vim.log.levels.WARN)
        end
      else
        vim.notify("LSP config file not found: " .. lsp_config_file, vim.log.levels.DEBUG)
        -- パスを使用してrequireを試みる
        ok, config = pcall(require, "lsp." .. server)
        if not ok then
          vim.notify("Failed to load LSP config from module lsp." .. server .. ". Error: " .. tostring(config), vim.log.levels.DEBUG)
        end
      end

      if ok and config then
        -- lspsagaの確認はここで実行し、エラーをより詳しく表示
        local saga_status, saga_err = pcall(require, "lspsaga")
        if not saga_status then
          vim.notify("lspsaga is not loaded. Error: " .. tostring(saga_err), vim.log.levels.WARN)
        end

        -- LSP設定が設定オブジェクトでない場合、デフォルト設定を作成
        if type(config) ~= "table" then
          vim.notify("LSP config is not a table, creating default config for " .. server, vim.log.levels.WARN)
          config = {
            name = server,
            cmd = { vim.fn.exepath(server) or server },
            root_dir = function() return vim.loop.cwd() end
          }
        end

        -- 必要なフィールドがない場合は追加
        if not config.name then config.name = server end

        -- サーバー設定を適用してLSPを開始
        -- vim.notify("Starting LSP for " .. server .. " with config: " .. vim.inspect(config), vim.log.levels.DEBUG)
        local lsp_start_ok, lsp_start_err = pcall(vim.lsp.start, config)
        if not lsp_start_ok then
          vim.notify("Failed to start LSP for " .. server .. ". Error: " .. tostring(lsp_start_err), vim.log.levels.ERROR)
        else
          -- vim.notify("Successfully started LSP for " .. server, vim.log.levels.INFO)
        end
      else
        vim.notify("No valid config found for LSP server: " .. server, vim.log.levels.WARN)
      end
    end
  end
})
