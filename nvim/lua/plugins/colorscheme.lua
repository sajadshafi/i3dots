local function enable_transparency()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.cmd(":hi statusline guibg=NONE")
end

return {
    {
        "sajadshafi/nebula.nvim",
        config = function()
            vim.cmd.colorscheme("nebula")
            enable_transparency()

            -- Example: enable transparency
            -- require("nebula").setup({ transparent = true })
            -- require("nebula").apply()

            -- -- Lualine integration example:
            -- require('lualine').setup({ options = { theme = require('nebula').lualine_theme() } })
        end
    }
    --     {
    --         "catppuccin/nvim",
    --         name = "catppuccin",
    --         config = function()
    --             require("catppuccin").setup({
    --                 flavour = "mocha", -- latte, frappe, macchiato, mocha
    --                 transparent_background = true,
    --                 integrations = {
    --                     treesitter = true,
    --                     native_lsp = {
    --                         enabled = true,
    --                         underlines = {
    --                             errors = { "undercurl" },
    --                             hints = { "undercurl" },
    --                             warnings = { "undercurl" },
    --                             information = { "undercurl" },
    --                         },
    --                     },
    --                     cmp = true,
    --                     gitsigns = true,
    --                     telescope = {
    --                         enabled = true
    --                     },
    --                     lualine = true,
    --                     indent_blankline = { enabled = true },
    --                     mason = true,
    --                     notify = true,
    --                 },
    --             })
    --
    --             -- Load colorscheme
    --             vim.cmd.colorscheme("catppuccin")
    --             enable_transparency()
    --         end,
    --     }
}
