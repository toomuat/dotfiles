local status, fidget = pcall(require, "fidget")
if (not status) then return end

fidget.setup {
  text = {
    spinner = "pipe",
  },
  -- align = {
  --   bottom = true,
  --   right = true,
  -- },
  fmt = {
    -- leftpad = false,
    -- stack_upwards = false,
    task = function(task_name, message, percentage)
      return ""
    end
  },
}
