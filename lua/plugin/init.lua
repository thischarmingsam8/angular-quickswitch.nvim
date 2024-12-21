-- Based on code from Matthias Weiss
-- Original repository: https://github.com/matthiasweiss/angular-quickswitch.nvim

local M = {}

local file_path_transformations = {
	unchanged = function(path)
		return path
	end,

	classToTemplate = function(path)
		return path:gsub("%.ts$", ".html")
	end,
	templateToClass = function(path)
		return path:gsub("%.html$", ".ts")
	end,

	stylesToClass = function(path)
		return path:gsub("%.scss$", ".ts")
	end,
	classToStyles = function(path)
		return path:gsub("%.ts$", ".scss")
	end,

	stylesToTemplate = function(path)
		return path:gsub("%.scss$", ".html")
	end,
	templateToStyles = function(path)
		return path:gsub("%.html$", ".scss")
	end,
}

local function open_target_file(opts)
	local relative_file_path = vim.fn.expand("%")

	for _, transformation in ipairs(opts.file_path_transformation_map) do
		if string.match(relative_file_path, transformation.regex) then
			local file_to_open = transformation.transform(relative_file_path)
			vim.cmd.edit(file_to_open)
			return
		end
	end

	error(":" .. opts.command .. " could not determine target file", 1)
end

function M.quick_switch_class()
	local file_path_transformation_map = {
		{ regex = "%.scss$", transform = file_path_transformations.stylesToClass },
		{ regex = "%.ts$", transform = file_path_transformations.unchanged },
		{ regex = "%.html$", transform = file_path_transformations.templateToClass },
	}

	open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchClass" })
end

function M.quick_switch_template()
	local file_path_transformation_map = {
		{ regex = "%.scss$", transform = file_path_transformations.stylesToTemplate },
		{ regex = "%.ts$", transform = file_path_transformations.classToTemplate },
		{ regex = "%.html$", transform = file_path_transformations.unchanged },
	}

	open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchTemplate" })
end

function M.quick_switch_styles()
	local file_path_transformation_map = {
		{ regex = "%.scss$", transform = file_path_transformations.unchanged },
		{ regex = "%.ts$", transform = file_path_transformations.classToStyles },
		{ regex = "%.html$", transform = file_path_transformations.templateToStyles },
	}

	open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchStyles" })
end

function M.setup(opts)
	opts = opts or {}

	vim.api.nvim_create_user_command("NgQuickSwitchComponent", M.quick_switch_class, {})
	vim.api.nvim_create_user_command("NgQuickSwitchTemplate", M.quick_switch_template, {})
	vim.api.nvim_create_user_command("NgQuickSwitchStyles", M.quick_switch_styles, {})

	if opts.use_default_keymaps then
		vim.keymap.set("n", "<leader>ac", ":NgQuickSwitchComponent<cr>")
		vim.keymap.set("n", "<leader>as", ":NgQuickSwitchStyles<cr>")
		vim.keymap.set("n", "<leader>at", ":NgQuickSwitchTemplate<cr>")
	end
end

return M
