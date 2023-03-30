-- https://vi.stackexchange.com/questions/34703/how-to-transform-this-vimscript-into-lua
-- vim.cmd[[set rnu]]

-- vim.api.nvim_set_keymap('n', '<Tab>', 'jj', { noremap = true }) -- works
-- https://github.com/nanotee/nvim-lua-guide

function foo()
  print(1)
  return 1
end

-- vim.api.nvim_set_option('background', 'dark')

--vim.api.nvim_set_keymap('n', '<Tab>', ':lua foo()<CR>', { noremap = true }) -- works

local bar = {
    title = "Section Title",
    icon = "->",
    setup = function(ctx)
        -- called only once and if the section is being used
    end,
    update = function(ctx)
        -- hook callback, called when an update was requested by either the user of external events (using autocommands)
    end,
    draw = function(ctx)
        local file = io.popen('date')
        local output = file:read('*all')
        local rc = {file:close()}
        -- return "> string here\n> multiline"
        return output
    end,
    highlights = {
    }
}

require("sidebar-nvim").setup({
    disable_default_keybindings = 0,
    bindings = { ["q"] = function() require("sidebar-nvim").close() end },
    open = false,
    side = "left",
    initial_width = 40,
    hide_statusline = true,
    update_interval = 1000,
    sections = { "datetime", "git", "diagnostics", bar },
    section_separator = {"", "-----", ""},
    section_title_separator = {""},
    containers = {
        attach_shell = "/bin/sh", show_all = true, interval = 5000,
    },
    datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
    todos = { ignored_paths = { "~" } },
})
