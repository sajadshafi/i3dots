return {
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup {
                render = 'background', -- or 'foreground' or 'first_column'
                enable_named_colors = true,
                enable_tailwind = false,
                enable_virt = true,
                tailwind = {
                    mode = 'all',             -- 'all' or 'lsp'
                    virtual_text = true,
                    virtual_text_pos = 'eol', -- 'eol' or 'inline'
                },
                excluded_filetypes = { 'markdown', 'txt', 'alpha' },
            }
        end
    },
}
