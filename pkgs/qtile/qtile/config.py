mod = "mod4"
terminal = "kitty"

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig

import os
import subprocess
from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    subprocess.Popen([os.path.expanduser("~/.config/qtile/autostart.sh")])

wl_input_rules = {
    "type:keyboard": InputConfig(
        kb_layout="custom,us,us",
        kb_variant="homerow_semicolon,colemak,",
        kb_options="grp:alt_space_toggle"
    )
};

keys = [
	# Shortcuts
	Key([mod], "w", lazy.spawn("librewolf"), desc="Open Browser"),
	Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
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
	Key([mod, "Shift"], "m", lazy.hide_show_bar("top"), desc="Hide top bar"),


	# Navigation
	Key(["mod1"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
	Key(["mod1", "Shift"], "Tab", lazy.layout.previous(), desc="Move window focus to other window"),

	Key([mod], "n", lazy.layout.left(), desc="Move focus to left"),
	Key([mod], "o", lazy.layout.right(), desc="Move focus to right"),
	Key([mod], "e", lazy.layout.down(), desc="Move focus down"),
	Key([mod], "i", lazy.layout.up(), desc="Move focus up"),

	Key([mod, "shift"], "n", lazy.layout.shuffle_left(), desc="Move window to the left"),
	Key([mod, "shift"], "o", lazy.layout.shuffle_right(), desc="Move window to the right"),
	Key([mod, "shift"], "e", lazy.layout.shuffle_down(), desc="Move window down"),
	Key([mod, "shift"], "i", lazy.layout.shuffle_up(), desc="Move window up"),

	Key([mod, "control"], "n", lazy.layout.grow_left(), desc="Grow window to the left"),
	Key([mod, "control"], "o", lazy.layout.grow_right(), desc="Grow window to the right"),
	Key([mod, "control"], "e", lazy.layout.grow_down(), desc="Grow window down"),
	Key([mod, "control"], "i", lazy.layout.grow_up(), desc="Grow window up"),
	Key([mod], "d", lazy.layout.normalize(), desc="Reset all window sizes"),


	# Volume
	Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), desc="Toggle Speaker Mute"),
	Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), desc="Increase Speaker Volume"),
	Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), desc="Decrease Speaker Volume"),
	Key(["shift"], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), desc="Toggle Mic Mute"),
	Key(["shift"], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"), desc="Increase Mic Volume"),
	Key(["shift"], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"), desc="Decrease Mic Volume"),

	#Brightness
	Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +1%")),
	Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 1%-")),

	# Screenshot
	Key([], "Print", lazy.spawn("slurp | grim -g - - | wl-copy", shell=True), desc="Copy interactive screenshot to clipboard"),
	Key(["Shift"], "Print", lazy.spawn("slurp | grim -g - ~/media/screenshots/$(date +%Y-%m-%d_%a_%H:%M:%S).png", shell=True), desc="Save interactive screenshot"),
	Key([mod], "Print", lazy.spawn("grim - | wl-copy", shell=True), desc="Copy monitor screenshot to clipboard"),
    Key([mod, "Shift"], "Print", lazy.spawn("grim ~/media/screenshots/$(date +%Y-%m-%d_%a_%H:%M:%S).png", shell=True), desc="Save monitor screenshot")
]


groups = [ Group(i) for i in "123456789" ]
for group in groups:
	keys.extend([
		Key([mod], group.name, lazy.group[group.name].toscreen(), desc=f"Switch to group {group.name}"),
		Key([mod, "shift"], group.name, lazy.window.togroup(group.name, switch_group=True), desc=f"Switch to * move focused window to group {group.name}"),
		Key([mod, "control"], group.name, lazy.window.togroup(group.name), desc=f"Move focused window to group {group.name}")
	])

groups.append(ScratchPad("0", [ DropDown(
	"keepass", "keepassxc",
	 height=0.75, width=0.75,
	 x=0.125, y=0.125, opacity=1,
) ]))
keys.append(Key([mod], "0", lazy.group["0"].dropdown_toggle("keepass")))


layouts = [
	layout.Columns(
		border_normal="#101010",
		border_normal_stack="#303030",
		border_focus="#a0a0a0",
		border_focus_stack="#d0d0d0",
		border_width=2,
		border_on_single=True,
		grow_amount=4,
		insert_position=1,
	),
	layout.Max(),
]

widget_defaults = dict(
	font="FiraMono",
	fontsize=15,
	padding=8
)
extension_defaults = widget_defaults.copy()
accent_color = "#61afef"

screens = []
for j in range(1):
	screens.append(Screen(
		top=bar.Bar(
			[
				widget.Spacer(length=7),
				widget.GroupBox(
					highlight_color=["61afef", "282828"],
					borderwidth=2,
					margin_y=2,
					padding=2
				),
				widget.Sep(foreground="707070", size_percent=50),
				widget.WindowName(width=640, max_chars=48),

				widget.Spacer(),
				widget.Clock(format="%Y-%m-%d %a %H:%M:%S"),
				widget.Spacer(),

				widget.CPU(
					fmt=f"<span foreground='{accent_color}'>CPU:</span> {{}}%",
					format="{load_percent}",
					update_interval=1
				),
				widget.Sep(foreground="707070", size_percent=50),
				widget.Memory(
					fmt=f"<span foreground='{accent_color}'>RAM:</span> {{}} MiB",
					format="{MemUsed:.0f}",
					update_interval=1
				),
				widget.Sep(foreground="707070", size_percent=50),
				widget.PulseVolume(
					fmt=f"<span foreground='{accent_color}'>Spk:</span> {{}}",
					channel="Master"
				),
				widget.Sep(foreground="707070", size_percent=50),
				widget.Battery(
					fmt=f"<span foreground='{accent_color}'>Bat:</span> {{}}",
					format="{percent:1.0%}{char}",
					charge_char="+",
					discharge_char="-",
					unknown_char="",
					notify_below=5
				),
				widget.CurrentLayoutIcon(scale=0.80),
			],
		26)
	))


# Drag floating layouts.
mouse = [
	Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []	# type: list
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
	float_rules=[
		# Run the utility of `xprop` to see the wm class and name of an X client.
		*layout.Floating.default_float_rules,
		Match(wm_class="confirmreset"),	# gitk
		Match(wm_class="makebranch"),	# gitk
		Match(wm_class="maketag"),	    # gitk
		Match(wm_class="ssh-askpass"),	# ssh-askpass
		Match(title="branchdialog"),	# gitk
		Match(title="pinentry"),	    # GPG key password entry
	]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wmname = "L3GD"
