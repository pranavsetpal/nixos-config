from libqtile.config import Key, Drag, Click
from libqtile.backend.wayland import InputConfig
from libqtile.lazy import lazy


@lazy.function
def window_to_previous_screen(qtile, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)
        if switch_screen:
            qtile.cmd_to_screen(i - 1)

@lazy.function
def window_to_next_screen(qtile, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)
        if switch_screen:
            qtile.cmd_to_screen(i + 1)


wl_input_rules = {
    "type:keyboard": InputConfig(
        kb_layout="custom,us,us",
        kb_variant="homerow_semicolon,colemak,",
        kb_options="grp:rctrl_rshift_toggle,caps:backspace"
    )
}
wl_xcursor_size = 24

mod = "mod4"
keys = [
	# Shortcuts
	Key([mod], "w", lazy.spawn("librewolf"), desc="Open Browser"),
	Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
	Key([mod], "space", lazy.spawn("bemenu-run --prompt 'Run:' --line-height 26 --ch 17 --cw 1 --hp 5 --fn 'JetBrainsMono 10' --tf '#61AFEF' --hf '#61AFEF'"), desc="Spawn bemenu"),

	# Qtile
	Key([mod, "Shift"], "r", lazy.reload_config(), desc="Reload the config"),
	Key([mod, "Shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

	# Toggle Layouts
	Key([mod, "control"], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
	Key([mod], "Tab", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

	# Windows
	Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
	Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating state"),
	Key([mod], "m", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen state"),
	Key([mod], "v", lazy.window.toggle_minimize(), desc="Toggle minimize state"),
	Key([mod, "Shift"], "m", lazy.hide_show_bar(), desc="Hide bottom bar"),

	# Navigation
    Key([mod], "period", lazy.next_screen(), desc="Switch focus to next monitor"),
    Key([mod], "comma", lazy.prev_screen(), desc="Switch focus to previous monitor"),

	Key([mod], "n", lazy.layout.left(), desc="Move focus left"),
	Key([mod], "o", lazy.layout.right(), desc="Move focus right"),
	Key([mod], "e", lazy.layout.down(), desc="Move focus down"),
	Key([mod], "i", lazy.layout.up(), desc="Move focus up"),

	Key([mod, "shift"], "n", lazy.layout.shuffle_left(), desc="Move window left"),
	Key([mod, "shift"], "o", lazy.layout.shuffle_right(), desc="Move window right"),
	Key([mod, "shift"], "e", lazy.layout.shuffle_down(), desc="Move window down"),
	Key([mod, "shift"], "i", lazy.layout.shuffle_up(), desc="Move window up"),

	Key([mod, "control"], "n", lazy.layout.grow_left(), desc="Grow window left"),
	Key([mod, "control"], "o", lazy.layout.grow_right(), desc="Grow window right"),
	Key([mod, "control"], "e", lazy.layout.grow_down(), desc="Grow window down"),
	Key([mod, "control"], "i", lazy.layout.grow_up(), desc="Grow window up"),
	Key([mod], "d", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod, "control"], "period", window_to_next_screen(), desc="Move window to next screen"),
    Key([mod, "control"], "comma", window_to_previous_screen(), desc="Move window to previous screen"),
    Key([mod, "shift"], "period", window_to_next_screen(switch_screen=True), desc="Switch to * Move window to next screen"),
    Key([mod, "shift"], "comma", window_to_previous_screen(switch_screen=True), desc="Switch to * Move window to previous screen"),


	# Volume
	Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), desc="Toggle Speaker Mute"),
	Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), desc="Increase Speaker Volume"),
	Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), desc="Decrease Speaker Volume"),
	Key(["shift"], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), desc="Toggle Mic Mute"),
	Key(["shift"], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"), desc="Increase Mic Volume"),
	Key(["shift"], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"), desc="Decrease Mic Volume"),

	#Brightness
	Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -d intel_backlight set +1%")),
	Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -d intel_backlight set 1%-")),
	Key(["mod1"], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -d asus_screenpad set +1%")),
	Key(["mod1"], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -d asus_screenpad set 1%-")),

	# Screenshot
	Key([], "Print", lazy.spawn("slurp | grim -g - - | wl-copy", shell=True), desc="Copy interactive screenshot to clipboard"),
	Key(["Shift"], "Print", lazy.spawn("slurp | grim -g - ~/media/screenshots/$(date +%Y-%m-%d_%a_%H:%M:%S).png", shell=True), desc="Save interactive screenshot"),
	Key([mod], "Print", lazy.spawn("grim - | wl-copy", shell=True), desc="Copy monitor screenshot to clipboard"),
    Key([mod, "Shift"], "Print", lazy.spawn("grim ~/media/screenshots/$(date +%Y-%m-%d_%a_%H:%M:%S).png", shell=True), desc="Save monitor screenshot")
]

mouse = [
	Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], "Button2", lazy.window.bring_to_front()),
]
