--- packer --
require("packer").startup(function(use) 
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { "ellisonleao/gruvbox.nvim" }
    vim.cmd("colorscheme gruvbox")

    use ( 'nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'} )

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            {'neovim/nvim-lspconfig', 
                opts = {
                    autoformat = false,
                }
            },
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
end)

-- options --
vim.opt.guicursor     = ""
vim.opt.nu            = true
vim.opt.shiftwidth    = 4
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.expandtab     = true
vim.opt.wrap          = false
vim.opt.smartindent   = true
vim.opt.incsearch     = true
vim.opt.termguicolors = true
vim.opt.updatetime    = 50
vim.opt.undofile      = true
vim.opt.scrolloff     = 10

-- remap -- 
vim.g.mapleader = " "

-- keymap --
vim.keymap.set('n', '<leader>.', ':bnext<cr>', {})
vim.keymap.set('n', '<leader>,', ':bNext<cr>', {})
vim.keymap.set('n', '<leader>bx', ':bdelete<cr>', {})
vim.keymap.set('n', '<leader>wh', ':split<cr>', {})
vim.keymap.set('n', '<leader>wv', ':vsplit<cr>', {})
vim.keymap.set('n', '<leader>wx', ':close<cr>', {})
vim.keymap.set('n', '<leader>h', ':wincmd h<cr>', {})
vim.keymap.set('n', '<leader>j', ':wincmd j<cr>', {})
vim.keymap.set('n', '<leader>k', ':wincmd k<cr>', {})
vim.keymap.set('n', '<leader>l', ':wincmd l<cr>', {})

-- telescope setup -- 
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- treesitter setup --
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "cpp", "zig", "bash", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
}

-- LSP-Zero setup --
local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

-- local cmp          = require('cmp')
-- local cmp_select   = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<Tab>']    = cmp.mappings.select_next_item(cmp_select),
--     ['<S-Tab>']  = cmp.mappings.select_prev_item(cmp_select),
--     ['<C-y']     = cmp.mappings.confirm({ select = true }),
--     ['<C-Space'] = cmp.mappings.complete()
-- })

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    -- ensure_installed = {'clangd', 'zls'},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

require('lspconfig').zls.setup({
    on_init = function(client)
        vim.g.zig_fmt_autosave = 0
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end
})

-- LuaLine setup --
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox_dark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {'branch', 'diff', 'diagnostics'},
        lualine_x = {'buffers'},
        lualine_y = {'progress'},
        lualine_z = {'encoding', 'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'filename'},
        lualine_c = {},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
