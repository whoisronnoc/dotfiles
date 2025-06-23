-- https://github.com/nosduco/remote-sshfs.nvim
-- :RemoteSSHFSConnect <[user@]host>:/path -p <port>
return {
	"nosduco/remote-sshfs.nvim",
	lazy = true,
	cmd = "RemoteSSHFSConnect",
	dependencies = { "nvim-telescope/telescope.nvim" },
	opts = {
		-- Refer to the configuration section below
		-- or leave empty for defaults
	},
}
