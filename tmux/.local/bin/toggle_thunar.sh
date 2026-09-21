#!/usr/bin/env bash

shell_eval() {
  gdbus call --session \
    --dest org.gnome.Shell \
    --object-path /org/gnome/Shell \
    --method org.gnome.Shell.Eval "$1"
}

RAW=$(
  shell_eval '
    (function () {
      function isThunar(win) {
        if (!win) return false;
        let c = win.get_wm_class();
        return c && c.toLowerCase().includes("thunar");
      }

      let focused = global.display.focus_window;

      if (isThunar(focused)) {
        focused.minimize();
        return "minimized";
      }

      let actors = global.get_window_actors();
      for (let a of actors) {
        let w = a.meta_window;
        if (isThunar(w)) {
          w.activate(global.get_current_time());
          return "activated";
        }
      }

      return "none";
    })()
  ' 2>/dev/null
)

# If Eval is disabled, GNOME returns (false, '...')
if [[ "$RAW" != \(true,* ]]; then
  echo "ERROR: GNOME Shell Eval failed/disabled: $RAW" >&2
  exit 1
fi

# Quick/robust extraction: look for minimized/activated/none anywhere in the payload
if   [[ "$RAW" == *"minimized"* ]]; then RESULT="minimized"
elif [[ "$RAW" == *"activated"* ]]; then RESULT="activated"
elif [[ "$RAW" == *"none"*      ]]; then RESULT="none"
else RESULT="unknown"
fi

echo "$RESULT"

if [[ "$RESULT" == "none" ]]; then
  thunar "$HOME" >/dev/null 2>&1 &
fi
