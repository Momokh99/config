#!/usr/bin/env bash

# Launch centered selector using Rofi's positioning
choice=$(rofi -dmenu -p "\ue7a2 AI:" -location 1 -theme-str "
  window {
    width: 200px;
  }
  entry {
    placeholder: \"Choose Assistant...\";
  }
  listview {
    lines: 4;
    fixed-height: true;
  }" <<< "DeepSeek
Claude
ChatGPT
Gemini")

# Handle selection
case "$choice" in
  "DeepSeek") nohup xdg-open "https://chat.deepseek.com" >/dev/null 2>&1 & ;;
  "Claude") nohup xdg-open "https://claude.ai" >/dev/null 2>&1 & ;;
  "ChatGPT") nohup xdg-open "https://chat.openai.com" >/dev/null 2>&1 & ;;
  "Gemini") nohup xdg-open "https://gemini.google.com" >/dev/null 2>&1 & ;;
  *) notify-send "AI Launcher" "No valid selection made." ;;
esac
