local function run_cmd(cmd)
	local command = vim.api.nvim_replace_termcodes("i" .. cmd .. "<CR>", true, false, true)
	vim.api.nvim_feedkeys(command, "t", false)
end

local function get_os()
	local os_name = vim.loop.os_uname().sysname
	return os_name
end

local function get_call_func(os_name)
	local call = ""
	if os_name == "Windows_NT" then
		call = "call "
		-- elseif os_name == "<linux>" then
		-- local call = "call"
	else
		vim.print("Unsupported OS '" .. os_name .. "'")
	end
	return call
end

local function has_suffix(str, substr)
	local len = string.len(substr)
	local contains = string.sub(str, -len, -1) == substr
	return contains
end

function Run_curr_file()
	local file_name = vim.api.nvim_buf_get_name(0)
	vim.cmd.write(file_name)

	local os_name = get_os()
	local call = get_call_func(os_name)

	if has_suffix(file_name, ".py") then
		run_cmd('python "' .. file_name .. '"')
	elseif has_suffix(file_name, ".js") then
		run_cmd('node "' .. file_name .. '"')
	elseif has_suffix(file_name, ".c") then
		local name = string.sub(vim.api.nvim_buf_get_name(0), 0, -3) .. ".exe"
		-- Check for build.sh or similar, run that if exists, else run standard "gcc main.c -o main"
		if false then -- "[build_file-exists]" then
			local build_file = "build.sh" -- change to found build file
			run_cmd(call .. '"' .. build_file .. '"')
		else
			run_cmd('gcc "' .. file_name .. '" -o "' .. name .. '"')
		end
		if "[no-error-during-build]" then
			run_cmd('"' .. name .. '"')
		end
	elseif has_suffix(file_name, ".cpp") then
		local name = string.sub(vim.api.nvim_buf_get_name(0), 0, -5) .. ".exe"
		-- Check for build.sh, run it if exists, else run standard "g++ main.cpp -o main"
		if false then -- "[build_file-exists]" then
			local build_file = "build.sh" -- change to found build file
			run_cmd(call .. '"' .. build_file .. '"')
		else
			run_cmd('g++ "' .. file_name .. '" -o "' .. name('"'))
		end
		if "[no-error-during-build]" then
			run_cmd('"' .. name .. '"')
		end
	elseif has_suffix(file_name, ".ps1") then
		run_cmd('powershell "' .. file_name .. '"')
	elseif has_suffix(file_name, ".bat") then
		run_cmd(call .. '"' .. file_name .. '"')
	elseif has_suffix(file_name, ".sh") then
		run_cmd(call .. '"' .. file_name .. '"')
	else
		local name = vim.fn.expand("%:t")
		vim.print([[
Cannot run this file ']] .. name .. [['; it is not supported by this plugin. --T
Supported file types include:
    > Python (.py)
    > JavaScript (.js)
    > C (.c) [option to use build.sh]
    > C++ (.cpp) [option to use build.sh]
    > Powershell (.ps1)
    > batch (.bat)
    > shell (.sh)
        ]])
		return 0
	end

	local term_height = 0.25 -- Percentage of window height
	local curr_win_height = vim.api.nvim_win_get_height(0)
	local dis_height = math.floor(curr_win_height * term_height)
	vim.cmd(":below " .. dis_height .. "split | term")
end
