local wezterm = require("wezterm")
local act = wezterm.action

local config = {
  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = "a", mods = "LEADER|CTRL",  action=act{SendString="\x01"}},
    -- { key = 'n', mods = 'LEADER', action = act.SpawnCommandInNewTab { cwd="/home/tom" }},
    { key = 'n', mods = 'LEADER', action = act{ActivateTabRelative=1}},
    { key = 'p', mods = 'LEADER', action = act{ActivateTabRelative=-1}},
    { key = "-", mods = "LEADER",
      action=act{
        SplitVertical={
          domain="CurrentPaneDomain",
          cwd="/home/tom",
        }
      }
    },
    { key = "\\", mods = "LEADER",
      action=act{
        SplitHorizontal={
          domain="CurrentPaneDomain",
          cwd="/home/tom",
        }
      }
    },
    { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "c", mods = "LEADER",       action=act{SpawnTab="CurrentPaneDomain"}},
    { key = "h", mods = "LEADER",       action=act{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER",       action=act{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER",       action=act{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER",       action=act{ActivatePaneDirection="Right"}},
    { key = "H", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Right", 5}}},
    { key = "1", mods = "LEADER",       action=act{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action=act{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action=act{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action=act{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action=act{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action=act{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action=act{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action=act{ActivateTab=7}},
    { key = "9", mods = "LEADER",       action=act{ActivateTab=8}},
    { key = "&", mods = "LEADER|SHIFT", action=act{CloseCurrentTab={confirm=true}}},
    { key = "x", mods = "LEADER",       action=act{CloseCurrentPane={confirm=true}}},

    { key = "n", mods="SHIFT|CTRL",     action="ToggleFullScreen" },
    { key = 'm', mods = 'LEADER', action = 'ShowLauncher' },
    -- launchers
    --[[
    {
      key = " ",
      mods = "LEADER",
      action = act({
        ShowLauncherArgs = {
          flags = "FUZZY|WORKSPACES",
        },
      }),
    },
    { key = "n", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(1) },
    { key = "p", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(-1) },
    { key = "b", mods = "LEADER|CTRL", action = act({ EmitEvent = "trigger-nvim-with-scrollback" }) },
    { key = "d", mods = "LEADER|CTRL", action = act.ShowDebugOverlay },

    { key = "Enter", mods = "LEADER", action = "QuickSelect" },
    { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
    {
      key = "O",
      mods = "Windows",
      action = act({
        QuickSelectArgs = {
          patterns = {
            "https?://\\S+",
          },
          action = wezterm.action_callback(function(window, pane)
            local url = window:get_selection_text_for_pane(pane)
            wezterm.log_info("opening: " .. url)
            wezterm.open_with(url)
          end),
        },
      }),
    },
    ]]--
  },
  set_environment_variables = {},
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE",
}

-- map tab activation keys
--for i = 0, 9 do
--  if i + 1 >= 10 then break end
--  local key_string = tostring(i + 1)
--  table.insert(config.keys, {
--    key = key_string,
--    mods = "CTRL",
--    action = act({ ActivateTab = i }),
--  })
--end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  local wsl_domains = wezterm.default_wsl_domains()

  for _, dom in ipairs(wsl_domains) do
    dom.default_cwd = "/home/tom"
  end

  config.wsl_domains = wsl_domains
  config.default_domain = "WSL:Ubuntu"
  config.default_prog = {"wsl.exe"}
  config.default_cwd = "/home/tom"
else
  -- table.insert(config.launch_menu, { label = "zsh", args = {"zsh", "-l"} })
  -- table.insert(config.launch_menu, { label = "bash", args = {"bash", "-l"} })
end

return config

