function fish_prompt
  set prev_status $status
  printf '%s%s' (set_color -o green) $USER
  printf '%s@' (set_color -o green)
  printf '%s%s' (set_color -o green) $hostname
  printf '%s:' (set_color -o white)
  printf '%s%s' (set_color -o brblue) (prompt_pwd)

  printf '%s %s' (set_color -o brblue) (ls | wc -l)
  if test $prev_status -eq 0;
    printf '%s❯' (set_color -o normal)
  else
    printf '%s❯' (set_color -o red)
  end

  printf '%s ' (set_color -o normal)
end

function fish_title
  pwd
end

function fish_greeting
end

function go_to_directory
  cd (/home/sam/bin/important_dirs)
  echo
  fish_prompt
end

function fish_help
  echo
  echo help:
  echo "	ctrl+e:	Edit command"
  echo "	ctrl+h:	Help"
  echo "	ctrl+o:	Open file"
  echo "	ctrl+g:	Go to directory"
  fish_prompt
end

if status is-interactive
  fish_add_path ~/bin
  fish_add_path /usr/local/bin
  fish_add_path /usr/sbin/
  export EDITOR=nvim
  export PATH="$HOME/.cargo/bin:$PATH"

  # Man colors
  set -x LESS_TERMCAP_mb (printf "\e[1;32m")
  set -x LESS_TERMCAP_md (printf "\e[1;32m")
  set -x LESS_TERMCAP_me (printf "\e[0m")
  set -x LESS_TERMCAP_se (printf "\e[0m")
  set -x LESS_TERMCAP_so (printf "\e[01;33m")
  set -x LESS_TERMCAP_ue (printf "\e[0m")
  set -x LESS_TERMCAP_us (printf "\e[1;4;31m")

  set fish_prompt_pwd_dir_length 0 # Disable CWD shortening

  # Bindings
  bind \ca "git log --oneline"
  bind \ce edit_command_buffer
  bind \cg go_to_directory
  bind \ch fish_help
  bind \co "nvim (nvim --headless -c 'echo v:oldfiles | q' &> /tmp/recent_files && cat ~/bin/recent_files >> /tmp/recent_files && sed 's/\', \'/\n/g' /tmp/recent_files | sed 's/\[\'/\n/g' | sed 's/\'\]/\n/g' | fzf)"
  bind \cs "git status"
  bind \ct "echo; countdown '5 minutes'"
  bind \cv "nvim -S Session.vim"
  bind \cw weight_goal
  bind \cy "echo; countdown '1 minutes'"

  # Aliases
  alias analog 'pacmd set-card-profile 0 output:analog-stereo'
  alias ca "terminal_calendar -c nvim"
  alias clippy 'cargo clippy -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used'
  alias clippy-fix 'cargo clippy --fix -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used'
  alias hdmi 'pacmd set-card-profile 0 output:hdmi-stereo'
  alias ls '/bin/ls --color=auto'
  alias plugin "nvim .config/nvim/vim/load_plugins.vim"
  alias r ranger
  alias s /home/sam/audio/rust/target/debug/rust
  alias t task
  alias ta "task add REPLACEME project:REPLACEME; task +LATEST edit; task list"
  alias tl "task list"
  alias trep "task projects; task list; task calendar"
  alias v nvim
  alias weight 'echo (date; printf ": "; read -p "echo \"Enter Weight: \"") >> ~/text/weight; cat ~/text/weight'
end