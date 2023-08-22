local cmp_kinds = {
	Text = '  ',
	Method = '  ',
	Function = '  ',
	Constructor = '  ',
	Field = '  ',
	Variable = '  ',
	Class = '  ',
	Interface = '  ',
	Module = '  ',
	Property = '  ',
	Unit = '  ',
	Value = '  ',
	Enum = '  ',
	Keyword = '  ',
	Snippet = '  ',
	Color = '  ',
	File = '  ',
	Reference = '  ',
	Folder = '  ',
	EnumMember = '  ',
	Constant = '  ',
	Struct = '  ',
	Event = '  ',
	Operator = '  ',
	TypeParameter = '  ',
}

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- language server installation kit
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- autocompletion support
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- See https://github.com/williamboman/mason-lspconfig.nvim#setup
			-- The order of setup should be "mason", "mason-lspconfig".
			-- After setting up mason-lspconfig you may set up servers via lspconfig

			require("mason").setup()
			require("mason-lspconfig").setup({
				-- A list of servers to automatically install if they're not already
				-- installed. Example: { "rust_analyzer@nightly", "lua_ls" }
				-- This setting has no relation with the `automatic_installation` setting.
				-- See https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers and
				-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
				-- for a list of available LSP servers (they are not the same of mason package names).
				---@type string[]
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
				},

				-- Whether servers that are set up (via lspconfig)
				-- should be automatically installed if they're not already installed.
				-- This setting has no relation with the `ensure_installed` setting.
				-- Can either be:
				--   - false: Servers are not automatically installed.
				--   - true: All servers set up via lspconfig are automatically installed.
				--   - { exclude: string[] }: All servers set up via lspconfig, except
				--     the ones provided in the list, are automatically installed.
				--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
				---@type boolean
				automatic_installation = false,

				-- See `:h mason-lspconfig.setup_handlers()`
				---@type table<string, fun(server_name: string)>?
				handlers = nil,
			})

			-- Setup servers via lspconfig, with the additional completion capabilities offered by nvim-cmp.
			-- See:
			-- - https://github.com/neovim/nvim-lspconfig/wiki/Snippets
			-- Since language servers are managed by mason, we can request it the list of installed servers.
			local lspconfig = require('lspconfig')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local servers = require('mason-lspconfig').get_installed_servers()
			for _, server_name in ipairs(servers) do
				lspconfig[server_name].setup({
					-- on_attach = my_custom_on_attach,
					capabilities = capabilities,
					on_init = function(client)
						-- Setup 'lua_ls' server to include vim library, if current file belongs
						-- to nvim config (otherwise all .lua files would include this).
						-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls (however, the
						-- following works only if changing settings.Lua property instead of settings like written here)
						if server_name == "lua_ls" and require("core.utils").is_cwd_nvim_config() then
							client.config.settings.Lua = vim.tbl_deep_extend('force',
								client.config.settings.Lua, {
									-- Make the server aware of Neovim runtime files
									workspace = {
										library = { vim.env.VIMRUNTIME }
										-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
										-- library = vim.api.nvim_get_runtime_file("", true)
									}
								})

							client.notify("workspace/didChangeConfiguration",
								{ settings = client.config.settings })
						end
						return true
					end
				})
			end

			-- Setup LuaSnip
			local luasnip = require("luasnip")

			-- Setup nvim-cmp
			local cmp = require("cmp")
			-- Main cmp setup
			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}),
				-- Add VsCode-like icons to types in cmp menu.
				-- See https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
						return vim_item
					end,
				},
			}

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end
	},
}
