
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local plugins = {

	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	"neovim/nvim-lspconfig",

	{
		"savq/melange-nvim",
		config = function()
			vim.cmd("colorscheme melange")
		end,
		priority = 1000
	},

	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup()
			require("mini.cursorword").setup()
			require("mini.indentscope").setup()
		end
	},

	{
		"nvim-lualine/lualine.nvim",
		config = true
	},

	{
		"akinsho/bufferline.nvim",
		config = true	
	},

	{
		"nvim-tree/nvim-tree.lua",
		config = true,
		keys = {
			{ 
				"<leader>tt", 
				function()
					require("nvim-tree.api").tree.toggle()
				end,
				desc = "Toggle File Tree"
			},
		}
	},

	{
		"folke/which-key.nvim",
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
		end
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find File"
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Find String"
			}
		}
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true
	},
		
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost" , "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup{
				highlight = {
					enable = true
				}
			}
		end
	},

	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end
		}
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			--			'hrsh7th/cmp-omni',
			'saadparwaiz1/cmp_luasnip'
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},

				sources = cmp.config.sources({
      		{ name = "nvim_lsp" },
      		{ name = "luasnip" },
      		{ name = "buffer" },
      		{ name = "path" },
					--		{ name = "omni" }
    		}),

				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
      			if cmp.visible() then
        			cmp.select_next_item()
      			elseif luasnip.expand_or_jumpable() then
        			luasnip.expand_or_jump()
      			elseif has_words_before() then
        			cmp.complete()
      			else
        			fallback()
      			end
    			end, { "i", "s" }),

    			["<S-Tab>"] = cmp.mapping(function(fallback)
      			if cmp.visible() then
        			cmp.select_prev_item()
      			elseif luasnip.jumpable(-1) then
        			luasnip.jump(-1)
      			else
        			fallback()
      			end
    			end, { "i", "s" }),
				}	
			})
		end
	},
	
	{
		"p00f/clangd_extensions.nvim",
		ft={ "cpp", "hpp", "h", "c" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = true
	},
}

require('plugins.lazy').bootstrap()
require('lazy').setup(plugins)
