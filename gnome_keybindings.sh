#!/bin/bash

# Remove conflicting keybindings for Super+1..9 and Shift+Super+1..9
for i in {1..9}; do
    key_super="<Super>$i"
    key_shift_super="<Shift><Super>$i"

    # Check all schemas that might contain custom keybindings
    for schema in $(gsettings list-schemas); do
        keys=$(gsettings list-keys "$schema" 2>/dev/null)
        for key in $keys; do
            current=$(gsettings get "$schema" "$key" 2>/dev/null)
            if [[ "$current" == *"$key_super"* || "$current" == *"$key_shift_super"* ]]; then
                echo "Unsetting $schema $key (was $current)"
                gsettings set "$schema" "$key" "[]"
            fi
        done
    done
done

# Now explicitly set workspace keybindings for org.gnome.desktop.wm.keybindings
for i in {1..9}; do
    index=$((i))

    gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$index" "['<Super>$i']"
    gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$index" "['<Shift><Super>$i']"
done
