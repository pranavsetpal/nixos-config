#!/bin/sh

# XDG Desktop Portal
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP
systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
systemctl --user start wireplumber

# Display DPI
kanshi
