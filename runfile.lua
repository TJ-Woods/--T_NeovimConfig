function Run_curr_file()
	local file_name = vim.api.nvim_buf_get_name(0)

	if string.sub(file_name, -3, -1) == ".py" then
		local py_cmd = vim.api.nvim_replace_termcodes("i" .. 'python "' .. file_name .. '"<CR>', true, false, true)
		vim.api.nvim_feedkeys(py_cmd, "t", false)
	elseif string.sub(file_name, -3, -1) == ".js" then
		local js_cmd = vim.api.nvim_replace_termcodes("i" .. 'node "' .. file_name .. '"<CR>', true, false, true)
		vim.api.nvim_feedkeys(js_cmd, "t", false)
	elseif string.sub(file_name, -2, -1) == ".c" then
		local name = string.sub(vim.api.nvim_buf_get_name(0), 0, -3) .. ".exe"
		-- Check for build.sh or similar, run that if exists, else run standard "gcc main.c -o main"
		if false then -- "[build.sh-exists]" then
			local build_sh = "build.sh" -- change to found build.sh file
			local build_sh_cmd =
				vim.api.nvim_replace_termcodes("i" .. 'call "' .. build_sh .. '" <CR>', true, false, true)
			vim.api.nvim_feedkeys(build_sh_cmd, "t", false)
		else
			local c_cmd = vim.api.nvim_replace_termcodes(
				"i" .. 'gcc "' .. file_name .. '" -o "' .. name .. '"<CR>',
				true,
				false,
				true
			)
			vim.api.nvim_feedkeys(c_cmd, "t", false)
		end
		if "[no-error-during-build]" then
			local c_run = vim.api.nvim_replace_termcodes('"' .. name .. '" <CR>', true, false, true)
			vim.api.nvim_feedkeys(c_run, "t", false)
		end
	elseif string.sub(file_name, -4, -1) == ".cpp" then
		local name = string.sub(vim.api.nvim_buf_get_name(0), 0, -5) .. ".exe"
		-- Check for build.sh, run it if exists, else run standard "g++ main.cpp -o main"
		if false then -- "[build.sh-exists]" then
			local build_sh = "build.sh" -- change to found build.sh file
			local build_sh_cmd = vim.api.nvim_replace_termcodes("i" .. '"' .. build_sh .. '" <CR>', true, false, true)
		else
			local cpp_cmd = vim.api.nvim_replace_termcodes(
				"i" .. 'g++ "' .. file_name .. '" -o "' .. name .. '"<CR>',
				true,
				false,
				true
			)
			vim.api.nvim_feedkeys(cpp_cmd, "t", false)
		end
		if "[no-error-during-build]" then
			local cpp_run = vim.api.nvim_replace_termcodes('"' .. name .. '" <CR>', true, false, true)
			vim.api.nvim_feedkeys(cpp_run, "t", false)
		end
	elseif string.sub(file_name, -4, -1) == ".ps1" then
		local ps1_cmd =
			vim.api.nvim_replace_termcodes("i" .. 'powershell "' .. file_name .. '" <CR>', true, false, true)
		vim.api.nvim_feedkeys(ps1_cmd, "t", false)
	elseif string.sub(file_name, -4, -1) == ".bat" then
		local bash_cmd = vim.api.nvim_replace_termcodes("i" .. 'call "' .. file_name .. '" <CR>', true, false, true)
		vim.api.nvim_feedkeys(bash_cmd, "t", false)
	elseif string.sub(file_name, -3, -1) == ".sh" then
		local shell_cmd = vim.api.nvim_replace_termcodes("i" .. 'call "' .. file_name .. '" <CR>', true, false, true)
		vim.api.nvim_feedkeys(shell_cmd, "t", false)
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
