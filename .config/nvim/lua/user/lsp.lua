local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup {
	ensure_installed = {
		'cssls',
		'html',
		'lua_ls',
		'pylsp',
		'texlab',
		'tsserver',
		'vimls',
	}
}

local function lsp_attach(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local keymap = vim.keymap
	local buf = vim.lsp.buf
	local diagnostic = vim.diagnostic
	local opts = { buffer = bufnr, noremap = true, silent = true }
	keymap.set('n', 'gd', buf.definition, opts)
	keymap.set('n', 'gD', buf.declaration, opts)
	keymap.set('n', 'gi', buf.implementation, opts)
	keymap.set('n', 'gr', buf.references, opts)
	keymap.set('n', 'K', buf.hover, opts)
	keymap.set('n', '<Leader>k', buf.signature_help, opts)
	keymap.set('n', '<Leader>D', buf.type_definition, opts)
	keymap.set('n', '<Leader>f', function() buf.format { async = true } end, opts)
	keymap.set('n', '<Leader>rn', buf.rename, opts)
	keymap.set('n', '<Leader>ca', buf.code_action, opts)
	keymap.set('n', '<Leader>q', diagnostic.setloclist, opts)
	keymap.set('n', '<Leader>e', diagnostic.open_float, opts)
	keymap.set('n', '[d', diagnostic.goto_prev, opts)
	keymap.set('n', ']d', diagnostic.goto_next, opts)
end

local function handler(config)
	local server_config = vim.tbl_deep_extend('keep', config, {
		on_attach = lsp_attach,
		capabilities = lsp_capabilities,
	})
	return function(server_name)
		lspconfig[server_name].setup(server_config)
	end
end

mason_lspconfig.setup_handlers {
	handler {},
	cssls = handler {
		filetypes = { 'css', 'scss', 'less', 'html' }
	},
	kotlin_language_server = handler {
		root_dir = lspconfig.util.root_pattern('settings.gradle.kts')
	},
	lua_ls = handler {
		settings = {
			Lua = {
				-- runtime = {
				-- 	version = 'LuaJIT',
				-- },
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file('', true),
					-- library = {
					-- 	'/Users/marcin/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
					-- 	-- it has to be at the end of the table
					-- 	table.unpack(vim.api.nvim_get_runtime_file('', true)),
					-- }
				},
				telemetry = {
					enable = false,
				},
			}
		}
	},
	pylsp = handler {
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = {
							'E221',
							'E241',
						}
					},
					-- jedi = {
					-- 	environment = '/opt/local/bin/python3',
					-- },
					mypy = {
						-- overrides = { '-–ignore-missing-imports' }
					},
				},
			}
		}
	},
	tsserver = handler {
		on_attach = function(client, bufnr)
			lsp_attach(client, bufnr)
			local util = vim.lsp.util
			vim.keymap.set('n', 'gd', function()
				client.request('workspace/executeCommand',
					{
						command = '_typescript.goToSourceDefinition',
						arguments = {
							util.make_text_document_params().uri,
							util.make_position_params().position
						}
					},
					vim.lsp.handlers['textDocument/definition'])
			end, { buffer = bufnr, noremap = true, silent = true })
		end
	},
}

handler { cmd = {'/opt/local/bin/clangd-mp-17'} } ('clangd')
