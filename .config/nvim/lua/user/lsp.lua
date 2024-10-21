local lspconfig = require 'lspconfig'
local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

local function handler(config)
	local server_config = vim.tbl_deep_extend('keep', config, {
		capabilities = cmp_nvim_lsp.default_capabilities(),
	})
	return function(server_name)
		lspconfig[server_name].setup(server_config)
	end
end

mason.setup {}
mason_lspconfig.setup {
	ensure_installed = {
		'cssls',
		'html',
		'lua_ls',
		-- 'pylsp',
		'texlab',
		'ts_ls',
		'vimls',
	}
}
mason_lspconfig.setup_handlers {
	handler {},
	cssls = handler {
		filetypes = { 'css', 'scss', 'less', 'html' }
	},
	kotlin_language_server = handler {
		root_dir = lspconfig.util.root_pattern('settings.gradle.kts')
	},
	-- lua_ls = handler {
	-- 	settings = {
	-- 		Lua = {
	-- 			-- runtime = {
	-- 			-- 	version = 'LuaJIT',
	-- 			-- },
	-- 			workspace = {
	-- 				checkThirdParty = false,
	-- 				library = vim.api.nvim_get_runtime_file('', true),
	-- 				-- library = {
	-- 				-- 	'/Users/marcin/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
	-- 				-- 	-- it has to be at the end of the table
	-- 				-- 	table.unpack(vim.api.nvim_get_runtime_file('', true)),
	-- 				-- }
	-- 			},
	-- 			telemetry = {
	-- 				enable = false,
	-- 			},
	-- 		}
	-- 	}
	-- },
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
	ts_ls = handler {
		on_attach = function(client, bufnr)
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
	basedpyright = handler {
		settings = {
			basedpyright = {
				analysis = {
					diagnosticSeverityOverrides = {
						reportInvalidTypeForm = 'warning',
						reportDeprecated = 'warning',
					}
				}
			}
		}
	},
}

-- handler { cmd = {'/opt/local/bin/clangd-mp-17'} } ('clangd')
