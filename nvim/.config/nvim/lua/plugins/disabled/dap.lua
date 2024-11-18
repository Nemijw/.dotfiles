return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
			"theHamsta/nvim-dap-virtual-text",
		},
		lazy = true,
		config = function()
			local function getHighestVersionDirectory(dir)
				local command = "dir /B " .. dir -- For Windows, use 'dir /B ' .. dir instead
				local max_version, max_dir = -1, ""
				local p = io.popen(command)
				local lines = p:lines()
				for dirname in lines do
					local version = tonumber(dirname:match("net(%d+%.%d+)"))
					if version and version > max_version then
						max_version = version
						max_dir = dirname
					end
				end
				if p ~= nil then
					p:close()
				end

				return max_dir
			end

			require("nvim-dap-virtual-text").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.adapters.coreclr = {
				type = "executable",
				command = "C:/Users/nuq686/scoop/apps/netcoredbg/3.0.0-1018/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			Moaid_config = {
				debug_dllPath = nil,
			}
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						local path = vim.fn.getcwd()
						local sep = path:match("[/\\]") -- Get the path separator used (either / or \)
						local last_dir = path:match("([^" .. sep .. "]+" .. sep .. "?)$")
						local project_name = last_dir:sub(1, -1) -- Remove the trailing separator if it exists
						local version_directory = path .. "\\bin\\Debug"
						local latest_version = getHighestVersionDirectory(version_directory)
						-- logger:info('Hieghest version: ' .. latest_version)
						local executable_path = version_directory
							.. "\\"
							.. latest_version
							.. "\\"
							.. project_name
							.. ".dll"
						-- local tokens = string.gmatch(path, "\\")
						-- local project_name = tokens[#(tokens) - 1] .. "\\"
						if Moaid_config.debug_dllPath ~= nill then
							executable_path = Moaid_config.debug_dllPath
						end

						local result = vim.fn.input("Path to dll: ", executable_path, "file")
						Moaid_config.debug_dllPath = result
						-- logger:info('Result: ' .. result)
						return result
					end,
					env = "ASPNETCORE_ENVIRONMENT=Development",
					args = { "Development" },
					-- program = function()
					-- return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					-- end,
				},
			}
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dapui.setup()

			-- vim.keymap.set("n", "<leader>dc", function()
			-- 	dap.continue()
			-- end)
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F9>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F10>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<Leader>dt", function()
				dap.toggle_breakpoint()
			end)
			-- vim.keymap.set("n", "<Leader>B", function()
			-- 	dap.set_breakpoint()
			-- end)
			-- vim.keymap.set("n", "<Leader>lp", function()
			-- 	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			-- end)
			-- vim.keymap.set("n", "<Leader>dr", function()
			-- 	dap.repl.open()
			-- end)
			-- vim.keymap.set("n", "<Leader>dl", function()
			-- 	dap.run_last()
			-- end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end)
			-- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			-- 	require("dap.ui.widgets").preview()
			-- end)
			-- vim.keymap.set("n", "<Leader>df", function()
			-- 	local widgets = require("dap.ui.widgets")
			-- 	widgets.centered_float(widgets.frames)
			-- end)
			-- vim.keymap.set("n", "<Leader>ds", function()
			-- 	local widgets = require("dap.ui.widgets")
			-- 	widgets.centered_float(widgets.scopes)
			-- end)

			--vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		end,
	},
}
