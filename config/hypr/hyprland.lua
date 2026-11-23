-- Hyprland configuration in Lua.
-- See https://wiki.hypr.land/ for documentation. Migrated from hyprland.conf.
-- If this file is present, Hyprland 0.55+ loads it instead of hyprland.conf.

----------------
-- VARIABLES  --
----------------

local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local mainMod = "SUPER"

----------------
-- MONITORS   --
----------------

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

------------------------
-- ENV VARIABLES      --
------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

------------------------
-- AUTOSTART          --
------------------------

-- SIGUSR2 makes a running waybar reload and rebuild its bars for the current
-- outputs. Spawning a fresh waybar here instead would race with autostart and
-- leave two stacked bars.
local function reload_waybar()
	hl.exec_cmd("killall -SIGUSR2 waybar")
end

hl.on("hyprland.start", function()
	hl.exec_cmd(terminal)
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("mako")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

--hl.on("monitor.added", reload_waybar)
--hl.on("monitor.removed", reload_waybar)

----------------------------------------
-- LOOK AND FEEL / GENERAL OPTIONS    --
----------------------------------------

hl.config({
	general = {
		gaps_in = 2.5,
		gaps_out = 5,

		border_size = 2,

		["col.active_border"] = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
		["col.inactive_border"] = "rgba(595959aa)",

		resize_on_border = true,
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 0,
			render_power = 1,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = false,
			size = 1,
			passes = 0,
			vibrancy = 0,
		},
	},

	animations = {
		enabled = false,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 1,
		disable_splash_rendering = true,
	},

	render = {
		direct_scanout = true,
	},

	debug = {
		vfr = true,
		error_position = 0,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
})

----------------------------
-- ANIMATION CURVES        --
----------------------------

-- animations.enabled is false above, so these curves stay dormant until you turn animations on.

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

----------------------------
-- ANIMATIONS              --
----------------------------

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
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

------------------------------------
-- WORKSPACE RULES (smart gaps)   --
------------------------------------

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

------------------------
-- PERMISSIONS        --
------------------------

-- Permission changes require a Hyprland restart.
hl.permission({
	binary = "/usr/(bin|local/bin)/grim",
	type = "screencopy",
	mode = "allow",
})
hl.permission({
	binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
	type = "screencopy",
	mode = "allow",
})

------------------------
-- LAYER RULES        --
------------------------

-- Keep slurp's overlay out of the captured frame.
hl.layer_rule({
	name = "no-anim-selection",
	match = { namespace = "^selection$" },
	no_anim = true,
})

----------------
-- KEYBINDS   --
----------------

-- Application shortcuts
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + vim-style hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. tostring(i), hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Scratchpad (special workspace)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move / resize windows with mainMod + LMB / RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness (repeating + locked, equivalent to old `bindel`)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ repeating = true, locked = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

-- Media keys (locked, equivalent to old `bindl`)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("hyprshot -m region"))

-- Resize active window with mainMod + ALT + hjkl
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 25, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -25, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -25, relative = true }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = 25, relative = true }))

-- Swap active window with another window with mainMod + CTRL + hjkl
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.swap({ direction = "d" }))
