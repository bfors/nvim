vim.opt.autochdir = false
vim.keymap.set({ "n" }, "<leader>c", [[:w<CR>:!cargo run<CR>]], { desc = "" })
vim.keymap.set({ "n" }, "<leader>p", [[:w<CR>:!python %<CR>]], { desc = "" })
vim.keymap.set({ "n" }, "<leader>t", [[:w<CR>:term python %<CR>]], { desc = "" })

vim.keymap.set({ "n" }, "<leader>fs", [[:w<CR>]], { desc = "" })
vim.keymap.set({ "n" }, "<leader>bp", [[:bp<CR>]], { desc = "" })
vim.keymap.set({ "n" }, "<leader>bn", [[:bn<CR>]], { desc = "" })
vim.keymap.set({ "n" }, "<leader>bd", [[:bp<bar>sp<bar>bn<bar>bd<CR>]], { desc = "" })
vim.keymap.set({ "n" }, "<leader>q", [[:bd<CR>]], { desc = "" })

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

-- Update list of files to use with harpoon
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Harpoon keymaps for J K L ;
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

-- -- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- Terminal mode binds
vim.keymap.set("t", "<C-j>", function() harpoon:list():select(1) end)
vim.keymap.set("t", "<C-k>", function() harpoon:list():select(2) end)

-- vim.keymap.set("t", "<C-l>", function() harpoon:list():select(3) end)
vim.keymap.set("t", "<C-;>", function() harpoon:list():select(4) end)
vim.keymap.set({ "t" }, "<ESC>", [[<C-\><C-n>]], { desc = "" })

-- Harpoon-like mark jumping
vim.keymap.set("n", "<C-a>", [['a zz]])
vim.keymap.set("n", "<C-s>", [['s zz]])
vim.keymap.set("i", "<C-a>", [[<ESC>'a zzi]])
vim.keymap.set("i", "<C-s>", [[<ESC>'s zzi]])

-- Quick project file tree
vim.keymap.set("n", "<C-t>", [[:term lsd -I '*__pycache__*' -I '*egg-info' --tree<CR>]])

local plpath = require("plenary.path")

local function load_commands(relative_path)
	local abspath = plpath.absolute(relative_path)
	local local_func = dofile(abspath)
	if local_func ~= nil then
		vim.keymap.set({ "n" }, "<leader>t", ":w<CR>:term " .. local_func["test"] .. "<CR>", { desc = "" })
		vim.keymap.set({ "n" }, "<leader>y", ":w<CR>:split<CR>:term " .. local_func["execute"] .. "<CR>", { desc = "" })
		vim.keymap.set({ "t" }, "<leader>t", ":w<CR>:term " .. local_func["test"] .. "<CR>", { desc = "" })
		vim.keymap.set({ "t" }, "<leader>y", ":w<CR>:split<CR>:term " .. local_func["execute"] .. "<CR>", { desc = "" })
	end
end

local path1 = plpath:new("../commands.lua")
local path2 = plpath:new("../../commands.lua")

if plpath.exists(path1) then
	print(path1)
	load_commands(path1)
elseif plpath.exists(path2) then
	print(path2)
	load_commands(path2)
end
