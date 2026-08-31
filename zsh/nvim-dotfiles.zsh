# starship prompt (pwd, git branch/status, time)
eval "$(starship init zsh)"

# switch Terminal.app color profile: theme [light|dark|toggle]
theme() {
  local target="$1" current
  current=$(osascript -e 'tell application "Terminal" to name of current settings of front window' 2>/dev/null)
  case "$target" in
    light) target="Mono Light" ;;
    dark) target="Mono Dark" ;;
    toggle|"")
      [[ "$current" == "Mono Dark" ]] && target="Mono Light" || target="Mono Dark"
      ;;
    *)
      echo "usage: theme [light|dark|toggle]" >&2
      return 1
      ;;
  esac
  osascript -e "tell application \"Terminal\"
    set current settings of front window to settings set \"$target\"
    set default settings to settings set \"$target\"
  end tell" >/dev/null

  if [[ -n "$TMUX" ]]; then
    local mode="dark"
    [[ "$target" == "Mono Light" ]] && mode="light"
    tmux source-file "$HOME/dotfiles/tmux/theme-$mode.conf" 2>/dev/null
  fi

  echo "theme: $target"
}
