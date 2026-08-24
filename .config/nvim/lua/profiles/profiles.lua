-- stylua: ignore
return {
	Utils.computer:host_contains("MkIV")
		and { import = "profiles.work" }
	or Utils.computer:host_contains("Neo")
		and { import = "profiles.neo" }
	or { import = "profiles.home" },
}
