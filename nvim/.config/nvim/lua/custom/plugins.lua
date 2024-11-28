-- custom plugins table

local plugins = {
  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  
  -- compile .tex docs from neovim
  {
    "lervag/vimtex",
    lazy = false,
    --  calls the plugin
    init = function()
    -- default pdf viewer app
    vim.g['vimtex_view_method'] = "zathura"
    -- compiler options to pass when compiling .tex files
    vim.g.vimtex_compiler_latexmk = {
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        -- this is for .svg files for the \includesvg function
        '-shell-escape',
      },
    }
    end
  },
  -- override base lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- load custom configs
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- LSP
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
        "texlab"
      }
    }
  },
  -- over ride base nvim.cmp config
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  -- to customize cmp's autosuggestions, and add vs code style glyphs
  {
    "onsails/lspkind.nvim",
  }
}
return plugins
