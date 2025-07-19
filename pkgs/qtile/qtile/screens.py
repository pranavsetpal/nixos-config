from libqtile import bar, layout, widget
from libqtile.config import Screen
# from Xlib import display as xdisplay

# def get_num_monitors():
#     num_monitors = 0
#     try:
#         display = xdisplay.Display()
#         screen = display.screen()
#         resources = screen.root.xrandr_get_screen_resources()
#
#         for output in resources.outputs:
#             monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
#             preferred = False
#             if hasattr(monitor, "preferred"):
#                 preferred = monitor.preferred
#             elif hasattr(monitor, "num_preferred"):
#                 preferred = monitor.num_preferred
#             if preferred:
#                 num_monitors += 1
#     except Exception as e:
#         # always setup at least two monitors
#         return 2
#     else:
#         return num_monitors

# num_screens = get_num_monitors()
num_screens = 2

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
accent_color = "#50b0e0"

screens = [
    Screen(bottom=bar.Bar([
        widget.Spacer(length=7),
        widget.GroupBox(
            visible_groups=[str(screen) + group for group in "123456789"],
            highlight_color=[accent_color[1:], "282828"],
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
            unknown_char=""
        ),
        widget.CurrentLayout(icon_first=True, scale=0.80),
    ], 26))
    for screen in range(num_screens)
]
