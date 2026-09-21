local wezterm = require("wezterm")
local config = require("config")

-- Map your env value -> exact WezTerm scheme name
local themes = {
	-- vscode = "Vs Code Dark+ (Gogh)", -- exact name
	-- nord = "Nord (Gogh)",
	-- onedark = "One Dark (Gogh)",
	catppuccinMocha = "Catppuccin Mocha (Gogh)",
}

-- read env var safely
local selected = (os.getenv("WEZTERM_THEME") or ""):gsub("%s+", "")

-- validate the target exists among built-ins; if not, fall back
local builtin = wezterm.get_builtin_color_schemes()
local target = themes[selected]
if target and builtin[target] then
	config.color_scheme = target
else
	-- optional: pick a sensible fallback
	config.color_scheme = "Vs Code Dark+ (Gogh)"
end

return config
