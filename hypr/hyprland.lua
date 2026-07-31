-------------------
-- COMPATABILITY --
-------------------

--hl.env("LIBVA_DRIVER_NAME", "nvidia")
--hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
--hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-------------
-- STARTUP --
-------------

hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent") -- thb idk
	hl.exec_cmd("/usr/bin/dunst") -- everybody and their mom freaks out if ts isnt running (aka wayland) (aka it takes FOUR MINUTES to launch)
	hl.exec_cmd("../hypr/vars/wifi-powersave.sh") -- powersave on wifi, custom script so you don't see my wifi ssid :)
	hl.exec_cmd("hyprpm reload") -- reload somthing i lowk forgot
	hl.exec_cmd("dbus-update-activation-environment --all") -- ? nah tbh idk what any of this does i js copied and pasted from the docs. maybe that's why nothing works lmaooo
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets") -- ts daemon pmo icl
	hl.exec_cmd("waybar") -- goated
	hl.exec_cmd("hyprpaper") -- wallpaper
	hl.exec_cmd("hypridle") -- auto lock i think
	--hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 18") -- differnet cursor. idk if i like this one so i might change it
	hl.exec_cmd("kitty") -- open terminal on startup
end)

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
	group = {
		--drag_into_group = 2,
		col = {
			border_active = "#c1c1c1",
			border_inactive = "#2e2e2e",
		},
		groupbar = {
			blur = true,
			rounding = 3,
			render_titles = false,
			col = {
				active = "#f1f1f1",
				inactive = "#2e2e2e",
			},
		},
	},
})

--hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
hl.config({ ecosystem = { enforce_permissions = true } })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })

-------------
-- PLUGINS --
-------------

--hl.config({
--  plugin = {
--    hyprbars = {
--      bar_height = 22,
--      bar_color = "rgba(0, 0, 0, 0.25)",
--      bar_blur = true,
--      bar_buttons_alignment = "left",
--      on_double_click = "hyprctl dispatch fullscreen 1",
--      bar_part_of_window = true,
--    },
--  },
--})
--
--hl.plugin.hyprbars.add_button({
--  bg_color = "rgb(ff4040)",
--  fg_color = "rgb(ffffff)",
--  size = 10,
--  icon = "",
--  action = "hyprctl dispatch killactive",
--})
--
--hl.plugin.hyprbars.add_button({
--  bg_color = "rgb(eeee11)",
--  fg_color = "rgb(000000)",
--  size = 10,
--  icon = "",
--  action = "hyprctl dispatch fullscreen 1",
--})

----------
-- VARS --
----------

local terminal = "kitty"
local menu = "wofi --show drun"
local fileManager = "dolphin"
--local browser = "firefox"
local browser = "librewolf"
local spotify = "spotify-launcher"
local claude = "claude-desktop"

----------------------
-- MOUSE / GESTURES --
----------------------

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.config({
	input = {
		sensitivity = -0.1,
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.37,
		},
	},
})

hl.env("HYPRCURSOR_THEME", "Bilbata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "18")

--------------
-- BINDINGS --
--------------

local mainMod = "SUPER"

-- apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(
		[[sh -c 'cliphist list | wofi --dmenu --pre-display-cmd "echo \"%s\" | cut -f 2" | cliphist decode | wl-copy && wtype -M ctrl -P v -m ctrl']]
	)
)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("/home/_vyndlar/scripts/launch.sh"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(claude))

-- window manager
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

-- window groups
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.group.next())
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.group.prev())

-- move windows
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- move workspaces
hl.bind("SUPER + Left", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + Right", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- move focus
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.focus({ direction = "down" }))

hl.unbind("F1")
hl.bind("F12", hl.dsp.exec_cmd(spotify))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }))

-- lock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 1 && hyprlock"))

-- brightness, volume
local brightness_down = "code:232"
local brightness_up = "code:233"

hl.bind(brightness_down, hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind(brightness_up, hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true }
)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
--hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--screenshots
--hl.bind("SUPER + Print",
--  hl.dsp.exec_cmd('grim -g "$(slurp)" -t png - | satty -f -'))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grimblast -s 1.5 save area - | satty -f -"))

-- hyprmon: managed monitor profile include
require("hyprmon")

--------------------
-- BORDER MANAGER --
--------------------
hl.config({
	general = {
		border_size = 2,
		col = {
			--active_border   = { colors = { "rgba(33ccffee)" } },
			active_border = { colors = { "#f1f1f1" } },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true,

		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,

		blur = {
			enabled = true,
			size = 5,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

------------------
-- WINDOW RULES --
------------------

-- float + hyperbar
--hl.window_rule({
--  name = "no bars",
--  match = { float = 0 },
--  ["hyprbars:no_bar"] = true,
--  fullscreen = 0,
--  maximize = 0,
--})

----------------
-- ANIMATIONS --
----------------
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "default" })
--hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "linear" })
--hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "linear", style = "popin 87%" })
--hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
--hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
--hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
--hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

--------------
-- MONITORS --
--------------
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })

hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
