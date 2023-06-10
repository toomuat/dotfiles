local status, luasnip = pcall(require, "luasnip")
-- if (status) then return end
if (not status) then return end
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node

local date = function() return { os.date('%Y-%m-%d') } end

luasnip.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      func(date, {}),
    }),
    snip({
      trig = "meta",
      namr = "Metadata",
      dscr = "Yaml metadata format for markdown"
    },
      {
        text({ "---",
          "title: " }), insert(1, "note_title"), text({ "",
          "author: " }), insert(2, "author"), text({ "",
          "date: " }), func(date, {}), text({ "",
          "categories: [" }), insert(3, ""), text({ "]",
          "lastmod: " }), func(date, {}), text({ "",
          "tags: [" }), insert(4), text({ "]",
          "comments: true",
          "---", "" }),
        insert(0)
      }),
  },
  -- rust = rust,
})

-- vim.keymap.set("i", "<TAB>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { noremap = false, silent = true, expr = true })
-- vim.keymap.set("i", "<S-TAB>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
-- vim.keymap.set("s", "<TAB>", "<cmd>lua require'luasnip'.jump(1)<CR>")
-- vim.keymap.set("s", "<S-TAB>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
-- vim.keymap.set("i", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
-- vim.keymap.set("s", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")

