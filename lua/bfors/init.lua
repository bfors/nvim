vim.opt.autochdir = true
vim.keymap.set({ 'n' }, '<leader>c', [[:w<CR>:!cargo run<CR>]], { desc = '' })
vim.keymap.set({ 'n' }, '<leader>p', [[:w<CR>:!python %<CR>]], { desc = '' })
vim.keymap.set({ 'n' }, '<leader>t', [[:w<CR>:term python %<CR>]], { desc = '' })
vim.keymap.set({ 'n' }, '<leader>fs', [[:w<CR>]], { desc = '' })
vim.keymap.set({ 'n' }, '<leader>bp', [[:bp<CR>]], { desc = '' })
vim.keymap.set({ 'n' }, '<leader>bn', [[:bn<CR>]], { desc = '' })
vim.keymap.set({ 'n' }, '<leader>bd', [[:bd<CR>]], { desc = '' })

vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.rs",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !rustfmt %")
            vim.cmd("edit")
        end,
    }
)

