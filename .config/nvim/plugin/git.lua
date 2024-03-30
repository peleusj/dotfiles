require("gitsigns").setup({
    yadm = {
        enable = true
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs",
            function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
        map("v", "<leader>hr",
            function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function() gs.blame_line { full = true } end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function() gs.diffthis("~") end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end
})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- fugitive shortcuts for yadm
local yadm_repo = vim.fn.expand(" $HOME/.local/share/yadm/repo.git")

-- auto-complete for our custom fugitive Yadm command
-- https://github.com/tpope/vim-fugitive/issues/1981#issuecomment-1113825991
vim.cmd(([[
                function! YadmComplete(A, L, P) abort
                    return fugitive#Complete(a:A, a:L, a:P, {'git_dir': expand("%s")})
                endfunction
            ]]):format(yadm_repo))

vim.cmd((
    [[command! -bang -nargs=? -range=-1 -complete=customlist,YadmComplete Yadm exe fugitive#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", <q-args>, { 'git_dir': expand("%s") })]]
):format(yadm_repo))

local function fugitive_command(nargs, cmd_name, cmd_fugitive, cmd_comp)
    vim.api.nvim_create_user_command(cmd_name,
        function(t)
            local bufnr = vim.api.nvim_get_current_buf()
            local buf_git_dir = vim.b.git_dir
            vim.b.git_dir = vim.fn.expand(yadm_repo)
            vim.cmd(cmd_fugitive .. " " .. t.args)
            -- after the fugitive window switch we must explicitly
            -- use the buffer num to restore the original 'git_dir'
            vim.b[bufnr].git_dir = buf_git_dir
        end,
        {
            nargs = nargs,
            complete = cmd_comp and string.format("customlist,%s", cmd_comp) or nil,
        }
    )
end

-- fugitive_command("?", "Yadm", "Git", "fugitive#Complete")
fugitive_command("?", "Yit", "Git", "YadmComplete")
fugitive_command("*", "Yread", "Gread", "fugitive#ReadComplete")
fugitive_command("*", "Yedit", "Gedit", "fugitive#EditComplete")
fugitive_command("*", "Ywrite", "Gwrite", "fugitive#EditComplete")
fugitive_command("*", "Ydiffsplit", "Gdiffsplit", "fugitive#EditComplete")
fugitive_command("*", "Yhdiffsplit", "Ghdiffsplit", "fugitive#EditComplete")
fugitive_command("*", "Yvdiffsplit", "Gvdiffsplit", "fugitive#EditComplete")
fugitive_command(1, "YMove", "GMove", "fugitive#CompleteObject")
fugitive_command(1, "YRename", "GRename", "fugitive#RenameComplete")
fugitive_command(0, "YRemove", "GRemove")
fugitive_command(0, "YUnlink", "GUnlink")
fugitive_command(0, "YDelete", "GDelete")
