local status, session = pcall(require, "auto-session")
if (not status) then return end

-- :SaveSession " saves or creates a session in the currently set `auto_session_root_dir`.
-- :SaveSession ~/my/custom/path " saves or creates a session in the specified directory path.
-- :RestoreSession " restores a previously saved session based on the `cwd`.
-- :RestoreSession ~/my/custom/path " restores a previously saved session based on the provided path.
-- :RestoreSessionFromFile ~/session/path " restores any currently saved session
-- :DeleteSession " deletes a session in the currently set `auto_session_root_dir`.
-- :DeleteSession ~/my/custom/path " deleetes a session based on the provided path.
-- :Autosession search
-- :Autosession delete

session.setup{
  log_level = 'error',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = false,
  auto_restore_enabled = false,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = nil
}

local status, session_lens = pcall(require, "session-lens")
if (not status) then return end

session_lens.setup {
  path_display = { 'shorten' },
  theme_conf = { border = true },
  previewer = true
}

