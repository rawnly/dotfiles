---@type vim.lsp.Config
return {
	-- TypeScript 7 advertises its embedded libraries with a bundled:// URI.
	-- Neovim's file watcher expects filesystem globs, so discard only those
	-- virtual-library watchers while keeping normal project file watching.
	handlers = {
		["client/registerCapability"] = function(err, result, ctx, config)
			if result and result.registrations then
				local registrations = {}

				for _, registration in ipairs(result.registrations) do
					if registration.method == "workspace/didChangeWatchedFiles" then
						local options = registration.registerOptions
						local watchers = options and options.watchers

						if type(watchers) == "table" then
							options.watchers = vim.tbl_filter(function(watcher)
								local glob_pattern = watcher.globPattern
								local pattern = glob_pattern
								local base_uri

								if type(glob_pattern) == "table" then
									pattern = glob_pattern.pattern
									base_uri = glob_pattern.baseUri
									if type(base_uri) == "table" then
										base_uri = base_uri.uri
									end
								end

								local is_bundled = function(value)
									return type(value) == "string" and value:match("^bundled:///") ~= nil
								end

								return not (is_bundled(pattern) or is_bundled(base_uri))
							end, watchers)
						end

						if type(options) == "table" and type(options.watchers) == "table" and #options.watchers > 0 then
							table.insert(registrations, registration)
						end
					else
						table.insert(registrations, registration)
					end
				end

				result.registrations = registrations
			end

			return vim.lsp.handlers["client/registerCapability"](err, result, ctx, config)
		end,
	},
}
