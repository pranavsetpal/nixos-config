from libqtile.config import Group, Key, ScratchPad, DropDown
from libqtile.lazy import lazy
from screens import num_screens
from keybinds import mod, keys


@lazy.function
def group_to_screen(qtile, group):
    cur_screen = qtile.screens.index(qtile.current_screen)
    group_name = str(cur_screen) + group
    qtile.groups_map[group_name].toscreen()

@lazy.function
def window_to_group(qtile, group, switch_group=False):
    cur_screen = qtile.screens.index(qtile.current_screen)
    group_name = str(cur_screen) + group
    qtile.current_window.togroup(group_name, switch_group=switch_group)


groups = [
    Group(
        name = str(screen) + group,
        label = group,
        screen_affinity = screen
    )
    for group in "123456789"
    for screen in range(num_screens)
] + [
    ScratchPad("0", [ DropDown(
        "keepass", "keepassxc",
        height=0.75, width=0.75,
        x=0.125, y=0.125, opacity=1,
    ) ])
]

for group in "123456789":
    keys.extend([
        Key([mod], group, group_to_screen(group), desc=f"Switch to group {group} on current screen"),
        # Key([mod], group, lazy.group["0" + group].toscreen(), desc=f"Switch to group {group} on current screen"),
        Key([mod, "shift"], group, window_to_group(group, switch_group=True), desc=f"Switch to * move focused window to group {group} on current screen"),
		Key([mod, "control"], group, window_to_group(group), desc=f"Move focused window to group {group} on current screen")
    ])
keys.append(Key([mod], "0", lazy.group["0"].dropdown_toggle("keepass")))
