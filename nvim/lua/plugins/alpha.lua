return {
  "goolord/alpha-nvim",
  opts = function()
    local startify = require("alpha.themes.startify")
    return startify
  end,
  config = function(_, startify)
    require("alpha").setup(startify.opts)
  end,
}
