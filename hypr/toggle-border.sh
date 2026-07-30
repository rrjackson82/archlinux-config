#!/usr/bin/bash
set -eu

PLUGIN="hyprbars"
HYPRVAR="$HOME/.config/hypr/vars/hyprbar"
ENABLED="$(cat $HYPRVAR)"

if [ $ENABLED = "1" ]; then
  hyprpm disable "$PLUGIN"
  printf '0\n' >$HYPRVAR
else
  hyprpm enable "$PLUGIN"
  printf '1\n' >$HYPRVAR
fi

hyprpm reload
