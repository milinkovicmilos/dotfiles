-- Monitor Setup
--
-- Main monitor
hl.monitor({
	output = "DP-1",
	mode = "1920x1080@144",
	position = "0x400",
})

-- Secondary monitor
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@75",
	position = "1920x0",
	transform = 1,
})

-- Programs
local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi --show drun --width=600 --prompt=Search..."

-- Autostart
hl.on("hyprland.start", function()
	-- Starts waybar
	local reloadWaybar = "$HOME/.scripts/reloadwaybar.sh"
	hl.exec_cmd(reloadWaybar)

	-- Starts hyprpaper
	local hyprpaper = "hyprpaper"
	hl.exec_cmd(hyprpaper)

	-- Set primary screen for xwayland apps
	local primary = "xrandr --output  DP-1 --primary"
	hl.exec_cmd(primary)
end)

-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Look and feel
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 1,

		col = {
			active_border = { colors = { "rgba(61afefaa)", "rgba(61afefaa)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true,

		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 5,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,

			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

-- Default animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = false, speed = 1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.3, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Dwindle
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

-- Misc
hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

-- Input
hl.config({
	input = {
		kb_layout = "us,rs,rs",
		kb_variant = ",latin,",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		numlock_by_default = true,

		follow_mouse = 2,
		sensitivity = 0,
	},
})

-- Keybindings
local mainMod = "SUPER"
local closeWindow = mainMod .. " + Q"
local toggleFloatingWindow = mainMod .. " + SHIFT + SPACE"
local toggleFullScreen = mainMod .. " + F"
local toggleGroup = mainMod .. " + W"
local toggleSplit = mainMod .. " + E"
local openTerminal = mainMod .. " + RETURN"
local openFileManager = mainMod .. " + R"
local openMenu = mainMod .. " + D"
local restartWaybar = mainMod .. " + SHIFT + R"
local screenshotFull = "Print"
local screenshotSelection = mainMod .. " + Print"
local discordMute = "Pause"
local obsSaveReplay = "F10"

hl.bind(closeWindow, hl.dsp.window.close())
hl.bind(toggleFloatingWindow, hl.dsp.window.float({ action = "toggle" }))
hl.bind(toggleFullScreen, hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(toggleGroup, hl.dsp.group.toggle())
hl.bind(toggleSplit, hl.dsp.layout("togglesplit"))
hl.bind(openTerminal, hl.dsp.exec_cmd(terminal))
hl.bind(openFileManager, hl.dsp.exec_cmd(fileManager))
hl.bind(openMenu, hl.dsp.exec_cmd(menu))
hl.bind(restartWaybar, hl.dsp.exec_cmd("$HOME/.scripts/reloadwaybar.sh"))
hl.bind(screenshotFull, hl.dsp.exec_cmd("$HOME/.scripts/screenshot-full-hypr.sh"))
hl.bind(screenshotSelection, hl.dsp.exec_cmd("$HOME/.scripts/screenshot-hypr.sh"))
hl.bind(discordMute, hl.dsp.pass({ window = "class:discord" }))
hl.bind(obsSaveReplay, hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

-- Move focus with VIM binds
local focusUp = mainMod .. " + K"
local focusDown = mainMod .. " + J"
local focusLeft = mainMod .. " + H"
local focusRight = mainMod .. " + L"

hl.bind(focusUp, hl.dsp.focus({ direction = "up" }))
hl.bind(focusDown, hl.dsp.focus({ direction = "down" }))
hl.bind(focusLeft, hl.dsp.focus({ direction = "left" }))
hl.bind(focusRight, hl.dsp.focus({ direction = "right" }))

-- Switching workspaces
-- Moving windows to workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move and resize floating windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Windows and workspaces
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- JetBrains IDEs
hl.window_rule({
	name = "jetbrains-ides-rule",
	match = {
		class = "(jetbrains-.*)",
		title = "^win(.*)",
	},

	no_initial_focus = true,
})

-- Discord (Move it to the bottom of second monitor)
hl.window_rule({
	name = "discord-rule",
	match = {
		class = "^(discord)$",
	},

	workspace = 6,
	float = true,
	size = { 1058, 700 },
	move = { 11, 1209 },
})

-- Pavucontrol
hl.window_rule({
	name = "pavucontrol-rule",
	match = {
		class = "org.pulseaudio.pavucontrol",
	},

	float = true,
	size = { 600, 600 },
	move = { 1250, 51 },
})

-- Screenshot still
hl.window_rule({
	name = "screenshot-still-rule",
	match = {
		class = "feh",
		title = ".*/ScreenShots/fullscreen.png",
	},

	float = true,
	size = { "monitor_w", "monitor_h" },
	move = { 0, 0 },
})

-- Workspace rules
for i = 1, 10 do
	local monitor = "DP-1"
	if i > 5 then
		monitor = "HDMI-A-1"
	end

	local default = false
	if i == 1 or i == 6 then
		default = true
	end

	hl.workspace_rule({ workspace = tostring(i), monitor = monitor, persistent = true, default = default })
end
