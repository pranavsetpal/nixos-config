#!/bin/sh

# XDG Desktop Portal
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP
systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
systemctl --user start wireplumber

# Display config
wlr-randr \
	--output eDP-1 --pos 0,0 --scale 1.5 \
	--output DP-1 --pos 0,1200 --scale 1.5

wlr-randr \
	--output eDP-1 --pos 0,0 --scale 1.5 \
	--output DP-1 --pos 0,1200 --scale 1.5
