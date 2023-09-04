local Worktree = require("git-worktree")

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

local wtpkg = "~/.local/scripts/worktree-package-installer.sh"

Worktree.on_tree_change(function(op, metadata)
    if op == Worktree.Operations.Switch then
        os.execute('tmux neww -d -n node-packages bash -c \"cd ' ..
            metadata.path .. ' && ' .. wtpkg .. ' \"')
    end

    if op == Worktree.Operations.Create then
        os.execute('tmux neww -d -n node-packages bash -c \"cd ' ..
            metadata.path .. ' && ' .. wtpkg .. ' \"')
    end
end)
