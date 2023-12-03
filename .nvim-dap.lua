require("dap").adapters.lldb = {
	type = "executable",
	command = "/home/gentb/.local/share/nvim/mason/packages/codelldb/codelldb", -- adjust as needed
	name = "lldb",
}
require("dap").adapters.rust = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "/home/gentb/.local/share/nvim/mason/packages/codelldb/codelldb", -- adjust as needed
		args = {"--port", "${port}"},
	}
}
local debug_tls = {
	name = "Debug tls",
	type = "lldb",
	request = "launch", -- could also attach to a currently running process
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/examples/target/debug/', 'file')
  end,	
	cwd = "${workspaceFolder}/examples/tls",
	args = {},
	runInTerminal = true,
}

local debug_tls_process = {
	name = "Attach to tls process",
	type = "rust",
	request = "attach",
	pid = require("dap.utils").pick_process,
	args = {},
}
require('dap').configurations.rust = {
	debug_tls, -- different debuggers or more configurations can be used here
	debug_tls_process
}
