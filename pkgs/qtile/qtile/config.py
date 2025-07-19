from libqtile import layout
from libqtile.config import Match

import os
import subprocess
from libqtile import hook

from groups import *
from keybinds import *
from screens import *

@hook.subscribe.startup_once
def autostart():
    subprocess.Popen([os.path.expanduser("~/.config/qtile/autostart_wayland.sh")])


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

dgroups_key_binder = None
dgroups_app_rules = []	# type: list

follow_mouse_focus = True
bring_front_click = True
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wmname = "L3GD"
